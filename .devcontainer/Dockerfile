FROM elixir:1.16.0-slim

ARG USERNAME=vscode

RUN apt-get update && \
    apt-get install -y postgresql-client && \
    apt-get install -y inotify-tools && \
    apt-get install -y vim && \
    apt-get install -y git && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y gnupg2 && \
    apt-get install -y rubygems && \
    apt-get install -y rename && \
    apt-get install -y zsh

RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash -

RUN apt-get update && \
    apt-get install -y nodejs

RUN gem install htmlbeautifier

COPY setup-container.sh .
RUN bash ./setup-container.sh

RUN <<EOF
useradd -s /bin/zsh -m vscode
groupadd docker
usermod -aG docker vscode
EOF

ENV MIX_HOME=/home/vscode/.mix
ENV HEX_HOME=/home/vscode/.hex

RUN mix local.hex --force && \
    mix local.rebar --force
