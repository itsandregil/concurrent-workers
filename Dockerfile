FROM debian:stable-slim

COPY worker /bin/worker

CMD ["/bin/worker"]
