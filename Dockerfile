# Xray VLESS + WebSocket node for Railway (US West)
# Railway edge terminates TLS on the public domain and forwards plain HTTP
# WebSocket to this container. No secrets are baked into the image:
# UUID / WS_PATH come from Railway environment variables at runtime.
FROM alpine:3.21

RUN apk add --no-cache ca-certificates curl unzip \
  && curl -L -o /tmp/xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip \
  && unzip /tmp/xray.zip -d /usr/local/bin/ \
  && chmod +x /usr/local/bin/xray \
  && rm /tmp/xray.zip \
  && apk del curl unzip

COPY config.template.json /etc/xray/config.template.json
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
