FROM ubuntu:14.04
MAINTAINER Yuri Tolstik <yuri.tolstik@collumino.com>

# Install base package
# Install Erlang & Elixir
# Install hex, rebar
RUN apt-get update && apt-get install -y wget && wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb && rm erlang-solutions_1.0_all.deb && apt-get update && apt-get install -y esl-erlang elixir && apt-get clean all && mix local.hex --force && mix local.rebar --force

