FROM node:8

# Install Pulumi
RUN curl -sSL https://get.pulumi.com/ | bash -s -- --version 0.14.2

# Add to the $PATH
ENV PATH="/root/.pulumi/bin:${PATH}"

