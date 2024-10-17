FROM golang:1.20-alpine AS builder

ARG TARGETARCH

WORKDIR /app

RUN apk update && apk add --no-cache git

RUN git clone https://github.com/Kamasoutra/freegeoip.git .

RUN go mod init freegeoip

RUN go mod tidy

RUN go mod vendor

RUN GOARCH=$TARGETARCH go build -mod=vendor -o freegeoip ./cmd/freegeoip

FROM alpine:3.18

WORKDIR /opt/freegeoip

RUN apk add --no-cache curl

RUN mkdir -p /opt/freegeoip/data

RUN curl -L -o /opt/freegeoip/data/GeoLite2-City.mmdb.gz https://cdn.jsdelivr.net/npm/geolite2-city/GeoLite2-City.mmdb.gz

COPY --from=builder /app/freegeoip /opt/freegeoip/

EXPOSE 8080

ENTRYPOINT ["./freegeoip"]
