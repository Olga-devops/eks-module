module "cluster-eks" {
  source = "../../"
  vpc_id = "vpc-fb85df81"
  subnet_ids = ["subnet-ec6b7fc2", "subnet-e2e6e885"]
  region = "us-east-1"
  ssh_key_location = "${file("~/.ssh/id_rsa.pub")}"
  cluster_name = "olga-eks-module-test"
  cluster_version = "1.15"
  instance_type = "t2.micro"
  node_desired_capacity = "2"
  node_min_size = "2"
  node_max_size = "5"
  #s3_bucket = "eks-olga-project"
  #security_group_ids = ["sg-0df6c36b0593ec3a5"]
}
