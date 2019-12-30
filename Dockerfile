
FROM golang:latest as builder

LABEL maintainer="Patrick O'Shea <poshea@optum.com"

WORKDIR /app
COPY . /app
RUN go get -v ./...
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bookdata-api

# second stage

FROM alpine:latest  

RUN apk --no-cache add ca-certificates \
    && apk add --no-cache \
    openssl \
    pcre \
    perl \
    unzip \
    tzdata \
    git \
    jq \
    wget \
    tar \
    curl \
    tcpdump 

WORKDIR /root/

COPY --from=builder /app/ .

EXPOSE 8080

RUN "chmod" "+x" "./bookdata-api"
RUN "chmod" "+w" "./assets/books.csv"

RUN chmod -R 755 /app/


CMD ["./bookdata-api"] 