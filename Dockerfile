FROM ubuntu:14.04

# A proof-of-concept for Riemann
# Based on http://kartar.net/2014/12/an-introduction-to-riemann/

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  apt-add-repository -y ppa:brightbox/ruby-ng && \
  apt-get update && \
  apt-get install -y ruby-switch ruby2.2 ruby2.2-dev && \
  apt-get install -y default-jre ruby-dev build-essential && \
  apt-get install -y curl

RUN cd /tmp && \
  curl -O https://aphyr.com/riemann/riemann_0.2.10_all.deb && \
  dpkg -i riemann*.deb && \
  rm -f riemann*.deb

RUN apt-get install -y zlib1g-dev
RUN ruby-switch --set ruby2.2
RUN gem install --no-ri --no-rdoc riemann-client riemann-tools riemann-dash

# Ruby app
RUN mkdir /app && gem install bundle --no-ri --no-rdoc
WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install

ADD riemann.config /etc/riemann/
ADD . /app/
