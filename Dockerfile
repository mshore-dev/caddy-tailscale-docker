FROM golang:1-alpine AS builder

RUN apk add --no-cache git
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
ENV XCADDY_SETCAP 0
ENV GOPROXY direct
RUN xcaddy build latest --with github.com/mshore-dev/caddy-tailscale@main --output /usr/bin/caddy

FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
