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
  warre.reservation.exists:
    unit: reservation
    alt_name: reservation
    groupby:
      - id
      - user_id
      - project_id
    metadata:
      - flavor_name
      - flavor_id
    mutate: NUMBOOL
    extra_args:
      aggregation_method: mean
      resource_type: reservation
  loadbalancer:
    unit: loadbalancer
    alt_name: load_balancer
    groupby:
      - id
      - user_id
      - project_id
    mutate: NUMBOOL
    extra_args:
      aggregation_method: mean
      resource_type: load_balancer
  database:
    unit: database
    alt_name: database
    groupby:
      - id
      - user_id
      - project_id
    mutate: NUMBOOL
    extra_args:
      aggregation_method: mean
      resource_type: database
{{- end }}
