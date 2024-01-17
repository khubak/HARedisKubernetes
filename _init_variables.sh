export KUBERNETES_VERSION=v1.21.2
export REPO_CONTENT="[VirtualBox]
name=Fedora \$releasever - \$basearch - VirtualBox
baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/\$releasever/\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://www.virtualbox.org/download/oracle_vbox.asc
"
export REPO_FILE="/etc/yum.repos.d/virtualbox.repo"
