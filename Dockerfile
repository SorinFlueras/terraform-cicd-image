# Pull base image.
FROM ubuntu:latest

RUN \
# Update
apt-get update -y && \
# Install Unzip
apt-get install unzip -y && \
# need wget
apt-get install wget -y && \
# vim
apt-get install vim -y

################################
# Install Terraform
################################

# Download terraform for linux
RUN wget https://releases.hashicorp.com/terraform/0.14.9/terraform_0.14.9_linux_amd64.zip

# Unzip
RUN unzip terraform_0.14.9_linux_amd64.zip

# Move to local bin
RUN mv terraform /usr/local/bin/
# Check that it's installed
RUN terraform --version 

################################
# Install Go
################################

# Download and unzip
RUN wget https://golang.org/dl/go1.15.5.linux-amd64.tar.gz

# Extract
RUN tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz

# Adjust the Path variable
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile

# Load the new Path variable into the current shell
RUN /bin/bash -c "source ~/.profile"

# Check install
RUN go version

################################
# Install python
################################

RUN apt-get install -y python3-pip
#RUN ln -s /usr/bin/python3 python
RUN pip3 install --upgrade pip
RUN python3 -V
RUN pip --version

################################
# Install tfsec
################################

# Download and install
RUN go get -u github.com/tfsec/tfsec/cmd/tfsec

# Check install
RUN tfsec --version