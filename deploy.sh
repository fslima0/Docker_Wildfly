#!/bin/bash

RESULT_DEPLOYMENTS=$(/opt/jboss/wildfly/bin/jboss-cli.sh --connect --controller=${HOST_WILDFLY} --user=${USER_WILDFLY} --password=${PASS_WILDFLY} --commands="deployment list")

MY_DEPLOY=false

for f in $RESULT_DEPLOYMENTS; do
	if [ "$f" == "app.war" ]; then
		MY_DEPLOY=true
	fi
done

echo "Executando o deploy no WildFly"

if [ ${MY_DEPLOY} == true ]; then
	$(/opt/jboss/wildfly/bin/jboss-cli.sh --connect --controller=${HOST_WILDFLY} --user=${USER_WILDFLY} --password=${PASS_WILDFLY} --commands="deploy target/app.war --force")
else
    $(/opt/jboss/wildfly/bin/jboss-cli.sh --connect --controller=${HOST_WILDFLY} --user=${USER_WILDFLY} --password=${PASS_WILDFLY} --commands="deploy target/app.war --server-groups=other-server-group")
fi

echo "Deploy finalizado"
