FROM debian:testing-slim

RUN apt-get update
RUN apt-get install -y curl wget wordnet build-essential git locales wngerman aspell unzip && \
  apt-get install -y libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev && \
  apt-get clean

RUN \
  echo "LC_ALL=en_US.UTF-8" >> /etc/environment && \
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
  echo "LANG=en_US.UTF-8" >> /etc/locale.conf && \
  locale-gen en_US.UTF-8 && update-locale

RUN \
  useradd user && \
  mkdir -p /home/user/repos && \
  chown -R user:user /home/user

USER user
COPY --chown=user:user . /home/user/repos/configs/
WORKDIR /home/user/repos/configs
RUN touch /usr/share/dict/words; ./deploy.sh cli tools;

RUN rm -rf /home/user/.cache/* && \
  rm -rf /home/user/.asdf/installs/golang/*/packages/pkg/mod/cache/*

WORKDIR /home/user

ENTRYPOINT ["/usr/bin/env", "bash", "--login"]
