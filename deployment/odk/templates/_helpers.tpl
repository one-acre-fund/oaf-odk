{{- define "postgresHost" -}}
{{ .Release.Name }}-postgresql
{{- end -}}

{{- define "conf_odk" -}}
{
  "default": {
    "database": {
      "host": "{{ include "postgresHost" . }}",
      "user": "{{ .Values.postgresql.postgresqlUsername }}",
      "password": "{{ .Values.postgresql.postgresqlPassword }}",
      "database": "{{ .Values.postgresql.dbName }}"
    },
    "server": {
      "port": 8383
    },
    "email": {
      "serviceAccount": "{{ .Values.general.supportEmail }}",
      "transport": "smtp",
      "transportOpts": {
        "host": "{{ .Values.smtp.host }}",
        "port": {{ .Values.smtp.port }},
        "secure": {{ .Values.smtp.tls }},
        "auth": {
          "user": "{{ .Values.smtp.user }}",
          "pass": "{{ .Values.smtp.password }}"
        }
      }
    },
    "env": {
      "domain": "{{ .Values.general.externalScheme }}://{{ .Values.general.externalDomain }}"
    },
    "xlsform": {
      "host": "localhost",
      "port": 80
    },
    "enketo": {
      "url": "http://{{ .Release.Name }}-enketo:8005/-",
      "apiKey": "{{ .Values.enketo.apiKey }}"
    },
    "external": {
      "google": {
        "clientId": "660095633112-h7bhsjenhp1agd0c4v3cmqk6bccgkdu0.apps.googleusercontent.com",
        "clientSecret": "lzu2vK1NFqqd6Y5HiN-7ByvE"
      },
      "sentry": {
        "key": "3cf75f54983e473da6bd07daddf0d2ee",
        "project": "1298632"
      }
    }
  }
}
{{- end -}}

{{- define "conf_enketo" -}}
{
  "app name": "Enketo",
  "base path": "-",
  "encryption key": "{{ .Values.enketo.encryptionKey }}",
  "id length": 31,
  "less secure encryption key": "{{ .Values.enketo.lessApiKey }}",
  "linked form and data server": {
      "api key": "{{ .Values.enketo.apiKey }}",
      "authentication": {
          "type": "cookie",
          "url": "{{ .Values.general.externalScheme }}://{{ .Values.general.externalDomain }}/#/login?next={RETURNURL}"
      },
      "name": "ODK Central",
      "server url": ""
  },
  "logo": {
      "source": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=",
      "href": ""
  },
  "offline enabled": true,
  "payload limit": "1mb",
  "port": "8005",
  "query parameter to pass to submission": "st",
  "redis": {
    "cache": {
      "host": "{{ .Release.Name }}-rediscache-master",
      {{- if .Values.rediscache.usePassword }}
      "password": "{{ .Values.global.redis.password }}",
      {{- end }}
      "port": "6379"
    },
    "main": {
      "host": "{{ .Release.Name }}-redismain-master",
      {{- if .Values.redismain.usePassword }}
      "password": "{{ .Values.global.redis.password }}",
      {{- end }}
      "port": "6379"
    }
  },
  "support": {
      "email": "{{ .Values.general.supportEmail }}"
  },
  "text field character limit": 1000000
}
{{- end -}}