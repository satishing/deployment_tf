#!/bin/bash

set -x

function wait_for_jenkins() 
{
	while (( 1 )); do
		echo "waiting for Jenkins to launch on port [8080] ..."
		
		netstat -antp | grep 8080
		if (( $? == 0 )); then
			break
		fi
		sleep 10
	done
	echo "Jenkins launched"
}

function updating_jenkins_master_password ()
{
	pip install bcrypt  
	cat > /tmp/jenkinsHash.py <<EOF
import bcrypt
import sys
if not sys.argv[1]:
  sys.exit(10)
plaintext_pwd=sys.argv[1]
encrypted_pwd=bcrypt.hashpw(sys.argv[1], bcrypt.gensalt(rounds=10, prefix=b"2a"))
isCorrect=bcrypt.checkpw(plaintext_pwd, encrypted_pwd)
if not isCorrect:
  sys.exit(20);
print "{}".format(encrypted_pwd)
EOF

	chmod +x /tmp/jenkinsHash.py
	
	# Wait till /var/lib/jenkins/users/admin* folder gets created
	sleep 10
	
	cd /var/lib/jenkins/users/admin*
	pwd
	while (( 1 )); do
		echo "Waiting for Jenkins to generate admin user's config file ..."
	
		if [[ -f "./config.xml" ]]; then
			break
		fi
	
		sleep 10
	done
	
	echo "Admin config file created"
	
	admin_password=$(python /tmp/jenkinsHash.py ${jenkins_admin_password} 2>&1)
	
	# Please do not remove alter quote as it keeps the hash syntax intact or else while substitution, $<character> will be replaced by null
	xmlstarlet -q ed --inplace -u "/user/properties/hudson.security.HudsonPrivateSecurityRealm_-Details/passwordHash" -v '<:'"$admin_password" config.xml
	
	# Restart
	systemctl restart jenkins
	sleep 10
}

function install_packages ()
{
	yum install -y java-1.8.0-openjdk-devel
	yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	yum -y install xmlstarlet
	wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
	rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
	yum install -y jenkins
	
	systemctl enable jenkins
	systemctl restart jenkins
	sleep 10
}

function configure_jenkins_server ()
{
	# Jenkins cli
	echo "installing the Jenkins cli ..."
	cp /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar /var/lib/jenkins/jenkins-cli.jar
	
	# Getting initial password
	# PASSWORD=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
	PASSWORD="${jenkins_admin_password}"
	sleep 10
	
	jenkins_dir="/var/lib/jenkins"
	plugins_dir="$jenkins_dir/plugins"
	
	cd $jenkins_dir
	
	# Open JNLP port
	xmlstarlet -q ed --inplace -u "/hudson/slaveAgentPort" -v 33453 config.xml
	
	cd $plugins_dir || { echo "unable to chdir to [$plugins_dir]"; exit 1; }
	
	# List of plugins that are needed to be installed 
	plugin_list="git-client git github-api github-oauth github MSBuild ssh-slaves workflow-aggregator ws-cleanup"
	
	# remove existing plugins, if any ...
	rm -rfv $plugin_list
	
	for plugin in $plugin_list; do
		echo "installing plugin [$plugin] ..."
		java -jar $jenkins_dir/jenkins-cli.jar -s http://127.0.0.1:8080/ -auth admin:$PASSWORD install-plugin $plugin
	done
	
	# Restart jenkins after installing plugins
	java -jar $jenkins_dir/jenkins-cli.jar -s http://127.0.0.1:8080 -auth admin:$PASSWORD safe-restart
}

function install_docker ()
{
	yum update -y
	sleep 10
	# Setting up Docker
	yum install -y docker
	usermod -a -G docker ec2-user
	# Just to be safe removing previously available java if present
	yum remove -y java
	sleep 20
	yum install -y python2-pip jq unzip vim tree biosdevname nc bind-utils at screen tmux  git java-1.8.0-openjdk nc gcc-c++ make 
	
	systemctl enable docker
	systemctl enable atd
	systemctl enable --now docker
	
	yum clean all
	rm -rf /var/cache/yum/
}

function install_ansible ()
{
	rpm -i epel-release-latest-7.noarch.rpm
	yum update -y 
	yum install ansible -y
}

function install_nginx() 
{
  yum install -y epel-release
  yum update -y
  yum install -y nginx
}

### script starts here ###

install_packages
wait_for_jenkins
updating_jenkins_master_password
wait_for_jenkins
configure_jenkins_server
install_docker
install_ansible
install_nginx

echo "Done"
exit 
