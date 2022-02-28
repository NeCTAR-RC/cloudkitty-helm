{{- define "metrics" }}
metrics:
  vcpus:
    unit: instance
    alt_name: instance
    groupby:
      - id
      - user_id
      - project_id
    metadata:
      - flavor_name
      - flavor_id
      - availability_zone
    mutate: NUMBOOL
    extra_args:
      aggregation_method: mean
      resource_type: instance
{{- end }}
