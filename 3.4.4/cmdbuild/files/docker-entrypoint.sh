#!/bin/bash
set -e

cat /dev/null > $CATALINA_HOME/conf/cmdbuild/database.conf
echo "Edit $CATALINA_HOME/conf/cmdbuild/database.conf"
{
    echo "db.url=jdbc:postgresql://$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB"
    echo "db.username=cmdbuild"
    echo "db.password=cmdbuild"
    echo "db.admin.username=$POSTGRES_USER"
    echo "db.admin.password=$POSTGRES_PASS"
} >> $CATALINA_HOME/conf/cmdbuild/database.conf

# first init DB, second start with fail
while ! timeout 1 bash -c "echo > /dev/tcp/$POSTGRES_HOST/$POSTGRES_PORT"; do   
  >&2 echo "Postgres is unavailable - sleeping" 
  sleep 5
done

echo "Init DB"
mv $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/ignite-*.jar /tmp/
{ # try
  
    $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh em $CMDBUILD_DUMP -configfile $CATALINA_HOME/conf/cmdbuild/database.conf
   
} || { 
    echo "DB was initiliazed. Use dbconfig recreate or dbconfig drop"
}
mc /tmp/ignite-*.jar $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/

#echo "Change user to tomcat"
#su tomcat

#echo "RUN catalina"
exec $CATALINA_HOME/bin/catalina.sh run