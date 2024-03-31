resource "aws_key_pair" "alamykey" {
  key_name   = "alamykey"
  public_key = file(var.Pub_Key_Path)
}