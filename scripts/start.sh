#! /bin/bash

GOOS=linux GOARCH=amd64 go build -o worker ./cmd/worker/main.go
GOOS=linux GOARCH=amd64 go build -o seed ./cmd/seed/main.go

docker compose up --build
