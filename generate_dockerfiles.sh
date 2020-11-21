#!/bin/bash

set -o pipefail -e

# TEMPLATES
# Dockerfile.storm-apt.tpl
# test-image.sh.tpl
# test-image.yaml.tpl

STORM_VERSIONS=(1.1 1.2 2.1 2.2)
SUFFIX="apt"

gen_dockerfile() {
  DOCKERFILE_TEMPLATE="Dockerfile.storm-apt.tpl"
  TEST_IMAGE_SH_TEMPLATE="test-image.sh.tpl"
  TEST_IMAGE_YAML_TEMPLATE="test-image.yaml.tpl"

  DOCKERFILE_TARGET="${STORM_VERSION}-${SUFFIX}/Dockerfile"
  TEST_IMAGE_SH_TARGET="${STORM_VERSION}-${SUFFIX}/test-image.sh"
  TEST_IMAGE_YAML_TARGET="${STORM_VERSION}-${SUFFIX}/test-image.yaml"

  DOCKERFILE_TARGET_DIR="$(dirname ${DOCKERFILE_TARGET})"
  echo -en "Generating Dockerfile for ${STORM_VERSION}.. "
  if [ ! -r ${DOCKERFILE_TEMPLATE} ]; then
    echo "failed"
    echo "Missing Dockerfile template ${DOCKERFILE_TEMPLATE}"
    exit 1
  fi

  # create target dockerfile dir
  if [ ! -e ${DOCKERFILE_TARGET_DIR} ]; then
    mkdir -p ${DOCKERFILE_TARGET_DIR}
  fi

  sed "s/%STORM_VERSION%/${STORM_VERSION}/g;" \
    ${DOCKERFILE_TEMPLATE} > ${DOCKERFILE_TARGET} && \
  sed "s/%STORM_VERSION%/${STORM_VERSION}/g;" \
    ${TEST_IMAGE_SH_TEMPLATE} > ${TEST_IMAGE_SH_TARGET} && \
  sed "s/%STORM_VERSION%/${STORM_VERSION}/g;" \
    ${TEST_IMAGE_YAML_TEMPLATE} > ${TEST_IMAGE_YAML_TARGET} && \
  echo "done" || \
  echo "failed"
}

for version in ${STORM_VERSIONS[@]}; do
  STORM_VERSION=$(echo $version)

  gen_dockerfile

done

echo -n "Generating symlinks for current versions.. "
latest_version=$(echo "${STORM_VERSIONS[@]}" | tr ' ' '\n\' | uniq | sort -n | tail -n1)
latest="${latest_version}-${SUFFIX}"
[ -e current ] && rm current || true
ln -s ${latest} current
echo "done"
