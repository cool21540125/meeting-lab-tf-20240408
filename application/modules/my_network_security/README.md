
建立一個 Security Group

egress rule 依照預設, 全數放行

ingress rule 則須在 client 自行指定 RULE: `sg_ingress_rules=RULE`

RULE 如下:

```js
{
  ingress = {
    "sg-rule-1" = {
      cidr_ipv4   = "YourIP/32"
      ip_protocol = "tcp"
      from_port   = 80
      to_port     = 80
    }
    "sg-rule-2" = {
      cidr_ipv4   = "YourIP/32"
      ip_protocol = "tcp"
      from_port   = 443
      to_port     = 443
    }
  }
}
```

或者

```js
{
  ingress = {
    "sg-rule-1" = {
      referenced_security_group_id = SECURITY_GROUP_ID
      ip_protocol                  = "tcp"
      from_port                    = 22
      to_port                      = 22
    }
  }
}
```
