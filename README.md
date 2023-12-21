# POC

1. run `git clone https://github.com/david-ruffin/POC.git` clone repo
4. run `cd POC`
5. add Azure credententials to env.tfvars file
6. run `terraform init`
7. run `terraform plan -var-file="env.tfvars"` to see what will be deployed
8. run `terraform apply -var-file="env.tfvars"` and type "yes" when prompted
9. Log into container using `docker run -it -v "$(pwd)/images:/data/Labfiles/01-analyze-images/Python/image-analysis/images2"`
10. run `cd Labfiles/01-analyze-images/Python/image-analysis/ && cat .env && python image-analysis.py images/street.jpg` to confirm creds and run analysis on image
11. To copy additional images to the images folder, `docker cp /path/to/local/images mycontainer:/data/Labfiles/01-analyze-images/Python/image-analysis/images`
12. run `terraform destroy -var-file="env.tfvars"` to destroy environment

# pre-req
- Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Docker - ensure it doesnt require sudo
- Git
