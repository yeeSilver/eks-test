# README

```bash
terraform init
terraform plan
terraform apply
```

- EKS Cluster 생성 후 `Kubeconfig` 설정방법
```bash
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```

- Verify the Cluster
```bash
kubectl cluster-info
```

- Node 확인
```bash
kubectl get nodes
```

- Cleanup workspace
```bash
terraform destroy
```# eks-new-2
