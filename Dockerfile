FROM bitwalker/alpine-elixir:1.6.6

RUN apk add --no-cache --update py-pip \
      # to remove the pesky "cache is not owned by the user directory warning"
      && chown -R root /opt/app \
      # to remove the "upgrade pip" warngin
      && pip install --upgrade pip \
      && pip install awscli \
      # default is the user we want to use to run our app
      && chown -R default /opt/app

COPY ./bootstrap.sh /usr/local/bin

USER default

CMD ["/usr/local/bin/boostrap.sh"]
