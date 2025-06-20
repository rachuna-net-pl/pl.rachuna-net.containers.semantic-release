FROM alpine:3.21.2

ARG CONTAINER_VERSION="0.0.0"

LABEL Author='Maciej Rachuna'
LABEL Application='pl.rachuna-net.containers.semantic-release'
LABEL Description='semantic-release container image'
LABEL version="${CONTAINER_VERSION}"

RUN apk add --no-cache \
        bash \
        curl \
        git \
        jq \
        nodejs \
        npm \    
        openssh-client \
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

