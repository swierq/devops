## Login to azure


```
az login

# Check subscriptions
az account list --query "[?user.name=='<email>'].{Name:name, ID:id, Default:isDefault}" --output Table

#switching subscription:
az account set --subscription "<subscription_id>"

```

## Running terraform


```
export ARM_PROVIDER_ENHANCED_VALIDATION=1                      
export ARM_SKIP_PROVIDER_REGISTRATION=true
tfswitch
terraform init
terraform apply
```

## Connect to PostgreSQL using docker

```
docker run -it --rm postgres psql -h tfpg-psql-server.postgres.database.azure.com -p 5432 -d tfpg-db -U psqladmin
```

## Cleanup

```
terraform destroy
```