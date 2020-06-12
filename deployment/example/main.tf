module "cluster-eks" {
  source = "../../"
  vpc_id = "vpc-fb85df81"
  subnet_ids = ["subnet-ec6b7fc2", "subnet-e2e6e885"]
  ssh_key_location = "${file("~/.ssh/id_rsa.pub")}"
  cluster_name = "olga-eks-module"
  instance_type = "t2.micro"
  asg_max_size = "5"
  asg_min_size = "2"
  cluster_version = "1.15"
  #s3_bucket = "eks-olga-project"
  region = "us-east-1"
  asg_desired_capacity = "2"
  security_group_ids = ["sg-0df6c36b0593ec3a5"]
}
