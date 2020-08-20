FROM alpine

RUN mkdir -p /etc/stunnel
VOLUME ["/etc/stunnel"]

ADD ./config/stunnel/stunnel.conf /etc/stunnel/stunnel.conf
ADD ./config/stunnel/fullchain.pem /etc/stunnel/stunnel.fullchain.pem
ADD ./config/stunnel/privkey.pem /etc/stunnel/stunnel.key.pem

ADD ./config/stunnel/start_stunnel.sh /start_stunnel.sh

RUN apk update \
    && apk add install stunnel \
    && apk add install net-tools
RUN chmod 600 /etc/stunnel/stunnel.fullchain.pem \
    && chmod 600 /etc/stunnel/stunnel.key.pem

CMD ["/start_stunnel.sh"]
