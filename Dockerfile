FROM golang:1.18-alpine as build

MAINTAINER  Jan Baer <info@janbaer.de>

RUN apk add --no-cache gcc musl-dev ca-certificates git

RUN mkdir /src /src/stats /src/bin

WORKDIR /src

# Copy only go.mod and go.sum and than download the dependencies so that they will be cached
COPY ./go.mod ./go.sum ./
RUN go mod download

COPY main.go ./
COPY stats/stats.go stats/

RUN go build -o bin/nsqd-prometheus-exporter main.go

# ------------------------------------
FROM alpine:latest

MAINTAINER  Jan Baer <info@janbaer.de>

COPY --from=build /src/bin/nsqd-prometheus-exporter /bin/nsqd-prometheus-exporter

EXPOSE 30000

CMD [ "/bin/nsqd-prometheus-exporter" ]
