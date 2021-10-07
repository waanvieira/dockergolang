FROM  golang:1.10-alpine3.8 AS builder
LABEL Wanderson Vieira <wandersonvieiralves-92@hotmail.com>
WORKDIR /usr/src/app
COPY . .
RUN apk add --update --no-cache \
    build-base \ 
    upx && \
    rm -rf /var/cache/apt && \
    rm -rf /var/lib/apt/lists  && \
    CGO_ENABLED=0 GOOS=linux \
    go build -a -installsuffix cgo -ldflags="-s -w" -o codeeducation ./codeeducation.go && \
    upx codeeducation 

FROM scratch
WORKDIR /go/bin
COPY --from=builder /usr/src/app .
ARG VERSION=1.0

CMD ["./codeeducation"]