# Dockerizing-a-Plain-HTML-Page-with-Nginx
The goal of this project is to get acquainted with Docker and containerization. You'll achieve this by using Docker to containerize a basic HTML page, employing Nginx as the web server.

## Table of Contents
- [Launching EC2 Instance and prerequisites](#launching-ec2-instance-and-prerequisites)
- [Basic HTML Page](#basic-html-page)
- [Nginx Configuration](#nginx-configuration)
- [Dockerfile](#dockerfile)
- [Building the Docker Image](#building-the-docker-image)
- [Push the image on ECR (Amazon Elastic Container Registry)](#push-the-image-on-ecr-amazon-elastic-container-registry)

## Launching EC2 Instance and prerequisites
1. To start, create an EC2 Instance. For this project, a t3.medium Instance was launched.
   
2. Once the Instance is created, connect to it and install Nginx:
```bash
    - `sudo apt-get update -y`
    - `sudo apt-get install nginx`
    - `sudo systemctl status nginx`
```
4. Installation of Docker in EC2
    - Follow the steps shown in this [website](https://cloudcone.com/docs/article/how-to-install-docker-on-ubuntu-22-04-20-04/) to install Docker.

5. Clone the GitHub repo
   ```bash
    - `git clone https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx.git`
   ```

## Basic HTML Page
1. Inside the repository, create a basic HTML file named `index.html`. You can find the index.html file [here](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/blob/main/index.html).
2. Navigate to the repository using:
   ```bash
    - `cd Dockerizing-a-Plain-HTML-Page-with-Nginx`
   ```
## Nginx Configuration
- Copy the `index.html` file to `/var/www/html`
- `sudo cp index.html /var/www/html`
- `sudo systemctl restart nginx`
- Configure reverse proxy to access the website via `docker.lokeshsayana.co.in`. Details for setting up the reverse proxy can be found here. You can see the reverse proxy file [here](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/blob/main/reverseproxy).
- Copy the reverse proxy file to `/etc/nginx/sites-available` and execute the following commands:
    - `sudo cp reverseproxy /etc/nginx/sites-available`
    - `sudo unlink /etc/nginx/sites-enabled/default`
    - `sudo ln -s /etc/nginx/sites-available/reverseproxy /etc/nginx/sites-enabled/`
    - `sudo systemctl restart nginx`

## Dockerfile
1. We need to create a Dockerfile which contains instructions for building a Docker image. You can find the Dockerfile and the explanation [here](link_to_dockerfile).

## Building the Docker Image
1. Build the Docker Image:
    - Login to Docker from the EC2 instance using:
    - `sudo docker login`
    - `sudo docker build . -t sayanalokesh/containerization`
    - `sudo docker run -it -d -p 3000:80 sayanalokesh/containerization`
    - Now pushing the same image to my Docker hub. You can find the image [here](https://hub.docker.com/repository/docker/sayanalokesh/containerization/general).

## Push the image on ECR (Amazon Elastic Container Registry)
1. In order to push the image to AWS ECR, we must have AWS CLI installed in our instance. Follow the commands to install the same in the instance.
    - `sudo apt install awscli -y`
2. Configure access keys obtained from IAM by following the instructions provided. Go to IAM and click on My security credentials under quick links.
    - Scroll down and you will find Access Keys. Click on that. Download the CSV file and keep it safe.
3. Once you have got the access key, you can now configure the same in the instance using the below commands.
    - `aws configure`
4. Now navigate to ECR and create a new public repository.
5. Once you create a repository, you will be able to see the View push commands tab once you select the repository. Click on that and use the commands to push the image to ECR.
    - You can access the Amazon ECR image [here](https://gallery.ecr.aws/c3w1m1q2/lokesh_containerization).
