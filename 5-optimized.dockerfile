FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

COPY --from=builder /app/server /server

EXPOSE 8080

USER 1000

ENTRYPOINT ["/server"]
