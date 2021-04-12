xcodebuild \
    -project MyTestFramework/MyTestFramework.xcodeproj \
    -scheme MyTestFramework \
    -configuration Release \
    -arch arm64 \
    -sdk macosx \
    -derivedDataPath $1/obj \
    -archivePath $1/bin \
    archive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

rm -rf  $1/obj
