FROM centos:7
MAINTAINER Nick Coghlan <ncoghlan@gmail.com>

# Use the Python 2.7 Software Collection
RUN yum -y install https://www.softwarecollections.org/en/scls/rhscl/python27/epel-7-x86_64/download/rhscl-python27-epel-7-x86_64.noarch.rpm

# Install the Python 2.7 SCL
RUN yum -y install python27

# Install Zato build dependencies
RUN yum -y install gcc postgresql-devel libxml2-devel libxslt-devel \
                   python-devel libyaml-devel

# Create the virtual env, activate it, install deps and ensure migrations exist
WORKDIR /srv/rf-apitest
RUN scl enable python27 -- bash -c "\
    pip install --upgrade pip setuptools wheel && \
    pip install zato-apitest"

# Add the test suite sources
ADD . /srv/rf-apitest

# Drop into an interactive shell prompt when run
CMD scl enable python27 bash
