#!/usr/bin/env bash
#-*- coding: utf-8 -*-
# 参考文档： https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle

PROJECT_NAME="OrzFMod.xcodeproj"
SCHEME="FModAPI"
BUILD_DIR="./build"
ARVHIVE_DIR="${BUILD_DIR}/archives"

IPHONEOS_SCHEME="${SCHEME}-iphoneos"
IPHONE_SIMULATOR_SCHEMA="${SCHEME}-Simulator"
MACOS_SCHEME="${SCHEME}-macos"

IPHONE_OS_ARCHIVE_PATH="${ARVHIVE_DIR}/${IPHONEOS_SCHEME}.xcarchive"
IPHONE_SIMULATOR_ARCHIVE_PATH="${ARVHIVE_DIR}/${IPHONE_SIMULATOR_SCHEMA}.xcarchive"
MACOS_ARCHIVE_PATH="${ARVHIVE_DIR}/${MACOS_SCHEME}.xcarchive"

XCFRAMEWORK="${BUILD_DIR}/${SCHEME}.xcframework"
XCFRAMEWORK_ZIP="${XCFRAMEWORK}.zip"

# rm -rf ${BUILD_DIR}

# iOS-Simulator
# xcodebuild \
#     -project ${PROJECT_NAME} \
#     -scheme  ${SCHEME} \
#     -archivePath ${IPHONE_SIMULATOR_ARCHIVE_PATH} \
#     -destination "generic/platform=iOS Simulator" \
#     archive SKIP_INSTALL=NO \
#     BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# iOS
# xcodebuild \
#     -project ${PROJECT_NAME} \
#     -scheme  ${SCHEME} \
#     -archivePath ${IPHONE_OS_ARCHIVE_PATH} \
#     -destination "generic/platform=iOS" \
#     archive SKIP_INSTALL=NO \
#     BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# macOS
# xcodebuild \
#     -project ${PROJECT_NAME} \
#     -scheme  ${SCHEME} \
#     -archivePath ${MACOS_ARCHIVE_PATH} \
#     -destination "generic/platform=macOS" \
#     archive SKIP_INSTALL=NO \
#     BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild -create-xcframework \
    -archive ${IPHONE_OS_ARCHIVE_PATH} -framework ${SCHEME}.framework \
    -archive ${IPHONE_SIMULATOR_ARCHIVE_PATH} -framework ${SCHEME}.framework  \
    -archive ${MACOS_ARCHIVE_PATH} -framework ${SCHEME}.framework  \
    -output ${XCFRAMEWORK}

if [ $? -eq 0 ]; then
    zip -r "${XCFRAMEWORK_ZIP}" "${XCFRAMEWORK}"    
    
    xcframework_zip_checksum=$(swift package compute-checksum "${XCFRAMEWORK_ZIP}")
    
    echo 
    echo xcframework checksum: 
    echo "    $xcframework_zip_checksum"

    echo "$xcframework_zip_checksum" | cat > "${BUILD_DIR}/$(basename ${XCFRAMEWORK_ZIP}).checksum"

    xcframework_name=$(basename ${XCFRAMEWORK})
    if [ -d "${xcframework_name}" ]; then
        rm -rf "${xcframework_name}"
    fi
    mv -f "${XCFRAMEWORK}" .
fi