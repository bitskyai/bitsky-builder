const path = require('path');

const BRANCH_UI = process.env.BRANCH_UI||'develop';
const BRANCH_ENGINE = process.env.BRANCH_ENGINE||'develop';
const DIST = process.env.DIST||'build/';
const ENGINE_UI_FOLDER_NAME = process.env.ENGINE_UI_FOLDER_NAME||'engine-ui/';
const TARGET_PATH = path.join(DIST, ENGINE_UI_FOLDER_NAME);

console.log(`TARGET_PATH: ${TARGET_PATH}`);
