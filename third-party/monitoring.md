# Monitoring

## 메트릭 서버
- Deploy Metrics Server
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

- 확인
```bash
kubectl get deployment metrics-server -n kube-system
```

## Helm 배포# Monitoring

## 메트릭 서버
- Deploy Metrics Server
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

- 확인
```bash
kubectl get deployment metrics-server -n kube-system
```

## Helm 배포

```bash
kubectl create ns monitoring
```

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

```bash
helm pull prometheus-community/kube-prometheus-stack --version 45.7.1     
tar -xvzf kube-prometheus-stack-45.7.1.tgz 
cd kube-prometheus-stack         
```

- values 파일생성
```yaml
cat <<EOT > monitor-values.yaml
grafana:
  defaultDashboardsTimezone: Asia/Seoul
  adminPassword: prom-operator
  service:
    type: LoadBalancer
    annotations: |
      service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
      service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "ip"

prometheus:
  service:
    type: LoadBalancer
    annotations: |
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
      service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
  prometheusSpec:
    podMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false
    retention: 5d
    retentionSize: "10GiB"
EOT
```

```bash
helm install kube-prometheus-stack -f monitor-values.yaml --namespace monitoring .
```

> 참고 :   
> Grafana Dashboard : https://grafana.com/grafana/dashboards/13332-kube-state-metrics-v2/


- 접속방법 : 아래 명령 결과로 확인한 값으로 접속
```bash
kubectl get svc -n monitoring kube-prometheus-stack-grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

```bash
kubectl create ns monitoring
```

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

```bash
helm pull prometheus-community/kube-prometheus-stack --version 45.7.1     
tar -xvzf kube-prometheus-stack-45.7.1.tgz 
cd kube-prometheus-stack         
```

- values 파일생성
```yaml
cat <<EOT > monitor-values.yaml
grafana:
  defaultDashboardsTimezone: Asia/Seoul
  adminPassword: prom-operator
  service:
    type: LoadBalancer
    annotations: |
      service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
      service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: "ip"

prometheus:
  service:
    type: LoadBalancer
    annotations: |
      service.beta.kubernetes.io/aws-load-balancer-type: nlb
      service.beta.kubernetes.io/aws-load-balancer-scheme: "internet-facing"
      service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
  prometheusSpec:
    podMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false
    retention: 5d
    retentionSize: "10GiB"
EOT
```

```bash
helm install kube-prometheus-stack -f monitor-values.yaml --namespace monitoring .
```

> 참고 :   
> Grafana Dashboard : https://grafana.com/grafana/dashboards/13332-kube-state-metrics-v2/