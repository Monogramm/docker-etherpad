
[![License: AGPL v3][uri_license_image]][uri_license]
[![Docs](https://img.shields.io/badge/Docs-Github%20Pages-blue)](https://monogramm.github.io/etherpad/)
[![Build Status](https://travis-ci.org/Monogramm/docker-etherpad.svg)](https://travis-ci.org/Monogramm/docker-etherpad)
[![Docker Automated buid](https://img.shields.io/docker/cloud/build/monogramm/docker-etherpad.svg)](https://hub.docker.com/r/monogramm/docker-etherpad/)
[![Docker Pulls](https://img.shields.io/docker/pulls/monogramm/docker-etherpad.svg)](https://hub.docker.com/r/monogramm/docker-etherpad/)
[![Docker Version](https://images.microbadger.com/badges/version/monogramm/docker-etherpad.svg)](https://microbadger.com/images/monogramm/docker-etherpad)
[![Docker Size](https://images.microbadger.com/badges/image/monogramm/docker-etherpad.svg)](https://microbadger.com/images/monogramm/docker-etherpad)
[![GitHub stars](https://img.shields.io/github/stars/Monogramm/docker-etherpad?style=social)](https://github.com/Monogramm/docker-etherpad)

<!--

Template variables to replace in ALL files:
* Etherpad: Name of the application
* ether: GitHub Owner of the original application
* etherpad: GitHub slug of the original application
* ETHERPAD: Uppercase value of the GitHub slug
* Real-time collaborative document editor.: Application description
* https://etherpad.org/: Application URL
* Etherpad: Uppercase value of the GitHub slug

After replacing all variables:
* Edit `update.sh` to edit how to retrieve the application latest versions and how to generate images
* Edit `template/docker-compose_*.yml` to configure your Docker environment for CI
* Edit `template/test` content for DockerHub custom tests

-->

# **Etherpad** Docker image

Docker image for **Etherpad**.

:construction: **This image is still in development!**

## What is **Etherpad** ?

Real-time collaborative document editor.

> [**Etherpad**](https://etherpad.org/)

## Supported tags

[Dockerhub monogramm/docker-etherpad](https://hub.docker.com/r/monogramm/docker-etherpad/)

* `debian` `latest`
* `alpine`
* `1.8.0-debian` `1.8.0`
* `1.8.0-alpine`
* `1.7.5-debian` `1.7.5`
* `1.7.5-alpine`

## How to run this image ?

To run your instance:
```bash
docker run --detach --publish <DESIRED_PORT>:9001 monogramm/docker-etherpad
```

And point your browser to `http://<YOUR_IP>:<DESIRED_PORT>`

## Options available by default

The `settings.json` available by default enables some configuration to be set from the environment.

Available options:

* `TITLE`: The name of the instance
* `FAVICON`: favicon default name, or a fully specified URL to your own favicon
* `SKIN_NAME`: either `no-skin`, `colibris` or an existing directory under `src/static/skins`.
* `IP`: IP which etherpad should bind at. Change to `::` for IPv6
* `PORT`: port which etherpad should bind at
* `SHOW_SETTINGS_IN_ADMIN_PAGE`: hide/show the settings.json in admin page
* `DB_TYPE`: a database supported by https://www.npmjs.com/package/ueberdb2
* `DB_HOST`: the host of the database
* `DB_PORT`: the port of the database
* `DB_NAME`: the database name
* `DB_USER`: a database user with sufficient permissions to create tables
* `DB_PASS`: the password for the database username
* `DB_CHARSET`: the character set for the tables (only required for MySQL)
* `DB_FILENAME`: in case `DB_TYPE` is `DirtyDB`, the database filename. Default: `var/dirty.db`
* `ADMIN_PASSWORD`: the password for the `admin` user (leave unspecified if you do not want to create it)
* `USER_PASSWORD`: the password for the first user `user` (leave unspecified if you do not want to create it)
* `TRUST_PROXY`: set to `true` if you are using a reverse proxy in front of Etherpad (for example: Traefik for SSL termination via Let's Encrypt). This will affect security and correctness of the logs if not done
* `LOGLEVEL`: valid values are `DEBUG`, `INFO`, `WARN` and `ERROR`
* `LOGLOCALELEVEL`: default locale
* `REQUIRE_AUTH`: if you require authentication of all users.

[ep_ldapauth](https://www.npmjs.com/package/ep_ldapauth) options:

* `LDAP_URL`: LDAP URL. Format: `ldaps://ldap.example.com`
* `LDAP_BASE_DN`: LDAP Account Base. Format: `ou=Users,dc=example,dc=com`
* `LDAP_ACCOUNT_PATTERN`: LDAP Account Pattern. Format: `(&(objectClass=*)(uid={{username}}))`
* `LDAP_DISPLAY_NAME_ATTR`: LDAP Display name attribute. Format: `cn`
* `LDAP_SEARCH_DN`: LDAP URL. Format: `uid=searchuser,dc=example,dc=com`
* `LDAP_SEARCH_PASSWD`: LDAP URL. Format: `supersecretpassword`
* `LDAP_GROUP_DN`: LDAP URL. Format: `ou=Groups,dc=example,dc=com`
* `LDAP_GROUP_ATTR`: LDAP URL. Format: `member`
* `LDAP_GROUP_ATTR_IS_DN`: LDAP URL. Format: `true`
* `LDAP_GROUP_SCOPE`: LDAP URL. Format: `sub`
* `LDAP_GROUP_SEARCH`: LDAP URL. Format: `(&(cn=admin)(objectClass=groupOfNames))`
* `LDAP_ANON_RO`: LDAP URL. Format: `false`

[ep_piwik](https://www.npmjs.com/package/ep_piwik) options:

* `PIWIK_URL`: Matomo / Piwik URL
* `PIWIK_SITE_ID`: Matomo / Piwik Site ID

[ep_markdown](https://www.npmjs.com/package/ep_markdown) options:

* `MARKDOWN`: Enable/disable markdown support

### Examples

Use a Postgres database, no admin user enabled:

```shell
docker run -d \
	--name etherpad         \
	-p 9001:9001            \
	-e 'DB_TYPE=postgres'   \
	-e 'DB_HOST=db.local'   \
	-e 'DB_PORT=4321'       \
	-e 'DB_NAME=etherpad'   \
	-e 'DB_USER=dbusername' \
	-e 'DB_PASS=mypassword' \
	monogramm/docker-etherpad
```

Run enabling the administrative user `admin`:

```shell
docker run -d \
	--name etherpad \
	-p 9001:9001 \
	-e 'ADMIN_PASSWORD=supersecret' \
	monogramm/docker-etherpad
```

Run a test instance running DirtyDB on a persistent volume:

```
docker run -d \
	-v etherpad_data:/opt/etherpad-lite/var \
	-p 9001:9001 \
	monogramm/docker-etherpad
```

# Questions / Issues
If you got any questions or problems using the image, please visit our [Github Repository](https://github.com/Monogramm/docker-etherpad) and write an issue.

[uri_license]: http://www.gnu.org/licenses/agpl.html

[uri_license_image]: https://img.shields.io/badge/License-AGPL%20v3-blue.svg
