#!/bin/sh

###########################
# Build dia engine with ui
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `dia-ui`. Default is `develop`
# 2. BRANCH_ENGINE: git branch for `dia-engine`. Default is `develop`
# 3. DIST: which folder to store build files. Default is `dist-engine-ui`
# 4. NOT_START_SERVER: After build successful don't start server
# 5. ENGINE_UI_FOLDER_NAME: folder name for `dia-engine` with `dia-ui`. Defualt is `engine-ui`
# 6. NOT_INSTALL_NODE_MODULES: Don't install node_modules in target folder

if [[ -z "${BRANCH_UI}" ]]; then
  BRANCH_UI="develop"
fi

if [[ -z "${BRANCH_ENGINE}" ]]; then
  BRANCH_ENGINE="develop"
fi

if [[ -z "${DIST}" ]]; then
  DIST="build/"
fi

if [[ -z "${ENGINE_UI_FOLDER_NAME}" ]]; then
  ENGINE_UI_FOLDER_NAME="engine-ui"
fi

TARGET_PATH=${DIST}${ENGINE_UI_FOLDER_NAME}

echo ${TARGET_PATH}

# Remove previous build
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}

###########################
echo "Start build dia-engine..."
cd dia-engine
echo "Current Folder: " && pwd
git checkout ${BRANCH_ENGINE}
git pull
npm install
npm run build
cp -rf build/ ../${TARGET_PATH}/src
cp package.json ../${TARGET_PATH}
echo "BUild dia-engine successfully"

###########################
echo "Start build dia-ui..."
cd ../dia-ui
echo "Current Folder: " && pwd
git checkout ${BRANCH_UI}
git pull
npm install
npm run build-admin
cp -rf dist/ ../${TARGET_PATH}/src/public/
echo "BUild dia-ui successfully"

###########################
if [[ -z "${NOT_INSTALL_NODE_MODULES}" ]]; then
  echo "Install production node_modules..."
  cd ../${TARGET_PATH}
  npm install --production
fi

###########################
# Default start server
if [[ -z "${NOT_START_SERVER}" ]]; then
  echo "Start Server"
  node ./src/index.js
fi
