# clogged-toilet-reporter

A function receiving AWS IoT Button push and call by Amazon Connect

## Requirements
- Node.js 10.0.0+
- Terraform 0.12+

## Deploy
```sh
$ npm run build
$ terraform init
$ terraform plan --out terraform.tfplan
$ terraform apply terraform.tfplan 
```
