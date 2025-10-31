FROM alpine:latest

RUN apk --no-cache add curl
RUN adduser -D hugo
USER hugo
ENTRYPOINT [ "curl" ]