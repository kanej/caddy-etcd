FROM alpine:3.5
MAINTAINER John Kane <john@kanej.me>

LABEL caddy_version="0.9.5" architecture="amd64"

RUN apk add --no-cache curl

# install caddy
RUN curl --silent --show-error --fail --location \
    --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
    "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
      && chmod 0755 /usr/bin/caddy \
      && /usr/bin/caddy -version

EXPOSE 80 443 2015
WORKDIR /srv

COPY Caddyfile /etc/Caddyfile

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile", "--log", "stdout"]
