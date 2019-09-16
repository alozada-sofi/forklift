FROM centos:latest
MAINTAINER Matt Conroy <elduderino@mailinator.com>

# Install java 11
RUN yum -y install java-11-openjdk 

# Install bash so that the server can actually run.
RUN yum -y install bash
RUN yum -y install unzip

# Add forklift server
WORKDIR /tmp
ADD server/target/universal/forklift-server-3.7.zip forklift.zip
RUN yes | unzip -d /usr/local forklift.zip
RUN ln -s /usr/local/forklift-server-3.7 /usr/local/forklift

RUN rm forklift.zip
RUN mkdir -p /usr/local/forklift/consumers

ENV FORKLIFT_HOME /usr/local/forklift
ENV FORKLIFT_CONSUMER_HOME /usr/local/forklift/consumers
ENV FORKLIFT_PROPS /usr/local/forklift/props
ENV PATH $PATH:/usr/local/forklift/bin

# Move to forklift
WORKDIR /usr/local/forklift/

# Start a bash shell
CMD ["sh"]
