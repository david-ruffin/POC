# POC

1. run `git clone https://github.com/david-ruffin/POC.git` to clone repo
2. run `cd POC`
3. add Azure credententials to env.tfvars file
4. run `terraform init`
5. run `terraform plan -var-file="env.tfvars"` to see what will be deployed
6. run `terraform apply -var-file="env.tfvars"` and type "yes" when prompted
7. Log into container using `docker run -it open-ai-poc /bin/bash`
8. run `cd Labfiles/01-analyze-images/Python/image-analysis/ && cat .env && python image-analysis.py images/street.jpg` to confirm creds and run analysis on image
9. To copy additional images to the images folder, `docker cp /path/to/local/images mycontainer:/data/Labfiles/01-analyze-images/Python/image-analysis/images`
10. run `terraform destroy -var-file="env.tfvars"` to destroy environment

# pre-req
- Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Docker - ensure it doesnt require sudo
- Git
