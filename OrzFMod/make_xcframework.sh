#!/usr/bin/env bash
#-*- coding: utf-8 -*-
# 参考文档： https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle

PROJECT_NAME="OrzFMod.xcodeproj"
SCHEME="OrzFMod"
BUILD_DIR="./build"
ARVHIVE_DIR="${BUILD_DIR}/archives"

IPHONEOS_SCHEME="${SCHEME}"
IPHONE_SIMULATOR_SCHEMA="${IPHONEOS_SCHEME}-Simulator"

IPHONE_OS_ARCHIVE_PATH="${ARVHIVE_DIR}/${IPHONEOS_SCHEME}.xcarchive"
IPHONE_SIMULATOR_ARCHIVE_PATH="${ARVHIVE_DIR}/${IPHONE_SIMULATOR_SCHEMA}.xcarchive"

XCFRAMEWORK="${BUILD_DIR}/${SCHEME}.xcframework"
XCFRAMEWORK_ZIP="${XCFRAMEWORK}.zip"

rm -rf ${BUILD_DIR}

xcodebuild \
    -project ${PROJECT_NAME} \
    -scheme  ${IPHONEOS_SCHEME} \
    -archivePath ${IPHONE_OS_ARCHIVE_PATH} \
    -destination "generic/platform=iOS" \
    archive SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \


xcodebuild \
    -project ${PROJECT_NAME} \
    -scheme  ${IPHONE_SIMULATOR_SCHEMA} \
    -archivePath ${IPHONE_SIMULATOR_ARCHIVE_PATH} \
    -destination "generic/platform=iOS Simulator" \
    archive SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \

xcodebuild -create-xcframework \
    -archive ${IPHONE_OS_ARCHIVE_PATH} -framework ${IPHONEOS_SCHEME}.framework \
    -archive ${IPHONE_SIMULATOR_ARCHIVE_PATH} -framework ${IPHONE_SIMULATOR_SCHEMA}.framework  \
    -output ${XCFRAMEWORK}

zip -r "${XCFRAMEWORK_ZIP}" "${XCFRAMEWORK}" && swift package compute-checksum "${XCFRAMEWORK_ZIP}"
