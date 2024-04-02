FROM amazon/aws-cli as awscli

RUN yum install pip -y && yum clean all
