FROM alpine

ADD docker_test.sh /docker_test.sh

RUN set -ex; \
    echo 'PREPARE TEST OPERATIONS'; \
    chmod 755 /docker_test.sh;

CMD ["/docker_test.sh"]
