# Note

建立一個 VPC, 並且綁定 Internet Gateway

VPC 內可含多個 subnets, 並且賦予必要的 route table

subnets 的規範, 可參考 [example-config.yaml](./example-config.yaml)

Public subnets 直接路由至 Interget gateway


# How to use

```hcl
module "my_network" {
  source              = "./modules/my_network"
  network_config_path = "./config/my_network.yaml"
}
```
