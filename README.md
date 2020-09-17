# BitSky Builder

## Available Build Scripts
Following are the avaible build scripts. 

### Build BitSky Official Website
<img src="./docs/imgs/bitskyai.png" width="600px" >

```bash
npm run build-landing
```
Build latest landing application to `bitskyai.github.io` folder

### Build BitSky Web Application
<img src="./docs/imgs/bitskyai-web-app.png" width="600px" >

```bash
npm run build-web-app
```
Build latest web application to `bitsky-web-app` folder, and by default start web app, you can view it - [http://localhost:9099](http://localhost:9099).

If you don't want to start application, then you can do this:
```bash
export NOT_START_SERVER=true && npm run build-web-app
```

If you don't want to intall `node_modules`, then you can do this:
```bash
export NOT_INSTALL_NODE_MODULES=true && npm run build-web-app
```

### Build BitSky Desktop Application
<img src="./docs/imgs/bitskyai-desktop-app.png" width="600px" >

```bash
npm run build-desktop-app
```
Build latest desktop application inside `bitsky-desktop-app/out`

### Develop UI
