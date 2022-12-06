resource "aws_ecs_cluster" "quest" {
  name = var.base_name
}

resource "aws_ecs_service" "quest" {
  name            = var.base_name
  cluster         = aws_ecs_cluster.quest.id
  task_definition = aws_ecs_task_definition.quest.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.quest-task.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.quest.arn
    container_name   = var.base_name
    container_port   = 3000
  }

  depends_on = [aws_lb.quest]
}
