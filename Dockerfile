FROM ruby:3.1.2-slim-bullseye

RUN apt update
RUN apt install -y \
  build-essential \
  git \
  npm \
  libsqlite3-dev
RUN npm i -g yarn
RUN gem install sqlite
RUN gem install rails

COPY ./blog /usr/src/app

WORKDIR /usr/src/app

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]