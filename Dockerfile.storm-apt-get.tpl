# storm %STORM_VERSION% with Daily `apt-get update & upgrade`

FROM storm:%STORM_VERSION%

# This build runs `apt-get update & upgrade` against official Amazon corretto,
# to mitigate any known vulnerabilities due to gaps caused by
# offical image release cycle.

# Install required packages
RUN set -eux \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*; \
# Verify that gosu binary works
    gosu nobody true

# EOF