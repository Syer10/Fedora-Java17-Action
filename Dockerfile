# Container image that runs your code
FROM fedora:35

RUN dnf install -y rpm-build curl zip which rpmrebuild

RUN mkdir -p /usr/java/openjdk
RUN curl "https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz" \
    --output /usr/java/openjdk/openjdk-17.0.2_linux-x64_bin.tar.gz
RUN tar -xzvf /usr/java/openjdk/openjdk-17.0.2_linux-x64_bin.tar.gz -C /usr/java/openjdk

#Set Java home to where java will be installed
ENV JAVA_HOME /usr/java/openjdk/jdk-17.0.2

#Add java to PATH
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${JAVA_HOME}/bin

RUN java --version

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# change permission to execute the script and
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
