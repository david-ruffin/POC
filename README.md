# POC

1. git clone
2. cd in POC
3. add variables to env.tfvars
4. run terraform init
5. run terraform plan -var-file="env-dev.tfvars" to see what will be deployed
6. run terraform apply -var-file="env-dev.tfvars" and type "yes" when prompted


# pre-req
Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
Docker
Git
