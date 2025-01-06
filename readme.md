# TiDB on Kubernetes

[Get Started with TiDB on Kubernetes](https://docs.pingcap.com/tidb-in-kubernetes/stable/get-started)

## Steps

```bash
kubectl create -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml
skaffold run -m tidb-operator
skaffold run -m tidb-cluster
skaffold run -m tidb-dashboard
skaffold run -m tidb-monitor
```

Clean up:

```bash
skaffold delete -m tidb-monitor
skaffold delete -m tidb-dashboard
skaffold delete -m tidb-cluster
skaffold delete -m tidb-operator
kubectl delete -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml
```