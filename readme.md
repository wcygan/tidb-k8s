# TiDB on Kubernetes

[Get Started with TiDB on Kubernetes](https://docs.pingcap.com/tidb-in-kubernetes/stable/get-started)

## Steps

### Deployment

```bash
kubectl create -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml
skaffold run -m tidb-operator
skaffold run -m tidb-cluster
skaffold run -m tidb-dashboard
skaffold run -m tidb-monitor
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

### Clean up

```bash
skaffold delete -m tidb-monitor
skaffold delete -m tidb-dashboard
skaffold delete -m tidb-cluster
skaffold delete -m tidb-operator
kubectl delete -f https://raw.githubusercontent.com/pingcap/tidb-operator/v1.6.1/manifests/crd.yaml
```