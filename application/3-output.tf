output "out_dmz_ec2" {
  value = {
    key_name = aws_key_pair.my_public_key.key_name
    private  = aws_instance.my_dmz_ec2_instance.private_ip
    public   = aws_instance.my_dmz_ec2_instance.public_ip
  }
}


output "out_private_ec2" {
  value = {
    key_name = aws_key_pair.my_public_key.key_name
    private  = aws_instance.my_private_ec2_instance.private_ip
    public   = ""
  }
}
