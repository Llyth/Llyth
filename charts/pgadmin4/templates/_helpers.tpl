{{/* vim: set filetype=mustache: */}}

{{- define "pgadmin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "pgadmin.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end }}

{{- define "pgadmin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "pgadmin.labels" -}}
app.kubernetes.io/name: {{ include "pgadmin.name" . }}
helm.sh/chart: {{ include "pgadmin.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "pgadmin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pgadmin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Aliases for pgadmin4.* (compat) */}}
{{- define "pgadmin4.name" -}}{{ include "pgadmin.name" . }}{{- end }}
{{- define "pgadmin4.fullname" -}}{{ include "pgadmin.fullname" . }}{{- end }}
{{- define "pgadmin4.labels" -}}{{ include "pgadmin.labels" . }}{{- end }}
{{- define "pgadmin4.selectorLabels" -}}{{ include "pgadmin.selectorLabels" . }}{{- end }}