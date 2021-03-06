FROM node:12-buster-slim

# Follow the principle of least privilege: run as unprivileged user.
#
# Running as non-root enables running this image in platforms like OpenShift
# that do not allow images running as root.
RUN set -ex; \
    useradd --uid 5001 --create-home etherpad

ARG ETHERPAD_VERSION=master

ADD --chown=etherpad:etherpad https://github.com/ether/etherpad-lite/archive/${ETHERPAD_VERSION}.tar.gz ./

RUN set -ex; \
    apt-get update -q; \
    apt-get install -y --no-install-recommends \
        netcat \
        python \
        sqlite3 \
    ; \
    python --version; \
    export PYTHON=$(command -v python); \
    rm -rf /var/lib/apt/lists/*; \
    tar -xzf ${ETHERPAD_VERSION}.tar.gz; \
    rm -f ${ETHERPAD_VERSION}.tar.gz; \
    mkdir -p /opt; \
    mv "etherpad-lite-${ETHERPAD_VERSION}" \
        /opt/etherpad-lite \
    ; \
    chown -R etherpad:etherpad /opt/etherpad-lite

USER etherpad:etherpad

WORKDIR /opt/etherpad-lite

# Add entrypoint
COPY --chown=etherpad:etherpad entrypoint.sh /opt/etherpad-lite

# Set the following to production to avoid installing devDeps
# this can be done with build args (and is mandatory to build ARM version)
ENV NODE_ENV=production

# Add requirements and install application
RUN set -ex; \
    ./bin/installDeps.sh; \
    npm install sqlite3; \
	rm -rf ~/.npm/_cacache

# Allow changes to settings.conf as well as the Sqlite database being persistent.
VOLUME /opt/etherpad-lite/var

# plugins to install while building the container. By default no plugins are
# installed.
# If given a value, it has to be a space-separated, quoted list of plugin names.
#
# EXAMPLE:
#   ETHERPAD_PLUGINS="ep_codepad ep_author_neat"
#
# Available Etherpad plugins: https://static.etherpad.org/plugins.html
ARG ETHERPAD_PLUGINS="ep_hash_auth ep_markdown ep_ldapauth ep_piwik ep_webpack"

# Install the plugins, if ETHERPAD_PLUGINS is not empty.
#
# Bash trick: in the for loop ${ETHERPAD_PLUGINS} is NOT quoted, in order to be
# able to split at spaces.
RUN set -ex; \
    for PLUGIN_NAME in ${ETHERPAD_PLUGINS}; do npm install "${PLUGIN_NAME}"; done

# Copy the configuration file.
COPY --chown=etherpad:etherpad ./settings.json /opt/etherpad-lite/settings.json

EXPOSE 9001
ENTRYPOINT ["/opt/etherpad-lite/entrypoint.sh"]
CMD ["node", "node_modules/ep_etherpad-lite/node/server.js"]

# Arguments to label built container
ARG VCS_REF
ARG BUILD_DATE

# Container labels (http://label-schema.org/)
# Container annotations (https://github.com/opencontainers/image-spec)
LABEL maintainer="Monogramm maintainers <opensource at monogramm dot io>" \
      product="Etherpad" \
      version=$ETHERPAD_VERSION \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Monogramm/docker-etherpad" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Etherpad" \
      org.label-schema.description="Real-time collaborative document editor." \
      org.label-schema.url="https://etherpad.org/" \
      org.label-schema.vendor="Etherpad" \
      org.label-schema.version=$ETHERPAD_VERSION \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/Monogramm/docker-etherpad" \
      org.opencontainers.image.created=$BUILD_DATE \
      org.opencontainers.image.title="Etherpad" \
      org.opencontainers.image.description="Real-time collaborative document editor." \
      org.opencontainers.image.url="https://etherpad.org/" \
      org.opencontainers.image.vendor="Etherpad" \
      org.opencontainers.image.version=$ETHERPAD_VERSION \
      org.opencontainers.image.authors="Monogramm maintainers <opensource at monogramm dot io>"
