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
pwd
if [[ -z "${BRANCH_UI}" ]]; then
  BRANCH_UI="develop"
fi

if [[ -z "${DIST}" ]]; then
  DIST="munew.github.io/"
fi

TARGET_PATH=${DIST}
echo ${TARGET_PATH}

find ./${TARGET_PATH} ! -name 'CNAME' ! -name '.git' ! -name '.gitignore' ! -name '.'  ! -name '..'   -print0 | xargs -0 rm -rf
