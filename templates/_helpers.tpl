{{/*
Vault annotations
*/}}
{{- define "cloudkitty.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
vault.hashicorp.com/secret-volume-path-secrets.conf: /etc/cloudkitty/cloudkitty.conf.d
vault.hashicorp.com/agent-inject-secret-secrets.conf: "{{ .Values.vault.settings_secret }}"
vault.hashicorp.com/agent-inject-template-secrets.conf: |
   {{ print "{{- with secret \"" .Values.vault.settings_secret "\" -}}" }}
   {{ print "[database]" }}
   {{ print "connection={{ .Data.data.database_connection }}" }}
   {{ print "[keystone_authtoken]" }}
   {{ print "password={{ .Data.data.keystone_password }}" }}
   {{ print "[storage_influxdb]" }}
   {{ print "password={{ .Data.data.influxdb_password }}" }}
   {{ print "[DEFAULT]" }}
   {{ print "transport_url={{ .Data.data.transport_url}}" }}
   {{ print "{{- end -}}" }}
{{- end }}
