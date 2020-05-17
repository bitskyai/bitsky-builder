#!/bin/sh

###########################
# Build dia-engine, dia-ui and dia-soi-boilerplate-node to dia-electron
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `dia-ui`
# 2. BRANCH_ENGINE: git branch for `dia-engine`
# 3. BRANCH_ELECTRON: git branch for `dia-electron`
# 4. BRANCH_SOI: git branch for `dia-soi-boilerplate-node`. Default is `develop`
# 5. ENGINE_UI_FOLDER_NAME: folder name for `dia-engine` with `dia-ui`. Defualt is `engine-ui`
# 6. DIST: which folder to store build files. Default is `dist-engine-ui`
# 7. SOI_FOLDER_NAME: Folder name for `dia-soi-boilerplate-node`. Default is `analystservice`
# 8. NOT_START_SERVER: After build successful don't start server

###########################
ROOT_DIT=$(pwd)
echo $ROOT_DIT
# Build engine-ui first
if [[ -z "${DIST}" ]]; then
  export DIST="dia-electron/app/"
fi

if [[ -z "${NOT_START_SERVER}" ]]; then
  export NOT_START_SERVER=true
fi

if [[ -z "${NOT_INSTALL_NODE_MODULES}" ]]; then
  export NOT_INSTALL_NODE_MODULES=true
fi

export TARGET="electron"
./scripts/build-engine-ui.sh

###########################
echo "Start build dia-soi-boilerplate-node..."
cd $ROOT_DIT

if [[ -z "${SOI_FOLDER_NAME}" ]]; then
  SOI_FOLDER_NAME="analystservice"
fi

TARGET_PATH=${DIST}${SOI_FOLDER_NAME}
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./dia-soi-boilerplate-node
echo "Current Folder: " && pwd
if [[ "${BRANCH_SOI}" ]]; then
  git checkout ${BRANCH_SOI}
  git pull
fi
cp -rf src/ ../${TARGET_PATH}/src/
cp package.json ../${TARGET_PATH}/
echo "Build dia-soi-boilerplate-node successfully"

###########################
echo "Start build electron app"
cd $ROOT_DIT

cd ./dia-soi-boilerplate-node
echo "Current Folder: " && pwd
if [[ "${BRANCH_ELECTRON}" ]]; then
  git checkout ${BRANCH_ELECTRON}
  git pull
fi
yarn install
npm run package
