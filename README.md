## Store Terraform State in Azure
```bash

#!/bin/bash

RESOURCE_GROUP_NAME=terraform-backend-rg
STORAGE_ACCOUNT_NAME=terraform20220610
CONTAINER_NAME=tfstate

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

```


## Run
```bash
terraform apply -var-file="<env>.tfvars" -out=tfplan
terraform apply "tfplan"
```