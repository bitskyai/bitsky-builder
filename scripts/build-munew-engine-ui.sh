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
# 7. TARGET: ['electron', 'admin', 'ui']

if [ -z "${DIST}" ]; then
  DIST="munew-engine-ui/"
fi

TARGET_PATH=${DIST}

echo ${TARGET_PATH}

# Remove previous build
rm -rf ${DIST}/src
rm -rf ${DIST}/build
rm -rf ${DIST}/package.json
rm -rf ${DIST}/app.json
rm -rf ${DIST}/openapi.yml
# rm -rf ${DIST}/Procfile
rm -rf ${DIST}/package-lock.json
rm -rf ${DIST}/yarn.lock
rm -rf ${DIST}/node_modules
rm -rf ${DIST}/.dockerignore
rm -rf ${DIST}/Dockerfile

###########################
echo "Start build dia-engine..."
cd dia-engine
echo "Current Folder: " && pwd
if [ "${BRANCH_ENGINE}" ]; then
  git checkout ${BRANCH_ENGINE}
  git pull
fi
yarn install
npm run tsc
cp -rf build/ ../${TARGET_PATH}/build
cp package.json ../${TARGET_PATH}
cp app.json ../${TARGET_PATH}
cp openapi.yml ../${TARGET_PATH}
# cp Procfile ../${TARGET_PATH}
cp package-lock.json ../${TARGET_PATH}
cp .dockerignore ../${TARGET_PATH}
cp Dockerfile ../${TARGET_PATH}
echo "Build dia-engine successfully"

###########################
echo "Start build dia-ui..."
cd ../dia-ui
echo "Current Folder: " && pwd
if [ "${BRANCH_UI}" ]; then
  git checkout ${BRANCH_UI}
  git pull
fi
yarn install
npm run build-"${TARGET}"
cp -rf dist/ ../${TARGET_PATH}/build/public/
echo "BUild dia-ui successfully"