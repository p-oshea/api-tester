
FROM golang:latest as builder

LABEL maintainer="Patrick O'Shea <poshea@optum.com"
#ENV GOPATH=/go/

WORKDIR /
ADD * ./

#COPY go.mod go.sum ./
#COPY assets/ .
#COPY datastore/ .
#COPY loader/ .
#COPY routes.go .
#COPY server.go .

#RUN go mod download
COPY . .
RUN go build .




FROM alpine:latest  

RUN apk --no-cache add ca-certificates \ 
    && apk add --no-cache libgcc openssl pcre perl unzip tzdata luarocks git jq wget tar 

COPY --from=builder /api .
COPY --from=builder /assets/ .

EXPOSE 8080

CMD ["./api"] 