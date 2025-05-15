FROM tomcat:9.0.31-jdk11-openjdk

WORKDIR $CATALINA_HOME

ENV CMDBUILD_URL=https://sourceforge.net/projects/cmdbuild/files/3.1.1/cmdbuild-3.1.1.war/download?use_mirror=autoselect
ENV POSTGRES_JDBC_URL=https://jdbc.postgresql.org/download/postgresql-42.2.10.jar
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASS=postgres
ENV POSTGRES_PORT=5432
ENV POSTGRES_HOST=localhost
ENV POSTGRES_DB=cmdbuild
ENV CMDBUILD_DUMP=demo
ENV CMDBUILD_USER=cmdbuild
ENV CMDBUILD_PASS=cmdbuild
ENV JMX_EXPORTER_VERSION=0.12.0
ENV JMX_JAR=jmx_prometheus_javaagent-$JMX_EXPORTER_VERSION.jar


RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    maven \
	postgresql-client

RUN set -x \
 	&& mkdir $CATALINA_HOME/conf/cmdbuild/ \
 	&& mkdir $CATALINA_HOME/webapps/cmdbuild/

COPY files/context.xml $CATALINA_HOME/webapps/manager/META-INF/context.xml
COPY files/database.conf $CATALINA_HOME/conf/cmdbuild/database.conf
COPY files/docker-entrypoint.sh /usr/local/bin/


RUN set -x \
	&& groupadd tomcat \
	&& useradd -s /bin/false -g tomcat -d $CATALINA_HOME tomcat \
	&& cd /tmp \
	&& wget -O cmdbuild.war "$CMDBUILD_URL" \
	&& wget -O postgresql-42.2.10.jar "$POSTGRES_JDBC_URL" \
	&& chmod 777 cmdbuild.war \
	&& chmod 777 /usr/local/bin/docker-entrypoint.sh \
	&& unzip cmdbuild.war -d cmdbuild \
	&& rm -rf webapps/* \
	&& wget -O $JMX_JAR "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$JMX_EXPORTER_VERSION/$JMX_JAR" \
	&& chmod 777 $JMX_JAR \
	&& mkdir -p /opt/jmx_exporter \
	&& mv $JMX_JAR /opt/jmx_exporter/jmx_prometheus_javaagent.jar \
	&& chown tomcat -R /opt/jmx_exporter \
	&& mv cmdbuild.war $CATALINA_HOME/webapps/cmdbuild.war \
	&& mv cmdbuild/* $CATALINA_HOME/webapps/cmdbuild/ \
	&& chown tomcat -R postgresql-42.2.10.jar \
	&& mv postgresql-42.2.10.jar $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/postgresql-42.2.10.jar \
	&& rm $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/postgresql-42.2.5.jar_disabled \
#	&& rm $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib_ext/postgresql-42.2.5.jar \
#	&& mv $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/postgresql-42.2.5.jar_disabled $CATALINA_HOME/webapps/cmdbuild/WEB-INF/lib/postgresql-42.2.5.jar \
	&& chmod 777 $CATALINA_HOME/webapps/cmdbuild/cmdbuild.sh \
	&& cd /tmp \
	&& wget -O /tmp/commons-net-3.6-bin.tar.gz https://downloads.apache.org//commons/net/binaries/commons-net-3.6-bin.tar.gz \
	&& tar -xf /tmp/commons-net-3.6-bin.tar.gz \
	&& mv commons-net-3.6/commons-net-3.6.jar $CATALINA_HOME/lib/ \
	&& chown tomcat -R $CATALINA_HOME \
	&& cd /tmp \
	&& rm -rf * \
	&& rm -rf /var/lib/apt/lists/*


COPY files/app.js $CATALINA_HOME/webapps/cmdbuild/ui/cmdbuild/app.js

# cleanup
RUN apt-get -qy autoremove

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh

USER tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]