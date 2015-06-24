# Docker image for latest stable release of Puppet running on latest
# stable release of Debian.
FROM debian:jessie

MAINTAINER Kay Abendroth <kay.abendroth@raxion.net>


# Refresh variable to incoroporate criticial OS fixes.
ENV REFRESH_AT=2015-06-23

# Refresh package lists and upgrade the operating system.
RUN apt-get -yqq update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade

# Add Puppetlabs repository for our Debian version.
ENV PUPPETLABS_REPO_FILE=puppetlabs-release-jessie.deb
RUN apt-get -y install curl && \
    curl -o /tmp/${PUPPETLABS_REPO_FILE} https://apt.puppetlabs.com/${PUPPETLABS_REPO_FILE} && \
    dpkg -i /tmp/${PUPPETLABS_REPO_FILE} && \
    rm -f /tmp/${PUPPETLABS_REPO_FILE} && \
    apt-get -y purge curl

# Install packages.
RUN apt-get -y install puppetmaster-passenger

# Global clean-up.
RUN apt-get -y autoremove && \
    apt-get -y clean

