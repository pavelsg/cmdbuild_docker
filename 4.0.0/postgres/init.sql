\set alfresco_db_name `echo "$ALFRESCO_DB_NAME"`
\set alfresco_db_user `echo "$ALFRESCO_DB_USER"`
\set alfresco_db_pass `echo "$ALFRESCO_DB_PASS"`
CREATE ROLE :alfresco_db_user WITH LOGIN PASSWORD :'alfresco_db_pass';
CREATE DATABASE :alfresco_db_name OWNER :alfresco_db_user;