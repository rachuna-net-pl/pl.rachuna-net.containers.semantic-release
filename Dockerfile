FROM ubuntu:noble

ARG CONTAINER_VERSION="0.0.0"

LABEL Author="Maciej Rachuna"
LABEL Application="pl.rachuna-net.containers.vault"
LABEL Description="vault container image"
LABEL version="${CONTAINER_VERSION}"

ENV DEBIAN_FRONTEND=noninteractive

COPY scripts/ /opt/scripts/

# Install system dependencies and ansible
RUN apt-get update && apt-get install -y \
        bash \
        curl \
        git \
        jq \
        npm \    
        openssh-client \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    # Install semantic-release
    && npm install -g \
        semantic-release \
        @semantic-release/gitlab \
        @semantic-release/release-notes-generator \
        @semantic-release/commit-analyzer \
        conventional-changelog-conventionalcommits@8 \
        conventional-changelog-angular \
        @semantic-release/exec \
        @semantic-release/git \
        @semantic-release/changelog \
        @semantic-release/git \

# Make scripts executable
    && chmod +x /opt/scripts/*.bash \

    # Create a non-root user and set permissions
    && useradd -m -s /bin/bash nonroot \
    && chown -R nonroot:nonroot /opt/scripts

USER nonroot

ENTRYPOINT [ "/opt/scripts/entrypoint.bash" ]