# Development
```
aws_access_key=AAAAAAAAAAA
aws_secret_key=12121212121212

packer build -var-file=environment/variables-dev.json packer-template.json -var 'aws_access_key=${aws_access_key}' -var 'aws_secret_key=${aws_secret_key}'
```

# Production
```
aws_access_key=AAAAAAAAAAA
aws_secret_key=12121212121212

packer build -var-file=environment/variables-prod.json packer-template.json -var 'aws_access_key=${aws_access_key}' -var 'aws_secret_key=${aws_secret_key}'
```