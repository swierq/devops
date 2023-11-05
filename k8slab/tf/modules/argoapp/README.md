<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.6 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.16.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.16.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.argo_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | App Name. | `string` | n/a | yes |
| <a name="input_app_namespace"></a> [app\_namespace](#input\_app\_namespace) | App Namespace. | `string` | n/a | yes |
| <a name="input_argo_project"></a> [argo\_project](#input\_argo\_project) | Argo Project Name. | `string` | `"default"` | no |
| <a name="input_repo_path"></a> [repo\_path](#input\_repo\_path) | Repository Path. | `string` | n/a | yes |
| <a name="input_repo_url"></a> [repo\_url](#input\_repo\_url) | Repository URL. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->