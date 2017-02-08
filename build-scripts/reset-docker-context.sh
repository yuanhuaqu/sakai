REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
rm -r $REPO_ROOT/docker/components $REPO_ROOT/docker/lib $REPO_ROOT/docker/webapps
mkdir $REPO_ROOT/docker/lib
rm -r /tmp/tracs-apache
mkdir -p /tmp/tracs-apache
wget -qO- http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz | tar -xz --strip-component 1 -C /tmp/tracs-apache
cp -r /tmp/tracs-apache/lib/* $REPO_ROOT/docker/lib/
rm -r /tmp/tracs-apache

cd $REPO_ROOT/master
mvn clean install
cd $REPO_ROOT/kernel/deploy
mvn clean install sakai:deploy -Dmaven.tomcat.home=$REPO_ROOT/docker -P mysql
