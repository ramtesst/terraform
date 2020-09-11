output "instance_ip_addr" {
  value = aws_instance.machine1.*.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.machine1.*.private_ip
}

output "instance_state" {
  value = aws_instance.machine1.instance_state
}
