#!/bin/sh

readonly BUILD_TYPE=${1-debug}
readonly ENV=${2-dev}
flutter build apk --${BUILD_TYPE} --flavor ${ENV}
