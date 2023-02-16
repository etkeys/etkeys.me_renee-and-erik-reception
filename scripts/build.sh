#!/usr/bin/env bash

ENV="$1"

ROOT_DIR="${PWD}"
PUBLISH_DIR="${ROOT_DIR}/.publish"

# Delete existing publish directory (if it exists) and remake it
([ -d "${PUBLISH_DIR}" ] && rm -rf "${PUBLISH_DIR:?.publish}/")
mkdir "${PUBLISH_DIR}"

cd src || exit 1

# Update the baseURL value from DEV value to TEST/PROD specific value
if [ "${ENV}" == "PROD" ] ; then
    sed -i "s;baseURL: '';baseURL: 'https://renee-and-erik-reception.etkeys.me';" config.yml
else
    sed -i "s;baseURL: '';baseURL: 'https://test.renee-and-erik-reception.etkeys.me';" config.yml
fi

# Build the static site files
hugo

# Move static files to deployment pick-up location
mv public/* "${PUBLISH_DIR}/"