resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.aws-key.key_name
  subnet_id              = module.ksh-vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]
  count                  = 1

  provisioner "file" {
    content     = templatefile("script.tmpl", { rds-endpoint = aws_db_instance.vprofile-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/var/tmp/script.sh"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("key.txt")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /var/tmp/script.sh",
      "sudo /var/tmp/script.sh",
    ]
  }

}