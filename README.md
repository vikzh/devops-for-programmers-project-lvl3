### Hexlet tests and linter status:
[![Actions Status](https://github.com/vikzh/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/vikzh/devops-for-programmers-project-lvl3/actions)

## Install Dependencies
```shell
make galaxy-install
```

## Set the secrets
#### `./terraform/secret.auto.tfvars`
* `do_token`
* `datadog_api_key`
* `datadog_app_key`
#### `./ansible/group_vars/webservers.yml`
* `db_params`
* `datadog_params`

## Setup Infrastructure
```shell
make apply
 ```

## Deploy
```shell
make deploy
```