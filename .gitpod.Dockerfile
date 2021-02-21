FROM jsii/superchain
RUN curl -o /tmp/slirp4netns-0.4.3-4.el7_8.x86_64.rpm http://mirror.centos.org/centos/7/extras/x86_64/Packages/slirp4netns-0.4.3-4.el7_8.x86_64.rpm \
&& yum install -y jq sudo docker && yum install -y /tmp/slirp4netns-0.4.3-4.el7_8.x86_64.rpm && rm -f /tmp/slirp4netns-0.4.3-4.el7_8.x86_64.rpm

RUN npm i -g aws-cdk

RUN mv $(which aws) /usr/bin/aws_V1

ARG USERNAME=gitpod
ARG USER_UID=33333
ARG USER_GID=33333

# Setup user
RUN adduser $USERNAME -s /bin/sh -u $USER_UID -U && \
  mkdir -p /etc/sudoers.d && \
  echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
  chmod 0440 /etc/sudoers.d/$USERNAME

# install aws-cli v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install

# install kubectl
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl \
  && chmod +x kubectl && mv kubectl /usr/local/bin/
