#Build Stage 

FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run stage
FROM alpine
WORKDIR /app
COPY --from=builder /app/main .
COPY migrate ./migrate
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration
COPY start.sh .

# ENV DB_SOURCE=$DB_SOURCE

EXPOSE 8080
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]