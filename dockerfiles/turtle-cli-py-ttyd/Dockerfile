FROM python:alpine

RUN addgroup -S turtlecoin && adduser -S turtlecoin -G turtlecoin -s /bin/zsh -h /home/turtlecoin && \
    apk add --no-cache 'su-exec>=0.2'

# Branch to clone
ARG BRANCH=master
ENV BRANCH=${BRANCH}

# Web username
ARG WEB_USERNAME
ENV WEB_USERNAME=${WEB_USERNAME}

# Web username
ARG WEB_PASSWORD
ENV WEB_PASSWORD=${WEB_PASSWORD}

WORKDIR /home/turtlecoin

# add binaries, clone, and delete git
# zsh is needed in order to run tmux from a non root user
RUN apk add --no-cache ttyd zsh tmux && \
    apk add --no-cache --virtual .build-deps git build-base libffi-dev && \
    git clone --branch ${BRANCH} --single-branch https://github.com/turtlecoin/trtl-cli-py.git . && \
    pip install -r requirements.txt && \
    apk del .build-deps

COPY ./docker-entrypoint.sh /usr/local/bin/
COPY zshrc /home/turtlecoin/.zshrc

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["ttyd"]
