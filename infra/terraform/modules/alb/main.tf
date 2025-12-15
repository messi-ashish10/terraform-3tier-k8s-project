#Security Group for ALB
resource "aws_security_group" "alb"{
    name = "project-alb-sg"
    description = "Security group for ALB"
    vpc_id = var.vpc_id

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge(
        var.tags,{
            Name = "project-alb-sg"
        }
    )
}

#Target group
resource "aws_lb_target_group" "app"{
    name = "project-app-tg"
    port = var.app_port
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check{
        path = var.health_check_path
        interval = 30
        timeout = 5
        healthy_threshold = 2
        unhealthy_threshold = 2
        matcher = "200"
    }

    tags = merge(
        var.tags,{
            Name = "project-app-tg"
        }
    )
}

#Application Load Balancer
resource "aws_lb" "app"{
    name = "project-app-alb"
    load_balancer_type = "application"
    internal = false
    security_groups = [aws_security_group.alb.id]
    subnets = var.public_subnet_ids

    tags = merge(
        var.tags,{
            Name = "project-app-alb"
        }
    )
}

#Listener
resource "aws_lb_listener" "http"{
    load_balancer_arn = aws_lb.app.arn
    port = 80
    protocol = "HTTP"

    default_action{
        type = "forward"
        target_group_arn = aws_lb_target_group.app.arn
    }
}