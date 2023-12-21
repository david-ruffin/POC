# POC

1. Clone repo
   ```
   git clone https://github.com/david-ruffin/POC.git
   ```
2. Change directory
   ```
   cd POC
   ```
3. Add Azure credententials to env.tfvars file
4. Initialize Terraform environment
   ```
   terraform init
   ```
5. Display resources that will be created
   ```
   terraform plan -var-file="env.tfvars"
   ``` 
6. Deploy environment
   ```
   terraform apply -var-file="env.tfvars" -auto-approve
   ```
7. Log into container and mount the local images folder. Dynamically add images to this folder if you want them analyized
   ```
   docker run -it -v "$(pwd)/images:/data/Labfiles/01-analyze-images/Python/image-analysis/images2"
   ```
10. Run the following command to list creds and run analysis on default image
    ```
    cd Labfiles/01-analyze-images/Python/image-analysis/ && cat .env && python image-analysis.py images/street.jpg
    ```
# Destroy Environment
```
terraform destroy -var-file="env.tfvars"
```

# pre-req
- Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- Docker - ensure it doesnt require sudo
- Git
