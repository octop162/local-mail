FROM nginx:latest

RUN apt update && \
    apt install -y \
        iproute2 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
