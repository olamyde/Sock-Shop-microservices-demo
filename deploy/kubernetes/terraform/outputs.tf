output "node_addresses" {
  value = ["${aws_instance.ci-sockshop-k8s-node.*.public_dns}"]
}

output "master_address" {
  value = "${aws_instance.ci-sockshop-k8s-master.public_dns}"
}

