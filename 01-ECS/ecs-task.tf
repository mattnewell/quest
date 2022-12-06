resource "aws_iam_role" "quest-ecs-role" {
  name               = var.base_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "ecs-tasks.amazonaws.com"
        ]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "quest" {
  role = aws_iam_role.quest-ecs-role.name
  #TODO: This is not least-privileged, may scope down to a particular repo
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_ecs_task_definition" "quest" {
  family                   = var.base_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.quest-ecs-role.arn

  container_definitions = <<DEFINITION
[
  {
    "image": "566613373177.dkr.ecr.us-east-1.amazonaws.com/${var.base_name}:latest",
    "cpu": 256,
    "memory": 512,
    "name": "${var.base_name}",
    "networkMode": "awsvpc",
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "environment": [
      {
        "name": "SECRET_WORD",
        "value": "${var.secret_word}"
      }
    ]
  }
]
DEFINITION
}
