resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "aws-key"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  availability_zone      = var.zone


 provisioner "file" {
    source      = "script.sh"
    destination = "/var/tmp/script.sh"
  }

connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("key.txt")
    host     = self.public_ip
  }

 provisioner "remote-exec" {
    inline = [
      "chmod +x /var/tmp/script.sh",
      "sudo /var/tmp/script.sh",
    ]
  }




}