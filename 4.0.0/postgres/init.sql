\set cmdbuild_db_name `echo "$CMDBUILD_DB_NAME"`
\set cmdbuild_db_user `echo "$CMDBUILD_DB_USER"`
\set cmdbuild_db_pass `echo "$CMDBUILD_DB_PASS"`
\set alfresco_db_name `echo "$ALFRESCO_DB_NAME"`
\set alfresco_db_user `echo "$ALFRESCO_DB_USER"`
\set alfresco_db_pass `echo "$ALFRESCO_DB_PASS"`
CREATE ROLE :cmdbuild_db_user WITH LOGIN PASSWORD :'cmdbuild_db_pass';
CREATE DATABASE :cmdbuild_db_name OWNER :cmdbuild_db_user;
CREATE ROLE :alfresco_db_user WITH LOGIN PASSWORD :'alfresco_db_pass';
CREATE DATABASE :alfresco_db_name OWNER :alfresco_db_user;