#!/usr/bin/env bash
set -euo pipefail

install -d -m 0755 /usr/local/tomcat/shared/classes

# Write the properties file. Values for host and port come from POSTGRES_* envs.
{
  printf 'db.name=%s\n'     "${ALFRESCO_DB_NAME}"
  printf 'db.username=%s\n' "${ALFRESCO_DB_USER}"
  printf 'db.password=%s\n' "${ALFRESCO_DB_PASS}"

  printf 'db.host=%s\n'     "${POSTGRES_HOST}"
  printf 'db.port=%s\n'     "${POSTGRES_PORT}"

  printf 'db.pool.max=275\n'
  printf 'db.driver=org.postgresql.Driver\n'

  # Exact literal - do not let the shell expand it
  printf 'db.url=jdbc:postgresql://${db.host}:${db.port}/${db.name}\n'

  printf '\ntransform.service.enabled=false\n'
  printf 'local.transform.service.enabled=false\n'
  printf 'legacy.transform.service.enabled=false\n'
  printf '\n'
  printf 'dir.root=/usr/local/tomcat/alf_data\n'
  printf 'ooo.enabled=false\n'
  printf 'jodconverter.enabled=false\n'
  printf 'events.subsystem.autoStart=false\n'
  printf 'messaging.subsystem.autoStart=false\n'
} > /usr/local/tomcat/shared/classes/alfresco-global.properties
