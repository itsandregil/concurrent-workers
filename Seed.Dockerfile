FROM debian:stable-slim

COPY seed /bin/seed

CMD ["/bin/seed"]
