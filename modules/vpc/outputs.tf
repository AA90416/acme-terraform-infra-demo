
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "webserver_sg_id" {
  description = "The ID of the webserver security group"
  value       = aws_security_group.webserver_sg.id
}

output "elb_sg_id" {
  description = "The ID of the ELB security group"
  value       = aws_security_group.elb_sg.id
}

output "pub_sub1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.pub_sub1.id
}

output "pub_sub2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.pub_sub2.id
}

output "prv_sub1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.prv_sub1.id
}

output "prv_sub2_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.prv_sub2.id
}

