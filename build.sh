#!/usr/bin/env bash -e
APLLE_SCRIPT='Google Chrome <Profile>.applescript'

echo "Build $APP_NAME"

DIST_DIR='dist'
mkdir -p "${DIST_DIR}"

APP_FILE="${DIST_DIR}/$(basename "${APLLE_SCRIPT%.applescript}").app"

# Compile aplle script to app
echo "Compile applescript to app"
osacompile -o "${APP_FILE}" "${APLLE_SCRIPT}"
echo "created: $PWD/${APP_FILE}"
# set Google Chrome icon as Launcher app icon
cp '/Applications/Google Chrome.app/Contents/Resources/app.icns' "${APP_FILE}/Contents/Resources/applet.icns"

# create dmg 
echo "Create dmg"
DMG_VOLUME_NAME="Google Chrome Launcher"
DMG_FILE="${DIST_DIR}/Google-Chrome-Launcher.dmg"
rm -f "${DMG_FILE}"
hdiutil create -fs HFS+ -srcfolder "${DIST_DIR}" -volname "${DMG_VOLUME_NAME}" "${DMG_FILE}"