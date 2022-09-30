resource "aws_lb" "prod-alb-public" {
  name               = "prod-alb"
  internal           = false
  load_balancer_type = "application"
  # vpc_id = aws_vpc.prod-vpc
  subnets         = [aws_subnet.prod-subnet-public[1].id, aws_subnet.prod-subnet-public[0].id]
  security_groups = [aws_security_group.prod_alb_pub_sg.id]
  tags            = local.common_tags
  depends_on      = ["aws_security_group.prod_alb_pub_sg"]
}

resource "aws_lb_listener" "prod-alb-public-lsitener" {
  load_balancer_arn = aws_lb.prod-alb-public.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "80"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
