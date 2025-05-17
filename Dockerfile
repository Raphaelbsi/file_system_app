FROM ruby:3.4.4

# Instala dependências
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libyaml-dev \
  nodejs \
  yarn \
  postgresql-client

# Define diretório de trabalho
WORKDIR /app

# Copia Gemfile e instala Rails
COPY Gemfile Gemfile.lock ./
RUN gem install rails -v 8.0.2 && bundle install

# Copia os demais arquivos
COPY . .

CMD ["bash"]
