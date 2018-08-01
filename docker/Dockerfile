# Build environment for App:
FROM fpco/stack-build:lts-11.10
MAINTAINER vilas "sarwe.appay@gmail.com"

# Install dependencies:
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
#RUN echo 'deb http://download.fpcomplete.com/ubuntu trusty main' | tee /etc/apt/sources.list.d/fpco.list
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y wget && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && \
    apt-get install -y software-properties-common curl git htop unzip vim byobu && \
    apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        postgresql-server-dev-all \
        postgresql-10 \
        postgresql-contrib \
        libpq-dev \
        libgtk-3-dev \
        checkinstall \
        fakeroot

# setup stack:
RUN stack update && \
    stack setup ghc-8.2.2 && \
    # stack config set resolver lts-11.10 && \
    # or set resolver in '/root/.stack/global-project/stack.yaml'
    stack install --resolver lts-11.10 cabal-install && \
    stack exec cabal update

# prepare db:
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "ALTER ROLE postgres WITH PASSWORD 'postgres';" && \
    psql --command "CREATE USER myserver WITH SUPERUSER PASSWORD 'myserver';" && \
    createdb -O postgres myserver

# nodejs:
USER root
RUN apt-get update && apt-get install -y nodejs && \
    ln -sf /usr/bin/nodejs /usr/bin/node && \
    apt-get purge -y nodejs && \
    # `--unsafe-perm` is workaround
    # -> https://stackoverflow.com/questions/44878798/permission-denied-error-while-attempting-to-install-elm-with-sudo-on-ubuntu
    apt-get install -y npm && npm install --unsafe-perm -g elm

# MyApp
ENV DEV_ROOT=/root/dev \
    PATH=/root/.cabal/bin:/usr/local/bin:/root/.local/bin:/opt/ghc/$GHC_VERSION/bin:$PATH
RUN mkdir -p $DEV_ROOT
WORKDIR $DEV_ROOT
CMD ["/bin/bash"]
