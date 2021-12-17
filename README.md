# CI/CD for VPS with Docker Compose and GitHub Actions

Run the scripts in `deployment-scripts` directory on your local machine to deploy the app to VPS **only for the first time**. 

Every time you want to update the app, you don't need to do anything manually, the "redeployment" is automated with GitHub Actions: on every `push` the project's production image is rebuilt, pushed to Docker Hub, pulled from Docker Hub to VPS and used to restart the app's container.

**IMPORTANT**. Before running scripts, create the file in `deployment-scripts` directory containing your Docker Hub password.
```shell
cd deployment-scripts
touch docker-hub-password.txt
echo your_docker)hub_password > docker-hub-password.txt
```
