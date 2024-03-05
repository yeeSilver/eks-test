# Helm
[helm](https://helm.sh/) 공식 홈페이지  
2019년 11월 13일 helm v3 릴리즈  

<img src=img/helm.png width=15% style="margin-left: auto; margin-right: auto; display:block"/>

# 1. 사전 요구사항
- Kubernetes가 설치되어 있어야 한다.
- helm이 설치될 시스템에 kubectl이 설치되어 있어야 한다.
- kubectl은 적절한 구성(~/.kube/config)으로 Kubernetes 클러스터에 접근할 수 있어야 한다.

# 2. Helm 설치
각 운영체제의 Helm 바이너리는 [릴리즈](https://github.com/helm/helm/releases)에서 수동으로 다운로드 받을 수 있다.

## 1) macOS (with homebrew)
```bash
brew install helm
```

> 참고: [homebrew](https://brew.sh/) 링크
> ```bash
> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
> ```

## 2) Windows (with Chocolatey)
```bash
choco install kubernetes-helm
```

> 참고: [Chocolatey](https://chocolatey.org/) 링크
> ```powershell
> Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
> ```

## 3) Ubuntu (with snap)
```bash
sudo snap install helm --classic
```

## 4) Linux (with shell script)
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```

# 3. Helm 기본 개념
- 차트(Chart): Helm 패키지
- 저장소(Repository): Helm 차트 저장소
- 릴리즈(Release): Kubernetes 클러스터에서 실행 차트의 인스턴스

<img src=img/helm3-arch.png width=70% style="margin-left: auto; margin-right: auto; display:block"/>

# 4. Helm 사용
> 참고: Helm v2와 Helm v3는 명령어 사용법이 다르다

## 1) Helm 차트 검색 및 저장소
- ```helm search hub```: [Helm Hub](https://hub.helm.sh/)에서 차트를 검색한다.
- ```helm search repo```: ```helm repo add``` 명령으로 추가한 저장소에서 차트를 검색한다.

> <참고>  
> Helm v3는 처음부터 기본 저장소가 없다.  
> Helm v2는 처음부터 stable이란 이름의 기본 저장소가 있다.

### Helm Hub 검색
```bash
$ helm search hub mysql

URL                                               	CHART VERSION	APP VERSION	DESCRIPTION
...
https://hub.helm.sh/charts/stable/mysql           	1.6.2        	5.7.28     	Fast, reliable, scalable, and easy to use open-...
...
```

### Helm 차트 저장소 추가
- ```helm repo add [NAME] <URL>```

```bash
$ helm repo list

Error: no repositories to show
```

```bash
$ helm repo add stable https://kubernetes-charts.storage.googleapis.com/

"stable" has been added to your repositories
```

> 참고  
> Helm 차트 기본 저장소: https://kubernetes-charts.storage.googleapis.com/

```bash
$ helm repo list

NAME  	URL
stable	https://kubernetes-charts.storage.googleapis.com/
```

### Helm 차트 저장소 검색
```bash
$ helm search repo mysql

NAME                            	CHART VERSION	APP VERSION	DESCRIPTION
stable/mysql                    	1.6.2        	5.7.28     	Fast, reliable, scalable, and easy to use open-...
stable/mysqldump                	2.6.0        	2.4.1      	A Helm chart to help backup MySQL databases usi...
stable/prometheus-mysql-exporter	0.5.2        	v0.11.0    	A Helm chart for prometheus mysql exporter with...
stable/percona                  	1.2.1        	5.7.26     	free, fully compatible, enhanced, open source d...
stable/percona-xtradb-cluster   	1.0.3        	5.7.19     	free, fully compatible, enhanced, open source d...
stable/phpmyadmin               	4.3.3        	5.0.1      	phpMyAdmin is an mysql administration frontend
stable/gcloud-sqlproxy          	0.6.1        	1.11       	DEPRECATED Google Cloud SQL Proxy
stable/mariadb                  	7.3.12       	10.3.22    	Fast, reliable, scalable, and easy to use open-...
```

### Helm 차트 저장소 최신 목록 업데이트
```bash
$ helm repo update

Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "stable" chart repository
Update Complete. ⎈ Happy Helming!⎈
```

### Helm 차트 저장소 삭제
```bash
$ helm repo remove stable
```

### Helm 차트 저장소의 전체 차트 목록 확인
Helm Hub 전체 차트 목록 확인
```bash
$ helm search hub
```

Helm 저장소 전체 차트 목록 확인
```bash
$ helm search repo
```

Helm stable 저장소 전체 차트 목록 확인
```bash
$ helm search repo stable
```

## 2) Helm 차트 정보 확인
- ```helm show chart [CHART]```: 차트 정보(버전, 홈페이지, 키워드, 소스 주소 등)
- ```helm show readme [CHART]```: 차트 설명(사용법, 파라미터 등)
- ```helm show values [CHART]```: 차트 설정 파라미터
- ```helm show all [CHART]```: Chart, Readme, Values

## 3) Helm 차트 설치 및 관리

### Helm 차트 설치
- ```helm install [NAME] [CHART] [FLAGS]```

```bash
$ helm install mydb stable/mysql

NAME: mydb
LAST DEPLOYED: Fri Mar  6 14:53:40 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mydb-mysql.default.svc.cluster.local
...
```

### Helm 차트 목록 확인
```bash
$ helm list

NAME	NAMESPACE	REVISION	UPDATED                             	STATUS  	CHART      	APP VERSION
mydb	default  	1       	2020-03-06 14:53:40.223685 +0900 KST	deployed	mysql-1.6.2	5.7.28
```

### Kubernetes 리소스 배포 확인
```bash
$ kubectl get all

NAME                              READY   STATUS    RESTARTS   AGE
pod/mydb-mysql-5fc7db88dd-s8vmr   1/1     Running   0          29m

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP    44d
service/mydb-mysql   ClusterIP   10.96.219.201   <none>        3306/TCP   29m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/mydb-mysql   1/1     1            1           29m

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/mydb-mysql-5fc7db88dd   1         1         1       29m
```

### Helm 차트 상태 확인
```bash
$ helm status mydb

NAME: mydb
LAST DEPLOYED: Fri Mar  6 14:53:40 2020
NAMESPACE: default
`**`STATUS: deployed`**`
REVISION: 1
NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mydb-mysql.default.svc.cluster.local
...
```

### Helm 차트 삭제 및 확인
```bash
$ helm uninstall mydb

release "mydb" uninstalled
```

```bash
$ helm list

NAME	NAMESPACE	REVISION	UPDATED	STATUS	CHART	APP VERSION
```

```bash
$ kubectl get all

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   44d
```
