FROM ubuntu:16.04
MAINTAINER Yuri Tolstik <yuri.tolstik@collumino.com>

# Important!  Update this no-op ENV variable when this Dockerfile
# is updated with the current date. It will force refresh of all
# of the base images and things like `apt-get update` won't be using
# old cached versions when the Dockerfile is built.
ENV REFRESHED_AT 2016-05-06

# Set the locale for elixir
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /usr/local

# Install erlang from erlang solutions package
RUN apt-get update && \
  apt-get install -y wget unzip  && \
  wget -q http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm -f erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install -y esl-erlang && \
  apt-get clean all && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install elixir from precompiled release
ENV ELIXIR_VERSION 1.2.5
RUN wget -q "https://github.com/elixir-lang/elixir/releases/download/v$ELIXIR_VERSION/Precompiled.zip" && \
  unzip Precompiled.zip && \
  rm -f Precompiled.zip
#  mv /tmp/bin/elixirc /usr/local/bin/elixirc && \
#  mv /tmp/bin/elixir /usr/local/bin/elixir && \
#  mv /tmp/bin/mix /usr/local/bin/mix && \
#  mv /tmp/bin/iex /usr/local/bin/iex && \
#  rm -rf /tmp/*

# Install local elixir hex and rebar
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

WORKDIR /

