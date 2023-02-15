{{/*
Expand the name of the chart.
*/}}
{{- define "bookinfo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bookinfo.fullname" -}}
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
{{- define "bookinfo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bookinfo.labels" -}}
helm.sh/chart: {{ include "bookinfo.chart" . }}
{{ include "bookinfo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bookinfo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bookinfo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bookinfo.reviews.serviceAccountName" -}}
{{- if .Values.serviceAccount.reviews.create }}
{{- default (include "bookinfo.fullname" .) .Values.serviceAccount.reviews.name }}
{{- else }}
{{- default "reviews-sa" .Values.serviceAccount.reviews.name }}
{{- end }}
{{- end }}



{{/*
Reviews selector labels
*/}}
{{- define "bookinfo.reviews.selectorLabels" -}}
{{ include "bookinfo.selectorLabels" . }}
role: reviews
{{- end }}

{{/*
Reviews labels
*/}}
{{- define "bookinfo.reviews.labels" -}}
{{ include "bookinfo.labels" . }}
role: reviews
{{- end }}

