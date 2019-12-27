
FROM golang:latest as builder

LABEL maintainer="Patrick O'Shea <poshea@optum.com"

WORKDIR /

RUN go mod download

RUN go build 

COPY ./api /





FROM alpine:latest  

RUN apk --no-cache add ca-certificates \ 
    && apk add --no-cache libgcc openssl pcre perl unzip tzdata luarocks git jq wget tar 

EXPOSE 8080

CMD ["./api"] 