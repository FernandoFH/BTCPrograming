provider "aws" {
  region  = "us-east-1"
  profile = "fernando_demo" # Cambia esto por el nombre real de tu perfil
}

resource "aws_instance" "node_ln" {
  ami                         = "ami-020cba7c55df1f615"
  instance_type               = "t2.medium"
  subnet_id                   = "subnet-01d43f17226a2ea44"
  vpc_security_group_ids      = ["sg-0ae253154bdc55a07"]
  key_name                    = "node-ec2-ln"
  associate_public_ip_address = true

  credit_specification {
    cpu_credits = "standard"
  }

  cpu_options {
    core_count       = 2
    threads_per_core = 1
  }

  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
    iops                  = 3000
    throughput            = 125
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
    instance_metadata_tags      = "disabled"
    http_protocol_ipv6          = "disabled"
  }

  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }

  maintenance_options {
    auto_recovery = "default"
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  tags = {
    Name = "node-ln"
  }
}
