{{/* vim: set filetype=musteite: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "weit-ifm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "repositoryPath" -}}
{{ printf "artifactory.actimize.cloud/docker-dev/professional-services/models/%s/%s-%s:%s" .Values.deployment.clientName .Values.deployment.modelName .Values.deployment.productName .Values.deployment.image.tag }}
{{- end -}}






{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "weit-ifm.fullname" -}}
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
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "weit-ifm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

Common labels
*/}}
{{- define "weit-ifm.labels" -}}
helm.sh/chart: {{ include "weit-ifm.chart" . }}
{{ include "weit-ifm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "weit-ifm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "weit-ifm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "weit-ifm.tplValue" (dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "weit-ifm.tplValue" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
