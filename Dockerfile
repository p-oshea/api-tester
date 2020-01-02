# golang building image is huge, running builder stage to keep image smaller

FROM golang:latest as builder

LABEL maintainer="Patrick O'Shea <poshea@optum.com"

WORKDIR /app
COPY . /app

# install build dependencies for Go
RUN go get -v ./...

# build bookdata-api, originally from https://github.com/moficodes/bookdata-api
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bookdata-api



# kick off the second stage jams

FROM alpine:latest  

# install core system packages, utils and useful assets
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
        bash \
        bind-tools \
        procps \
        iptraf-ng \
        busybox-extras \
        sysstat \
        nmap \
        iotop \
        htop \
        lsof \
        tcpdump

WORKDIR /root/

# copy over build data
COPY --from=builder /app/ .

EXPOSE 8080

RUN "chmod" "+x" "./bookdata-api"
RUN "chmod" "+w" "./assets/books.csv"

CMD ["./bookdata-api"] 