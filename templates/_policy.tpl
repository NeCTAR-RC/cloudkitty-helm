{{- define "policy" }}
"context_is_admin": "role:admin"
"admin_or_owner": "is_admin:True or (role:admin and is_admin_project:True) or project_id:%(project_id)s"
"storage:list_data_frames": "rule:admin_or_owner"
"dataframes:get": "rule:admin_or_owner"
{{- end }}
