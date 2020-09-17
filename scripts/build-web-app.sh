#!/bin/sh
set -e
###########################
# Build BitSky Web Application
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `bitsky-ui`. Default is `develop`
# 2. BRANCH_SUPPLIER: git branch for `bitsky-supplier`. Default is `develop`
# 3. TARGET_PATH: which folder to store build files. Default is `dist-supplier-ui`
# 4. NOT_START_SERVER: After build successful don't start server
# 5. SUPPLIER_UI_FOLDER_NAME: folder name for `bitsky-supplier` with `bitsky-ui`. Defualt is `supplier-ui`
# 6. NOT_INSTALL_NODE_MODULES: Don't install node_modules in target folder
# 7. TARGET: ['electron', 'admin', 'ui']

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

if [ -z "${TARGET_PATH}" ]; then
  # Default TARGET_PATH
  TARGET_PATH="bitsky-web-app/"
fi

echo "Target Folder: ${TARGET_PATH}"
echo "Remove previous build files from ${TARGET_PATH}"
# Remove previous build
rm -rf ${TARGET_PATH}/src
rm -rf ${TARGET_PATH}/build
rm -rf ${TARGET_PATH}/package.json
rm -rf ${TARGET_PATH}/app.json
rm -rf ${TARGET_PATH}/openapi.yml
# rm -rf ${TARGET_PATH}/Procfile
rm -rf ${TARGET_PATH}/package-lock.json
rm -rf ${TARGET_PATH}/yarn.lock
rm -rf ${TARGET_PATH}/node_modules
rm -rf ${TARGET_PATH}/.dockerignore
rm -rf ${TARGET_PATH}/Dockerfile

######################################################
echo "Start build BitSky Supplier Service ......"
cd $ROOT_DIR
cd bitsky-supplier
echo "Current Folder: " && pwd
if [ "${BRANCH_SUPPLIER}" ]; then
  git checkout ${BRANCH_SUPPLIER}
  git pull
fi
npm install
npm run tsc
cp -rf build/ ../${TARGET_PATH}/build
cp package.json ../${TARGET_PATH}
cp app.json ../${TARGET_PATH}
cp openapi.yml ../${TARGET_PATH}
# cp Procfile ../${TARGET_PATH}
# cp package-lock.json ../${TARGET_PATH}
cp .dockerignore ../${TARGET_PATH}
cp Dockerfile ../${TARGET_PATH}
echo "Build BitSky Supplier Service successfully"

######################################################
echo "Start build BitSky UI ......"
cd $ROOT_DIR
cd bitsky-ui
echo "Current Folder: " && pwd
if [ "${BRANCH_UI}" ]; then
  git checkout ${BRANCH_UI}
  git pull
fi
npm install
npm run build-"${TARGET}"
cp -rf dist/ ../${TARGET_PATH}/build/public/
echo "Build BitSky UI successfully"

###########################
if [ -z "${NOT_INSTALL_NODE_MODULES}" ]; then
  echo "Install production node_modules..."
  cd $ROOT_DIR
  cd ${TARGET_PATH}
  npm install --production
fi

###########################
# Default start server
if [ -z "${NOT_START_SERVER}" ] && [ -z "${NOT_INSTALL_NODE_MODULES}" ]; then
  echo "Start Server"
  cd $ROOT_DIR
  cd ${TARGET_PATH}
  node ./build/index.js
fi
