#Create ALB Public Target Group
resource "aws_lb_target_group" "prod-alb-public-tg" {
  name        = "prod-alb-public-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "instance"
}

#Associate Public Target Group
resource "aws_lb_target_group_attachment" "prod-alb-public-tg-registry" {
  target_group_arn = aws_lb_target_group.prod-alb-public-tg.arn
  target_id = element(aws_instance.prod-ec2-private[*].id, count.index)
  port       = 80
  count = 2
  depends_on = [aws_instance.prod-ec2-private]
}

#Create ALB Public Target Group
resource "aws_lb_target_group" "prod-alb-private-tg" {
  name        = "prod-alb-private-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.prod-vpc.id
  target_type = "instance"
}

#Associate Private Target Group
resource "aws_lb_target_group_attachment" "prod-alb-private-tg-registry" {
  target_group_arn = aws_lb_target_group.prod-alb-private-tg.arn
  target_id = element(aws_instance.prod-ec2-private[*].id, count.index)
  port       = 80
  count = 2
  depends_on = [aws_instance.prod-ec2-private]
}
