## Login to aws


```
aws configure sso
aws sso login
```

## Running terraform


```
tfswitch
terraform init
terraform apply
```

## Connecting to a Cluster

```
aws eks update-kubeconfig --region eu-west-1 --name tf-eks
```
## Cleanup

```
terraform destroy
```