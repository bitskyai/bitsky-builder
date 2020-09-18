#!/bin/sh
set -e
####################################################################################
# Build bitsky-supplier, bitsky-ui and bitsky-hello-retailer to bitsky-desktop-app
####################################################################################
# Available Envs:
# 1. BRANCH_UI: git branch for `bitsky-ui`
# 2. BRANCH_SUPPLIER: git branch for `bitsky-supplier`
# 3. BRANCH_ELECTRON: git branch for `bitsky-desktop-app`
# 4. BRANCH_RETAILER: git branch for `bitsky-hello-retailer`. Default is `develop`
# 5. SUPPLIER_UI_FOLDER_NAME: folder name for `bitsky-supplier` with `bitsky-ui`. Defualt is `supplier-ui`
# 6. DIST: which folder to store build files. Default is `dist-supplier-ui`
# 7. RETAILER_FOLDER_NAME: Folder name for `bitsky-hello-retailer`. Default is `retailerservice`
# 8. NOT_START_SERVER: After build successful don't start server

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

if [ -z "${DIST}" ]; then
  export DIST="bitsky-desktop-app/app"
fi

###########################
# Build BitSky Web App
echo "Start build BitSky Web App ......"
# Don't start BitSky Supplier Service
export NOT_START_SERVER=true
# Don't install Node Modules
export NOT_INSTALL_NODE_MODULES=true
# Target UI is Electron
export TARGET="electron"
# Generated Folder
export TARGET_PATH="${DIST}/web-app"
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
./scripts/build-web-app.sh

echo "Build BitSky Web App successfully"

###########################
echo "Start build BitSky Hello Retailer ......"
cd $ROOT_DIR

if [ -z "${RETAILER_FOLDER_NAME}" ]; then
  RETAILER_FOLDER_NAME="hello-retailer"
fi

TARGET_PATH="${DIST}/${RETAILER_FOLDER_NAME}"
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./bitsky-hello-retailer
echo "Current Folder: " && pwd
if [ "${BRANCH_RETAILER}" ]; then
  git checkout ${BRANCH_RETAILER}
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
echo "Build BitSky Hello Retailer successfully"

###########################
echo "Start copy BitSky Headless Producer ......"
cd $ROOT_DIR

if [ -z "${HEADLESS_FOLDER_NAME}" ]; then
  HEADLESS_FOLDER_NAME="headless-producer"
fi
TARGET_PATH="${DIST}/${HEADLESS_FOLDER_NAME}"
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./bitsky-headless-producer
echo "Current Folder: " && pwd
if [ "${BRANCH_HEADLESS}" ]; then
  git checkout ${BRANCH_HEADLESS}
  git pull
fi
cp -rf workers/ ../${TARGET_PATH}/workers/
cp index.js ../${TARGET_PATH}/
cp server.js ../${TARGET_PATH}/
cp package.json ../${TARGET_PATH}/
cp producerConfigs.js ../${TARGET_PATH}/
cp utils.js ../${TARGET_PATH}/
echo "Build BitSky Headless Producer successfully"

###########################
echo "Start copy BitSky Service Producer ......"
cd $ROOT_DIR

if [ -z "${SERVICE_FOLDER_NAME}" ]; then
  SERVICE_FOLDER_NAME="service-producer"
fi
TARGET_PATH="${DIST}/${SERVICE_FOLDER_NAME}"
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./bitsky-service-producer
echo "Current Folder: " && pwd
if [ "${BRANCH_SERVICE}" ]; then
  git checkout ${BRANCH_SERVICE}
  git pull
fi

cp index.js ../${TARGET_PATH}/
cp server.js ../${TARGET_PATH}/
cp utils.js ../${TARGET_PATH}/
cp package.json ../${TARGET_PATH}/
echo "Build BitSky Service Producer successfully"

###########################
echo "Start build electron app"
cd $ROOT_DIR

cd ./bitsky-desktop-app
echo "Current Folder: " && pwd
if [ "${BRANCH_ELECTRON}" ]; then
  git checkout ${BRANCH_ELECTRON}
  git pull
fi
yarn install

if [ -z "${NOT_MAKE_APP}" ]; then
  npm run make
fi
