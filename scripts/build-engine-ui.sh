#!/bin/sh

###########################
# Build dia engine with ui
###########################
# Available Envs: 
# 1. BRANCH_UI: git branch for `dia-ui`. Default is `develop`
# 2. BRANCH_ENGINE: git branch for `dia-engine`. Default is `develop`
# 3. DIST: which folder to store build files. Default is `dist-engine-ui`
# 4. NOT_START_SERVER: After build successful don't start server

if [[ -z "${BRANCH_UI}" ]]; then
  BRANCH_UI="develop"
fi

if [[ -z "${BRANCH_ENGINE}" ]]; then
  BRANCH_ENGINE="develop"
fi

if [[ -z "${DIST}" ]]; then
  DIST="dist-engine-ui"
fi

# Remove previous build
rm -rf ${DIST}
mkdir ${DIST}

###########################
echo "Start build dia-engine..."
cd dia-engine
echo "Current Folder: " && pwd
git checkout ${BRANCH_ENGINE}
git pull
npm install
npm run build
cp -rf build/ ../${DIST}
cp package.json ../${DIST}
echo "BUild dia-engine successfully"

###########################
echo "Start build dia-ui..."
cd ../dia-ui
echo "Current Folder: " && pwd
git checkout ${BRANCH_UI}
git pull
npm install
npm run build-admin
cp -rf dist/ ../${DIST}/public
echo "BUild dia-ui successfully"

###########################
echo "Install production node_modules..."
cd ../${DIST}
npm install --production

###########################
# Default start server
if [[ -z "${NOT_START_SERVER}" ]]; then
  echo "Start Server"
  node index.js
fi
