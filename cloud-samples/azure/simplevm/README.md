## Login to azure


```
az login

# Check subscriptions
az account list --query "[?user.name=='<email>'].{Name:name, ID:id, Default:isDefault}" --output Table

#switching subscription:
az account set --subscription "<subscription_id>"

```

## Runnin gterraform


```
export ARM_PROVIDER_ENHANCED_VALIDATION=1                      
export ARM_SKIP_PROVIDER_REGISTRATION=true
tfswitch
terraform init
terraform apply
```

## Ssh to vm


```
ssh tfps@<ip_from_tf_output>
```