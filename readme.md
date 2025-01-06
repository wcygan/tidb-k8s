# TiDB on Kubernetes

TiDB is a distributed SQL database that provides horizontal scalability, strong consistency, and high availability. It is compatible with MySQL and can be deployed on Kubernetes.

[Get Started with TiDB on Kubernetes](https://docs.pingcap.com/tidb-in-kubernetes/stable/get-started)

## Quick Start

### Deployment

```bash
# Install the TiDB Operator CRDs
kubectl create -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml

# Deploy the TiDB Operator
skaffold run -m tidb-operator

# Deploy the rest of the TiDB Cluster
skaffold run -m tidb-cluster
skaffold run -m tidb-dashboard
skaffold run -m tidb-monitor

# Lastly, check the status of the TiDB cluster
kubectl get pods -n tidb-cluster
NAME                                 READY   STATUS    RESTARTS      AGE
example-discovery-6f87b545d4-7flxz   1/1     Running   0             52m
example-monitor-0                    4/4     Running   0             48m
example-pd-0                         1/1     Running   1 (52m ago)   52m
example-pd-1                         1/1     Running   0             52m
example-pd-2                         1/1     Running   0             52m
example-tidb-0                       2/2     Running   0             51m
example-tidb-1                       2/2     Running   0             51m
example-tidb-2                       2/2     Running   0             51m
example-tikv-0                       1/1     Running   0             51m
example-tikv-1                       1/1     Running   0             51m
example-tikv-2                       1/1     Running   0             51m
```

### Testing

```bash
# Get TiDB service
kubectl get svc -n tidb-cluster

# Forward port
kubectl port-forward -n tidb-cluster svc/example-tidb 14000:4000

# Install MySQL client
brew install mysql-client

# Connect to TiDB
mysql --comments -h 127.0.0.1 -P 14000 -u root

# Create a test database
mysql> use test;
Database changed

# Create a test table
mysql> create table hello_world (id int unsigned not null auto_increment primary key, v varchar(32));
Query OK, 0 rows affected (0.55 sec)
```

#### Connecting via Datagrip

Configure a new MySQL connection with the following settings:

- Host: localhost
- Port: 14000
- User: root
- Password: (empty)

Test the connection and you should be able to connect to the TiDB cluster.

Next, you can begin creating tables and running queries.

1. [init.sql](sql/init.sql)
2. [join.sql](sql/join.sql)
3. [subquery.sql](sql/subquery.sql)
4. [agg.sql](sql/agg.sql)

### Accessing the Grafana Dashboard

```bash
kubectl port-forward -n tidb-cluster svc/example-grafana 3000:3000
```

Visit http://localhost:3000/login

- Username: admin
- Password: admin

### Clean up

```bash
skaffold delete -m tidb-monitor
skaffold delete -m tidb-dashboard
skaffold delete -m tidb-cluster
skaffold delete -m tidb-operator
kubectl delete -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml
```