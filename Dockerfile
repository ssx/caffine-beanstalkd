FROM ubuntu:14.04
MAINTAINER Scott Wilcox <scott@dor.ky>

# stop upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# update apt
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y beanstalkd

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/data"]
EXPOSE 11300
CMD ["/usr/bin/beanstalkd", "-f", "60000", "-b", "/data"]
