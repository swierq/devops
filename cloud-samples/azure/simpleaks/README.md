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

## Connecting to a Cluster

```
echo "$(terraform output kube_config | sed '1d' - | sed  '$ d' -)" > ./azurek8s
export KUBECONFIG=./azurek8s
➜ kubectl get nodes
NAME                              STATUS   ROLES   AGE   VERSION
aks-default-57704483-vmss000000   Ready    agent   16m   v1.26.6
```
## Cleanup

```
terraform destroy
```