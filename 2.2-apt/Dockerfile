# storm 2.2 with daily `apt-get update & upgrade`

FROM storm:2.2

# This build runs `apt-get update` against Docker official Storm image,
# to mitigate any known vulnerabilities due to gaps caused by
# offical image release cycle.

# Install required packages
RUN set -eux \
    && apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*; \
# Verify that gosu binary works
    gosu nobody true

USER storm

# EOF