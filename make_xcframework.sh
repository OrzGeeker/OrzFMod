#!/usr/bin/env bash
#-*- coding: utf-8 -*-

PROJECT_NAME="OrzFMod.xcodeproj"
SCHEME="OrzFMod"
BUILD_DIR="./build/${SCHEME}"

IPHONE_OS_ARCHIVE_PATH="${BUILD_DIR}-iphoneos.xcarchive"
IPHONE_SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}-iphonesimulator.xcarchive"
XARCHIVE_FRAMEWORK_SUB_PATH="Products/Library/Frameworks/OrzFMod.framework"

xcodebuild \
    -project ${PROJECT_NAME} \
    -scheme  ${SCHEME} \
    archive SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -archivePath ${IPHONE_OS_ARCHIVE_PATH} \
    -sdk iphoneos

xcodebuild \
    -project ${PROJECT_NAME} \
    -scheme  ${SCHEME} \
    archive SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -archivePath ${IPHONE_SIMULATOR_ARCHIVE_PATH} \
    -sdk iphonesimulator \
    -arch x86_64

xcodebuild -create-xcframework \
    -framework ${IPHONE_OS_ARCHIVE_PATH}/${XARCHIVE_FRAMEWORK_SUB_PATH} \
    -framework ${IPHONE_SIMULATOR_ARCHIVE_PATH}/${XARCHIVE_FRAMEWORK_SUB_PATH} \
    -output ${SCHEME}.xcframework

zip -r "${SCHEME}.xcframework.zip" "${SCHEME}.xcframework" \
    && rm -rf "${SCHEME}.xcframework" \
    && swift package compute-checksum "${SCHEME}.xcframework.zip"
