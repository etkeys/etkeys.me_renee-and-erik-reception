#!/usr/bin/env bash

ENV="$1"

ROOT_DIR="${PWD}"
PUBLISH_DIR="${ROOT_DIR}/.publish"

# Delete existing publish directory (if it exists) and remake it
([ -d "${PUBLISH_DIR}" ] && rm -rf "${PUBLISH_DIR:?.publish}/")
mkdir "${PUBLISH_DIR}"

cd src || exit 1

if [ "${ENV}" == "PROD" ] ; then
    sed -i "s;baseURL: '';baseURL: 'https://renee-and-erik-reception.etkeys.me';" config.yml
else
    sed -i "s;baseURL: '';baseURL: 'https://renee-and-erik-reception.test.etkeys.me';" config.yml
fi

hugo
mv public/* "${PUBLISH_DIR}/"