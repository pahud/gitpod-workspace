FROM public.ecr.aws/jsii/superchain:1-bookworm-slim-node20

ARG KUBECTL_URL='https://s3.us-west-2.amazonaws.com/amazon-eks/1.30.0/2024-05-12/bin/linux/amd64/kubectl'
ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
ARG TERRAFORM_URL='https://releases.hashicorp.com/terraform/1.9.2/terraform_1.9.2_darwin_amd64.zip'
ARG SESSION_MANAGER_PLUGIN='https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb'


USER root:root
# install jq wget
RUN apt-get update && apt-get install -y jq wget

# install aws-cli v2
RUN mv $(which aws) /usr/local/bin/awscliv1 && \
  mkdir /tmp/awscliv2 && cd /tmp/awscliv2 && \
  curl "${AWS_CLI_V2_URL}" -o "awscliv2.zip" && \
  unzip awscliv2.zip && \
  ./aws/install -b /usr/local/bin --update && \
  rm -rf /tmp/awscliv2 && \
  aws --version

# install kubectl
RUN curl -o kubectl "${KUBECTL_URL}" && \
  chmod +x kubectl && \
  mv kubectl /usr/local/bin

# install terraform
RUN curl -o terraform.zip "${TERRAFORM_URL}" && \
  unzip terraform.zip && \
  mv terraform /usr/local/bin/ && \
  rm -f terraform.zip

# install session-manager-plugin(required for aws ssm start-session)
RUN curl "${SESSION_MANAGER_PLUGIN}" -o "session-manager-plugin.deb" && \
  dpkg -i session-manager-plugin.deb && \
  rm -f session-manager-plugin.deb

USER superchain:superchain
