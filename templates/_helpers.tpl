{{/*
Expand the name of the chart.
*/}}
{{- define "cloudkitty.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cloudkitty.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cloudkitty.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cloudkitty.labels" -}}
helm.sh/chart: {{ include "cloudkitty.chart" . }}
{{ include "cloudkitty.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cloudkitty.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cloudkitty.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cloudkitty.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cloudkitty.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Vault annotations
*/}}
{{- define "cloudkitty.vaultAnnotations" -}}
vault.hashicorp.com/role: "{{ .Values.vault.role }}"
vault.hashicorp.com/agent-inject: "true"
vault.hashicorp.com/agent-pre-populate-only: "true"
vault.hashicorp.com/agent-inject-status: "update"
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
