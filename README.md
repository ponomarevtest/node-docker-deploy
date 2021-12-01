Example of how to setup GitHub Actions in project utilizing Docker + Jest.
Build using [this tutorial](https://blog.devgenius.io/how-to-build-and-run-a-nodejs-app-with-docker-github-actions-59eb264dfef5)

1. Set up your Dockerfiles as you need
2. Navigate to the directory where is the Docker you're going to use (to build image) is located. 
3. And now we need to build the application image using either Docker or Docker Compose:
   * **how to do this using Docker Compose**. 
     ```shell
     # if you run 'build' without specifying service (=container) name, it will build images for allcontainers and that is not what we want. So pass the specific container name:
     docker-compose build container_name
     ```
   * **how to do this using Docker** (I haven't tested it and got errors, don't have time to figure out why)
     ```shell
     docker build . -t your_dockerhub_username/your_arbitrary_image_name
     ```

# Dockerized TypeScript Node.js server

The project demonstrates how to set up and debug TypeScript app inside Docker container with VS Code. 

We use:
* Docker (Docker Compose)
* Node.js (Express.js) app
* TypeScript Compiler
* VS Code
* `ts-node` and `nodemon` packages 

## Test container

```shell
curl http://localhost:8080/hello/john
```

## TypeScript Compiler configuration

You can fine-tune configuration through options in `tsconfig.json` and `start` script in `package.json`.

**`package.json`:**
```json
...
    "start": "nodemon --watch ./src/**/* -e ts,json --exec TS_NODE_PROJECT=tsconfig.json node --inspect=0.0.0.0:9229 -r ts-node/register ./src/index.ts"
...
```

* `--watch ./src/**/*` tells `nodemon` to watch for only `src` folder

* `--e ts,json` tells `nodemon` to watch only for the files with these extensions

* `--exec TS_NODE_PROJECT=tsconfig.json node --inspect=0.0.0.0:9229 -r ts-node/register ./src/index.ts` tells `nodemon` to start `node` and pass it `TS_NODE_PROJECT` environment variable which specifies the location and name of TypeScript Compiler config file (this variable is used by TypeScript Compiler). `-r` flag is a short command-line variant of `require()`, it preloads  the specified module at startup, in our case we preload `ts-node/register`. Finally we pass to `node` process the name of the main app's file - `index.ts`.

* If you need to debug the script from the very first line, change `... node --inspect=0.0.0.0:9229 ...` to `... node --inspect-brk=0.0.0.0:9229 ...`

Note the `volume` option in `dcoker-compose.yml`: we mount `tsconfig.json` (to tell TSC *how* to compile `.ts` files inside container) and `src` folder (containing all source `.ts`-files )


## VS Code Debugger configuration

`.vscode/launch.json` (pay attention to `sourceMapPathOverrides` option and make sure you provided the correct value, otherwise the debugger won't stop on breakpoints)
