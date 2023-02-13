# Container image that runs your code
FROM fedora:35

RUN echo -en "[Adoptium]\n\
name=Adoptium\n\
baseurl=https://packages.adoptium.net/artifactory/rpm/${DISTRIBUTION_NAME:-$(. /etc/os-release; echo $ID)}/\$releasever/\$basearch\n\
enabled=1\n\
gpgcheck=1\n\
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public" >> /etc/yum.repos.d/adoptium.repo

RUN dnf install -y temurin-17-jdk rpm-build curl zip which rpmrebuild

RUN java --version

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# change permission to execute the script and
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
