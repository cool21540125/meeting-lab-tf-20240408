使用 Terraform 建立 VPC Networking

---

![meeting-lab-infra.jpg](./images/meeting-lab-infra.jpg)

開 2 台 EC2

- 一台位於 DMZ, 開放 22/80/443 給 MyIP
- 一台位於 private (只允許由 dmz_sg 的 security group 來訪 22 & 3306 port)

開 1 台 RDS

- 位於 private (只允許由 dmz_sg 的 security group 來訪 22 & 3306 port)

---


## 1. create backend bucket using terraform

```bash
cd backend

# 參考 terraform.tfvars.example
cat terraform.tfvars
# 配置要使用的 backend bucket name

terraform init
terraform plan
terraform apply

```


## 2. create infra using terraform


```bash
cd application

# 參考 terraform.tfvars.example
cat terraform.tfvars
# 配置 my_ip
# 預先建立好 2 把 key-pair
#   一把用來 local -> dmz ec2        - 使用 dmz-key
#   一把用來 dmz ec2 -> private ec2  - 使用 priv-key

terraform init
terraform plan
terraform apply
```


## 3. verify

```bash
cat connection.json | jq
```


## 4. scripts

