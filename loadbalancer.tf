#Create Load Balancer for front end EC2 Instances
resource "aws_lb" "prod-alb-public" {
  name               = "prod-alb-public"
  internal           = false
  load_balancer_type = "application"
  subnets         = [aws_subnet.prod-subnet-public[1].id, aws_subnet.prod-subnet-public[0].id]
  security_groups = [aws_security_group.prod_alb_pub_sg.id]
  tags            = local.common_tags
  depends_on      = [aws_security_group.prod_alb_pub_sg]
}

resource "aws_lb_listener" "prod-alb-public-lsitener" {
  load_balancer_arn = aws_lb.prod-alb-public.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod-alb-public-tg.arn
  }
}

#Create Load Balancer for application tier EC2 Instances
resource "aws_lb" "prod-alb-private" {
  name               = "prod-alb-private"
  internal           = true
  load_balancer_type = "application"
  subnets         = [aws_subnet.prod-subnet-private[1].id, aws_subnet.prod-subnet-private[0].id]
  security_groups = [aws_security_group.prod_alb_private_sg.id]
  tags            = local.common_tags
  depends_on      = [aws_security_group.prod_alb_private_sg]
}

resource "aws_lb_listener" "prod-alb-private-lsitener" {
  load_balancer_arn = aws_lb.prod-alb-private.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod-alb-private-tg.arn
  }
}
