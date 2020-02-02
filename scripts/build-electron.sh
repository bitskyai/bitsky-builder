#!/bin/sh

###########################
# Build dia-engine, dia-ui and dia-soi-boilerplate-node to dia-electron
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `dia-ui`. Default is `develop`
# 2. BRANCH_ENGINE: git branch for `dia-engine`. Default is `develop`
# 3. DIST: which folder to store build files. Default is `dist-engine-ui`
# 4. NOT_START_SERVER: After build successful don't start server
# 5. ENGINE_UI_FOLDER_NAME: folder name for `dia-engine` with `dia-ui`. Defualt is `engine-ui`
# 6. BRANCH_SOI: git branch for `dia-soi-boilerplate-node`. Default is `develop`
# 7. SOI_FOLDER_NAME: Folder name for `dia-soi-boilerplate-node`. Default is `soi`

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

if [[ -z "${BRANCH_SOI}" ]]; then
  BRANCH_SOI="develop"
fi

if [[ -z "${SOI_FOLDER_NAME}" ]]; then
  SOI_FOLDER_NAME="analystservice"
fi

TARGET_PATH=${DIST}${SOI_FOLDER_NAME}
echo ${TARGET_PATH}
rm -rf ${TARGET_PATH}
mkdir -p ${TARGET_PATH}
cd ./dia-soi-boilerplate-node
echo "Current Folder: " && pwd
git checkout ${BRANCH_SOI}
git pull
cp -rf src/ ../${TARGET_PATH}/src/
cp package.json ../${TARGET_PATH}/
echo "BUild dia-soi-boilerplate-node successfully"
