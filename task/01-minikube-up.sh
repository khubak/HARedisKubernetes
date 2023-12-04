#!/usr/bin/env bash

set -e

# variables
source ./_init_variables.sh

echo "This script was tested on Rocky Linux 9.3 (RHEL based distribution)!"

# check if virtualization is enabled
command -v grep -E -c '(vmx|svm)' /proc/cpuinfo || {
	echo "Virtualization is not enabled on this host. Enable virtualization or contact your fellow DevOps guy!"
	exit 100
}

# install dependencies and update the system
echo "Updating the OS and installing dependencies";
command -v dnf update -y \
	&& dnf install -y kernel-devel kernel-headers gcc make perl elfutils-libelf-devel wget

# check if virtualbox is installed
command -v VBoxManage 2>&1 || {
	echo "Could not find virtualbox on machine... Installing virtualbox!";
        echo "Adding VirtualBox package repository...";
	command wget https://www.virtualbox.org/download/oracle_vbox.asc \
		&& rpm --import oracle_vbox.asc \
		&& wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo \
		&& dnf install -y VirtualBox-7.0
	command -v VBoxManage 2>&1 || {
		echo "VirtualBox could not be installed, please contact the admin!"
		exit 100
	}
}

# check if minikube is installed
command -v minikube 2>&1 || {
	echo "Could not find minikube on machine... Installing minikube!";
	command curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm \
		&& sudo rpm -Uvh minikube-latest.x86_64.rpm
	command -v minikube 2>&1 || {
		echo "minikube could not be installed, please contact the admin!"
		exit 101
	}
}

# check if kubectl is installed
command -v kubectl 2>&1 || {
        echo "Could not find kubectl on machine... Installing kubectl!";
	command cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.28/rpm/repodata/repomd.xml.key
EOF
	command dnf upgrade -y \
		&& dnf install -y kubectl 
	command -v kubectl 2>&1 || {
		echo "kubectl could not be installed, please contact the admin!"
		exit 102
        }
}


# check if podman is installed
command -v  podman 2>&1 || {
	echo "Could not find podman on machine... Installing podman!";
	command -v sudo dnf upgrade -y \
		&& sudo dnf install podman -y
	command -v podman 2>&1 || {
			                echo "podman could not be installed, please contact the admin!"
		                exit 101
	 }
			}

echo "came after command v podman!"

case "$(uname -s)" in
   # if running on MacOS then use hyperkit virtualizator
   Darwin*)
     minikube config set vm-driver hyperkit;;
   *)
     minikube config set vm-driver podman;;
esac

echo "came after replace"

( minikube status ) || minikube start --force --memory=1900 --nodes 2

# enable metrics server
minikube addons enable metrics-server

MINIKUBE_IP=`minikube ip`

echo
echo "Cool! MiniKube is up on ${MINIKUBE_IP} address."
