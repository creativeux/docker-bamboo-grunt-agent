FROM centos:7.0.1406
MAINTAINER Aaron Stone <aaronastone@gmail.com>

# Install Java JRE to execute the Bamboo Agent Jar
RUN yum -y install java-1.8.0-openjdk.x86_64

#Install Git to pull code
RUN yum -y install git

# Install core RPMs
RUN yum -y install \
    wget \
    tar \
	bzip2

# Install required developer tools
RUN yum -y install \
  make \
  gcc \
  gcc-c++

# Install NodeJS & npm
RUN wget http://nodejs.org/dist/v0.12.4/node-v0.12.4-linux-x64.tar.gz -P /tmp && \
    tar --strip-components 1 -xzvf /tmp/node-v* -C /usr/local && \
    rm /tmp/node-v*

# Install PhantomJS
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 -P /tmp && \
    tar --strip-components 2 -xvf /tmp/phantomjs-1.9.8-linux-x86_64.tar.bz2 -C /usr/local/bin phantomjs-1.9.8-linux-x86_64/bin/phantomjs && \
    rm /tmp/phantomjs-*

# Install ruby
RUN yum -y install ruby \
  ruby-devel \
  rubygems

# Install compass
RUN gem install compass

# Install required libs
RUN yum -y install \
  libpng-devel

# Install Grunt and Bower
RUN npm install -g \
  grunt-cli \
  bower

COPY ./config/atlassian-bamboo-agent-installer-5.8.1.jar /
COPY ./config/start-agent.sh /

ENTRYPOINT ["/start-agent.sh"]