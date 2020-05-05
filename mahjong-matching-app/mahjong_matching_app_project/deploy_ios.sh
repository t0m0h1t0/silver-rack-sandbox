#!/bin/sh

readonly BUILD_TYPE=${1-debug}
readonly ENV=${2-dev}
flutter build ios --${BUILD_TYPE} --no-codesign --flavor ${ENV}
