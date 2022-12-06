resource "aws_lb" "quest" {
  name = var.base_name
  # Clarify default
  load_balancer_type = "application"
  #TODO: refactor, used multiple places
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.quest-lb.id]
}

resource "aws_lb_target_group" "quest" {
  name        = var.base_name
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.quest.id
  target_type = "ip"
}

resource "aws_lb_listener" "redirect" {
  load_balancer_arn = aws_lb.quest.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "tls" {
  load_balancer_arn = aws_lb.quest.id
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.quest.arn

  default_action {
    target_group_arn = aws_lb_target_group.quest.id
    type             = "forward"
  }
}
