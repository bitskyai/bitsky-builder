#!/bin/sh
set -e
###########################
# Build BitSky website
###########################
# Available Envs:
# 1. BRANCH_UI: git branch for `bitsky-ui`. Default is `develop`
# 2. BRANCH_SUPPLIER: git branch for `bitsky-supplier`. Default is `develop`
# 3. DIST: which folder to store build files. Default is `dist-supplier-ui`
# 4. NOT_START_SERVER: After build successful don't start server
# 5. SUPPLIER_UI_FOLDER_NAME: folder name for `bitsky-supplier` with `bitsky-ui`. Defualt is `supplier-ui`
# 6. NOT_INSTALL_NODE_MODULES: Don't install node_modules in target folder
# 7. TARGET: ['electron', 'admin', 'ui']

ROOT_DIR=$(pwd)
echo "Root Folder: $ROOT_DIR"

if [ -z "${TARGET_PATH}" ]; then
  TARGET_PATH="bitskyai.github.io/"
fi

echo ${TARGET_PATH}

cd ./${TARGET_PATH}
find . ! -name 'CNAME' ! -name 'README.md' ! -name '.git' ! -name '.gitignore' ! -name 'sitemap.xml' ! -name 'robots.txt' ! -name '.'  ! -name '..' -print0 | xargs -0 rm -rf

###########################
echo "Start build BitSky Official Website..."
cd $ROOT_DIR
cd ./bitsky-ui
echo "Current Folder: " && pwd
if [ "${BRANCH_UI}" ]; then
  git checkout ${BRANCH_UI}
  git pull
fi
npm install
npm run build-landing
cp -rf dist/ ../${TARGET_PATH}
echo "Build BitSky Official Website successfully"