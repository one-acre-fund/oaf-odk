# ODK Helm chart

This repository provides a [Helm](https://helm.sh/) chart for [OpenDataKit](https://getodk.org/), the leading open-source field data colleciton tool, to deploy the following into a Helm-ready Kubernetes cluster within minutes:

* ODK Central, the server managing forms and users
* Enketo, the web-based form filling interface
* pyxform, to convert forms

The Chart will install all required dependencies, i.e.:

* Postgres, for ODK Central
* Redis, for Enketo

It relies on the public images published from [this ODK fork](https://github.com/one-acre-fund/central).

## Prerequisites

* A Kubernetes cluster with Helm :)
* A working public domain name

## Download

```sh
git clone 
```

## Setup

The repo comes with working defaults for most settings, but you will clearly want to customize some of those, by creating your own `my-values.yaml`, in particular with your own secrets and passwords, e.g.:

```yaml
serviceType: NodePort

central:
  init: true
  adminUser: max@example.org
  adminPassword: kYQdQUV7QH

smtp:
  host: smtp.gmail.com
  tls: true
  port: 587
  user: max@example.org
  password: jHgZV5WSnxA4HcCseANxdJuDa

ingress:
  enabled: true

general:
  externalDomain: odk.example.com
  supportEmail: max@example.org

global:
  storageClass: my-storage-class
```

Please refer to the comments in [values.yaml](deployment/odk/values.yaml) to understand all possible settings.

## Run

The usual Helm routine:

```sh
# Install chart dependencies
helm dependency build deployment/odk

# Install new release
helm upgrade --install --values my-values.yaml my-odk deployment/odk
```

## Limitations / TODOs

* The nginx setup is currently only listening over http, since in Kubernetes context the TLS setup is generally managed at ingress level. If this doesn't suit your needs, you may need to override the nginx ConfigMap
* Currently the chart only works with its own Postgres database (installed as subchart). To use an external database you may need to override the chart templates.
