FROM node:8

# Install Pulumi
RUN curl -sSL https://get.pulumi.com/ | bash -s -- --version 0.14.2

# Add Pulumi to the $PATH
ENV PATH="/root/.pulumi/bin:${PATH}"

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

RUN yarn run tsc