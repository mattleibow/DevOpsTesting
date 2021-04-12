xcodebuild \
    -project MyTestFramework/MyTestFramework.xcodeproj \
    -scheme MyTestFramework \
    -configuration Release \
    -arch arm64 \
    -sdk macosx \
    -derivedDataPath $1/obj/Release/macosx/arm64 \
    -archivePath $1/bin/Release/macosx/arm64 \
    archive SKIP_INSTALL=NO BUILD_LIBRARIES_FOR_DISTRIBUTION=YES
