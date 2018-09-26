FROM elquimista/ruby-2.1.4:latest

WORKDIR /app
COPY Gemfile* ./
RUN bundle

ENTRYPOINT ["bundle", "exec"]
