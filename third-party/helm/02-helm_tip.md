# Helm Tip

## 1. Helm Install 2가지

### 1) Chart가 Local에 있을 경우

- helm으로 배포되는 환경이 private한 환경이거나, 원격지(remote)에 있는 chart 파일을 수정하여 따로 형상을 관리할 경우 주로 사용됩니다.

```bash
$ helm install {helm release name} --version 0.49.5 --values helm-1.13.7.yaml ./chart-file-dir
```

### 2) Chart가 Remote에 있을 경우

- helm으로 배포되는 환경이 public한 환경이거나, 원격지(remote)에 있는 chart를 그대로 사용 할 경우 주로 사용됩니다.

```bash
$ helm install {helm release name} --version 0.49.5 --values helm-1.13.7.yaml ./chart-file-dir
```

## 2. Helm Diff 

- 기존에 배포되어 있는 release와 upgrade로 인하여 변경되는 점을 기록하는 명령어로, release를 upgrade해야 할 경우 주로 사전에 사용됩니다.

### helm diff 사용하기

```bash
# 온라인 일 경우
$ helm plugin install https://github.com/databus23/helm-diff
# 오프라인 일 경우 
# download url: https://github.com/databus23/helm-diff/releases/download/v3.8.1/
$ helm plugin install ./diff-dir
# diff 예시
$ helm diff upgrade consul hashicorp/consul --namespace consul --version 0.40.0 --values /path/to/your/values.yaml
```
