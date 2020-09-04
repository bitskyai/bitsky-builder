#!/bin/sh

###########################
# Build bitsky-supplier, bitsky-ui and bitsky-hello-retailer to bitsky-desktop-app
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `bitsky-ui`
# 2. BRANCH_ENGINE: git branch for `bitsky-supplier`
# 3. BRANCH_ELECTRON: git branch for `bitsky-desktop-app`
# 4. BRANCH_SOI: git branch for `bitsky-hello-retailer`. Default is `develop`
# 5. ENGINE_UI_FOLDER_NAME: folder name for `bitsky-supplier` with `bitsky-ui`. Defualt is `engine-ui`
# 6. DIST: which folder to store build files. Default is `dist-engine-ui`
# 7. SOI_FOLDER_NAME: Folder name for `bitsky-hello-retailer`. Default is `retailerservice`
# 8. NOT_START_SERVER: After build successful don't start server

###########################
ROOT_DIT=$(pwd)
echo $ROOT_DIT
# Build engine-ui first
if [ -z "${DIST}" ]; then
  export DIST="bitsky-desktop-app/app/"
fi

if [ -z "${NOT_START_SERVER}" ]; then
  export NOT_START_SERVER=true
fi

if [ -z "${NOT_INSTALL_NODE_MODULES}" ]; then
  export NOT_INSTALL_NODE_MODULES=true
fi

export TARGET="electron"
./scripts/build-engine-ui.sh

###########################
echo "Start build bitsky-hello-retailer..."
cd $ROOT_DIT

if [ -z "${SOI_FOLDER_NAME}" ]; then
  SOI_FOLDER_NAME="retailerservice"
fi

TARGET_PATH=${DIST}${SOI_FOLDER_NAME}
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./bitsky-hello-retailer
echo "Current Folder: " && pwd
if [ "${BRANCH_SOI}" ]; then
  git checkout ${BRANCH_SOI}
  git pull
fi
# cp -rf src/ ../${TARGET_PATH}/src/
cp index.js ../${TARGET_PATH}/
cp server.js ../${TARGET_PATH}/
cp worker.js ../${TARGET_PATH}/
cp -rf utils ../${TARGET_PATH}/
cp README.md ../${TARGET_PATH}/
cp package.json ../${TARGET_PATH}/
cp -rf public ../${TARGET_PATH}/
echo "Build bitsky-hello-retailer successfully"

###########################
echo "Start copy dia-agents-headless"
cd $ROOT_DIT

if [ -z "${HEADLESS_FOLDER_NAME}" ]; then
  HEADLESS_FOLDER_NAME="agents-headless"
fi
TARGET_PATH=${DIST}${HEADLESS_FOLDER_NAME}
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./dia-agents-headless
echo "Current Folder: " && pwd
if [ "${BRANCH_HEADLESS}" ]; then
  git checkout ${BRANCH_HEADLESS}
  git pull
fi
cp -rf workers/ ../${TARGET_PATH}/workers/
cp index.js ../${TARGET_PATH}/
cp server.js ../${TARGET_PATH}/
cp package.json ../${TARGET_PATH}/
cp agentConfigs.js ../${TARGET_PATH}/
cp utils.js ../${TARGET_PATH}/
echo "Build dia-agents-headless successfully"

###########################
echo "Start copy dia-agents-service"
cd $ROOT_DIT

if [ -z "${SERVICE_FOLDER_NAME}" ]; then
  SERVICE_FOLDER_NAME="agents-service"
fi
TARGET_PATH=${DIST}${SERVICE_FOLDER_NAME}
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./dia-agents-service
echo "Current Folder: " && pwd
if [ "${BRANCH_SERVICE}" ]; then
  git checkout ${BRANCH_SERVICE}
  git pull
fi

cp index.js ../${TARGET_PATH}/
cp server.js ../${TARGET_PATH}/
cp utils.js ../${TARGET_PATH}/
cp package.json ../${TARGET_PATH}/
echo "Build dia-agents-service successfully"

###########################
echo "Start build electron app"
cd $ROOT_DIT

cd ./bitsky-desktop-app
echo "Current Folder: " && pwd
if [ "${BRANCH_ELECTRON}" ]; then
  git checkout ${BRANCH_ELECTRON}
  git pull
fi
yarn install
npm run make