# create vpc, eks and fargate profile
```sh
terraform plan -out plan
terraform apply plan
```

# setup kubeconfig
```sh
aws eks --region us-west-1 update-kubeconfig --name Demo
```

# update coredns
```sh
kubectl apply -f tools/update_coredns.sh
```

# deploy nginx
```sh
kubectl apply -f tools/nginx.yaml
```
