# POC

1. git clone
2. cd in POC
3. add variables to env.tfvars
4. run `terraform init`
5. run `terraform plan -var-file="env.tfvars"` to see what will be deployed
6. run `terraform apply -var-file="env.tfvars"` and type "yes" when prompted
7. Log into container using `docker run -it open-ai-poc /bin/bash`


# pre-req
- Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Docker - ensure docker can be ran with sudo
- Git

`cd Labfiles/01-analyze-images/Python/image-analysis/ && cat .env`
`python image-analysis.py images/street.jpg`

