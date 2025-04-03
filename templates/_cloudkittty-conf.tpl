{{- define "cloudkitty-conf" }}
[DEFAULT]
debug = {{ .Values.conf.debug }}

[collect]
collector = gnocchi
metrics_conf = /etc/cloudkitty/metrics.yml

[collector_gnocchi]
region_name = {{ .Values.conf.processor.region_name }}
auth_type = password
auth_section = keystone_authtoken

[fetcher]
backend = gnocchi

[fetcher_gnocchi]
resource_types = {{ .Values.conf.fetcher.gnocchi.resource_types }}
region_name = {{ .Values.conf.fetcher.gnocchi.region_name }}
auth_section = keystone_authtoken
since_days_ago = {{ .Values.conf.fetcher.gnocchi.since_days_ago }}

[fetcher_keystone]
keystone_version = 3
auth_section = keystone_authtoken

[keystone_authtoken]
auth_url = {{ .Values.conf.keystone.auth_url }}
project_name = {{ .Values.conf.keystone.project_name }}
project_domain_name = Default
username = {{ .Values.conf.keystone.username }}
user_domain_name = Default
www_authenticate_uri = {{ .Values.conf.keystone.auth_url }}
auth_type = password
service_type = rating
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}

[orchestrator]
max_workers = {{ .Values.conf.processor.max_workers }}
coordination_url = {{ .Values.conf.processor.coordination_url }}

[oslo_concurrency]
lock_path = /var/lock/cloudkitty

[oslo_messaging_rabbit]
ssl = True
rabbit_quorum_queue=true
rabbit_transient_quorum_queue=true
rabbit_stream_fanout=true
rabbit_qos_prefetch_count=1

[oslo_policy]
policy_file = /etc/cloudkitty/policy.yaml

[storage]
backend = influxdb
version = 2

[storage_influxdb]
username = {{ .Values.conf.storage.influxdb.username }}
database = {{ .Values.conf.storage.influxdb.database }}
host = {{ .Values.conf.storage.influxdb.host }}
{{- end }}
