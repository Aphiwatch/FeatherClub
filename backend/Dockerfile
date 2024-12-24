FROM golang:1.23-alpine

WORKDIR /app

RUN go install github.com/air-verse/air@latest

COPY go.mod ./

RUN go mod download

CMD ["air", "-c", ".air.toml"]