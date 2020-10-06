const path = require("path");
const { execSync } = require("child_process");
// const { spawnSync } = require('child_process');
const fs = require("fs-extra");
const debug = require("debug");
const rootLog = debug("prepare-release");

const scriptsFolder = __dirname;
const version = process.argv[2];

rootLog("version: ", version);

function updateVersion(rootDir, version) {
  if (!version || !rootDir) {
    console.error("You must pass correct version");
    throw new Error("You must pass correct version");
  }
  const log = debug(path.basename(rootDir));
  log(`Current Dir: ${rootDir}`);
  log(`Version: ${version}`);
  const packageJSON = fs.readJsonSync(path.join(rootDir, "./package.json"));
  if (packageJSON.version == version) {
    log(`version inside package.json is already ${version}`);
    return;
  }
  packageJSON.version = version;
  fs.writeJSONSync(path.join(rootDir, "./package.json"), packageJSON, {
    spaces: 2,
  });
  log(`Successfully update package.json`);
  execSync("npm install", {
    cwd: rootDir,
  });
  log(`Successfully npm install`);
  execSync(`git add . && git commit -am "bump up version to ${version}"`, {
    cwd: rootDir,
  });
  log(`Successfully git commit`);
  execSync(`git push`, {
    cwd: rootDir,
  });
  log(`Successfully git push`);
}

const dirs = [
  path.join(scriptsFolder, "../bitsky-desktop-app"),
  path.join(scriptsFolder, "../bitsky-headless-producer"),
  path.join(scriptsFolder, "../bitsky-hello-retailer"),
  path.join(scriptsFolder, "../bitsky-http-producer"),
  path.join(scriptsFolder, "../bitsky-supplier"),
  path.join(scriptsFolder, "../bitsky-ui"),
];
rootLog("Start update version listed in dirs");
dirs.forEach((dir) => {
  updateVersion(dir, version);
});
const log = debug("bitsky-web-app");
log("Start build web app ...");
execSync(`export NOT_START_SERVER=true && npm run build-web-app`, {
  cwd: path.join(scriptsFolder, "../"),
  stdio: "ignore",
  // cwd: scriptsFolder,
});
execSync(`git add . && git commit -am "bump up version to ${version}"`, {
  cwd: path.join(scriptsFolder, "../bitsky-web-app"),
});
log(`Successfully git commit`);
execSync(`git push`, {
  cwd: path.join(scriptsFolder, "../bitsky-web-app"),
});
log(`Successfully git push`);

rootLog("Successfully prepare release");
