FROM alpine:latest

# We need this before install.
COPY ssl /var/lib/puppet/ssl/
COPY install.sh /
RUN /install.sh

EXPOSE 8080
EXPOSE 8081

COPY start.sh /
ENTRYPOINT ["/start.sh"]
