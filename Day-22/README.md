# Project 01

## 1. Configuring Jobs and Targets

Task: Set up a Prometheus server to monitor multiple services running on different nodes.

Deliverables:
Configure Prometheus with jobs for monitoring different services like web servers, databases, and system metrics.

![alt text](img/image1.png)

Define static and dynamic targets using file-based and service discovery methods (e.g., Consul or Kubernetes).
```yaml
global:
  scrape_interval: 15s

rule_files:
  - 'prometheus.rules.yml'

scrape_configs:

  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9100']

  - job_name: 'blackbox_exporter'
    scrape_interval: 5s
    static_configs:
      - targets:
        - localhost:9115
        labels:
          group: 'production'

  - job_name: 'grafana'
    scrape_interval: 5s
    static_configs:
      - targets:
        - localhost:3000

alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093

```
## 2. Using Exporters (Node Exporter)

Task: Use Node Exporter to monitor system-level metrics like CPU, memory, disk usage, and network statistics.



Deliverables:
Install and configure Node Exporter on all nodes.
```bash 
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz

tar xvfz node_exporter-1.3.1.linux-amd64.tar.gz

cd node_exporter-1.3.1.linux-amd64

./node_exporter &
```

![alt text](img/image3.png)

![alt text](img/image4.png)

Ensure Node Exporter metrics are being correctly scraped by Prometheus.

![alt text](img/image5.png)


## 3. Hands-on Exercise: Setting Up Exporters

Task: Configure at least two different types of exporters (e.g., Node Exporter and MySQL Exporter) and integrate them with Prometheus.

```bash
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.13.0/mysqld_exporter-0.13.0.linux-amd64.tar.gz

tar xvfz mysqld_exporter-0.13.0.linux-amd64.tar.gz

cd mysqld_exporter-0.13.0.linux-amd64

./mysqld_exporter &


```

![alt text](img/image6.png)
```yaml
  - job_name: 'aws_node_exporter'
    scrape_interval: 5s
    static_configs:
      - targets:
        - 3.82.211.37:9100

  - job_name: 'aws_mysql_exporter'
    scrape_interval: 5s
    static_configs:
      - targets:
        - 3.82.211.37:9104
```

![alt text](img/image7.png)

Deliverables:
Demonstrate successful data collection from both exporters.
Create a basic Prometheus dashboard to visualize key metrics from these exporters.

## 4. Introduction to PromQL

Task: Learn and implement basic PromQL queries to extract meaningful data from the metrics collected.

Node CPU Usage :

```bash
    avg(rate(node_cpu_seconds_total[5m])) by (instance)
```

![alt text](img/image8.png)

Memory Consumption:
```bash
node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes * 100

```

![alt text](img/image9.png)

Disk I/O Over Time:

```bash
rate(node_disk_io_time_seconds_total[5m])
```

![alt text](img/image10.png)

Deliverables:
Write basic queries to retrieve metrics like average CPU usage, memory consumption, and disk I/O over time.

## 5. Basic Queries (Selectors, Functions, Operators)

Task: Create PromQL queries using selectors, functions, and operators to filter and manipulate time-series data.

95th Percentile of CPU Usage:
```promql
histogram_quantile(0.95, rate(node_cpu_seconds_total_bucket[5m])) by (instance)
```

Rate of Increase in Requests:

```promql
rate(http_requests_total[5m])
```
Memory Usage Increase:
```promql
increase(node_memory_MemUsed_bytes[1h])
```

Deliverables:
Write PromQL queries to calculate the 95th percentile of CPU usage.
Use functions like rate(), increase(), and histogram_quantile() to perform more complex analysis.

## 6. Advanced Queries and Aggregations

Task: Perform advanced data aggregation using PromQL.

Total Memory Usage Across Nodes:
```promql
sum(node_memory_MemUsed_bytes)
```
Maximum Disk Space Usage Among Nodes:
```promql
max(node_filesystem_size_bytes - node_filesystem_free_bytes)
```
Deliverables:
Write queries to calculate the total memory usage across all nodes.
Aggregate data to find the maximum disk space usage among all nodes.

## 7. Configuring Alertmanager

Task: Set up Alertmanager to handle alerts generated by Prometheus.

Peometheus yaml configration for alert manager:
```yaml
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093
```
![alt text](img/image11.png)

Deliverables:
Configure Alertmanager with Prometheus.
Create routing rules to manage alert notifications based on severity and service type.

## 8. Writing Alerting Rules

Task: Write custom alerting rules in Prometheus to trigger alerts based on specific conditions.

```yaml
groups:
  - name: low_disk
    rules:
      - alert: LowDiskSpace
        expr: node_filesystem_free_bytes / node_filesystem_size_bytes < 0.10
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Low Disk Space on instance {{ $labels.instance }}"
          description: "Disk space is below 10%."

  - name: high_cpu
    rules:
      - alert: HighCPUUsage
        expr: avg(rate(node_cpu_seconds_total[5m])) by (instance) > 0.85
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High CPU Usage on instance {{ $labels.instance }}"
          description: "CPU usage is above 85% for more than 2 minutes."
```

![alt text](img/image12.png)

Deliverables:
Create alerting rules for high CPU usage, memory leaks, and disk space running low.
Ensure alerts are correctly generated and sent to Alertmanager.

## 9. Setting Up Notification Channels (Email, Slack, etc.)

Task: Integrate Alertmanager with multiple notification channels like Email and Slack.
sample alertmanager configuration file :
```yaml
route:
  receiver: 'email'
  group_by: ['alertname']

receivers:
  - name: 'email'
    email_configs:
      - to: 'admin@example.com'
        from: 'prometheus@example.com'
        smarthost: 'smtp.example.com:587'
        auth_username: 'user'
        auth_password: 'password'

  - name: 'slack'
    slack_configs:
      - api_url: 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX'
        channel: '#alerts'
```
Deliverables:
Set up Email notifications for critical alerts.
Integrate Slack for real-time alerts and notifications.

## 10. Hands-on Exercise: Creating Alerts

Task: Test the entire alerting pipeline by creating and triggering custom alerts.

![alt text](img/image13.png)

![alt text](img/image14.png)

![alt text](img/image15.png)

Deliverables:
Simulate a scenario where a node exceeds 90% CPU usage and ensure alerts are triggered and sent to both Email and Slack.
Validate the alerts in both notification channels.

