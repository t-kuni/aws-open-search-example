# aws-open-search-example

This repository is sample code for running OpenSearch on AWS. It includes Terraform code and go code (running on Docker).

Node: Running Terraform creates resources on AWS. You will be charged until the resource is deleted, so please delete the resource when you are done using it.

# Requirements

* Terraform 1.3.2
* Docker

# Usage

1. Clone this repository.
2. Create tfvars file and set variables.

```
cp terraform/terraform.tfvars.sample terraform/terraform.tfvars
vi terraform/terraform.tfvars
```

| Name | Description |
| ---- | ----------- |
| aws_access_key_id | IAM user access key for creating resources |
| aws_secret_access_key | Secret key for IAM user to create resources |
| aws_region | Region in which the resource will be created |
| open_search_master_user_name | The name of the OpenSearch master user. Specify any string. It will be used later when logging into OpenSearch Dashboards. |
| open_search_master_user_password | Password for the OpenSearch master user. Specify any string. It will be used later when logging into OpenSearch Dashboards. |

3. Run Terraform (Create OpenSearch cluster on AWS).

Go to the `terraform` folder and execute the following command.  
It takes a long time. (In my case, it took about 20 to 40 minutes.)

```bash
cd terraform
terraform init
terraform apply
```

4. Create env file and set variables.

Go to the `src` folder and execute the following command

```bash
cp .env.sample .env
vi .env
```

| Name | Description |
| ---- | ----------- |
| OPEN_SEARCH_ENDPOINT | Set the value of `endpoint` to be displayed in `terraform output`. |
| OPEN_SEARCH_MASTER_USER_NAME | Set the value of `open_search_master_user_name` in `terraform.tfvars`. |
| OPEN_SEARCH_MASTER_USER_PASSWORD | Set the value of `open_search_master_user_password` in `terraform.tfvars`. |

5. Build container image.

```
docker build -t aws-open-search-example .
```

6. Run container.

```
# Insert documents.
docker run --env-file .env aws-open-search-example insertDocuments

# Search documents
docker run --env-file .env aws-open-search-example search

# Delete index
docker run --env-file .env aws-open-search-example deleteIndexes
```

7. Delete resources.

Go to the `terraform` folder and execute the following command.

```bash
terraform destroy
```