module "cluster-eks" {
  source = "../../"
  subnet_ids = ["subnet-", "subnet-"]
  region = "us-east-1"
  ssh_key_location = "${file("~/.ssh/id_rsa.pub")}"
  cluster_name = "olga-eks-module"
  cluster_version = "1.15"
  instance_type = "t2.micro"
  node_desired_capacity = "2"
  node_min_size = "2"
  node_max_size = "5"
  security_group_ids = ["sg-"]
}
