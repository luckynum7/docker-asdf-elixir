FROM debian:jessie-slim

RUN apt-get update -qq && \
    apt-get upgrade -qq -y && \
    apt-get install -qq -y \
            build-essential \
            autoconf \
            libncurses5-dev \
            libssh-dev \
            unixodbc-dev \
            git \
            curl \
            unzip && \
    apt-get clean -qq -y && \
    apt-get autoclean -qq -y && \
    apt-get autoremove -qq -y && \
    rm -rf /var/cache/debconf/*-old && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/doc/*

ENV LANG C.UTF-8

RUN useradd -ms $(which bash) asdf

ENV PATH /home/asdf/.asdf/bin:/home/asdf/.asdf/shims:$PATH

USER asdf

RUN /bin/bash -c "git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.1 && \
                  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
                  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
                  asdf install erlang 19.2 && \
                  asdf install elixir 1.4.1 && \
                  rm -rf  /tmp/* && \
                  asdf global erlang 19.2 && \
                  asdf global elixir 1.4.1"

# ENV PHX_VER 1.2.1

# RUN ["/bin/bash", "-c", "source ~/.bashrc && \
#       mix local.hex --force && \
#       mix local.rebar --force && \
#       mix archive.install \
#        https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHX_VER.ez \
#        --force"]

# CMD ["/bin/bash"]
