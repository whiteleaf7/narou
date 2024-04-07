FROM ruby:3.3

COPY . /app

WORKDIR /app

RUN gem install bundler --no-document
RUN bundle install
ENV PATH /app/bin:$PATH

WORKDIR /opt/narou

EXPOSE 8000
EXPOSE 8001

VOLUME /opt/narou

RUN touch /app/commitversion

ENTRYPOINT [ "ruby", "/app/bin/narou" ]

CMD ["web", "-np", "8000"]