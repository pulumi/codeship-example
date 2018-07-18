FROM node:8

# Install Pulumi
RUN curl -sSL https://get.pulumi.com/ | bash -s -- --version 0.14.2

# Add Pulumi to the $PATH
ENV PATH="/root/.pulumi/bin:${PATH}"

# Install docker
RUN apt-get update && \
    apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common && \
     curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs) \
     stable" && \
    apt-get update && \
    apt-get install -y docker-ce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
