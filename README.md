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
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/76aea602-9544-4437-95ac-0cc412389db1)
   
3. Once the Instance is created, connect to it and install Nginx:
```bash
    - sudo apt-get update -y
    - sudo apt-get install nginx
    - sudo systemctl status nginx
```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/de581590-7f4b-4f8e-a94a-b762c5152dbf)
4. Installation of Docker in EC2
    - Follow the steps shown in this [website](https://cloudcone.com/docs/article/how-to-install-docker-on-ubuntu-22-04-20-04/) to install Docker.
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/78f72d63-b2ea-4bce-bbdb-b5bb5ea9a0db)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/c3c8c36b-ecdf-42dc-8bdd-b87a77c949af)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/1ebe5235-db16-4aba-9746-5dafad9aee07)

5. Clone the GitHub repo
   ```bash
    - git clone https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx.git
   ```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/87002af7-b66f-4784-b4aa-393baa1d69e1)

## Basic HTML Page
1. Inside the repository, create a basic HTML file named `index.html`. You can find the index.html file [here](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/blob/main/index.html).
2. Navigate to the repository using:
   ```bash
    - cd Dockerizing-a-Plain-HTML-Page-with-Nginx
   ```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/e07a6b3f-74c3-47bd-b239-f0e6e9b9ce42)

## Nginx Configuration
- Copy the `index.html` file to `/var/www/html`
```bash
- sudo cp index.html /var/www/html
- sudo systemctl restart nginx
  ```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/10a36928-359e-4ed2-8421-ac72cd78cdca)

- Configure reverse proxy to access the website via `docker.lokeshsayana.co.in`. Details for setting up the reverse proxy can be found here. You can see the reverse proxy file [here](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/blob/main/reverseproxy).
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/2fc0ddfb-925e-40d7-835f-fa149b5d44b3)
- Copy the reverse proxy file to `/etc/nginx/sites-available` and execute the following commands:
```bash
    - sudo cp reverseproxy /etc/nginx/sites-available
    - sudo unlink /etc/nginx/sites-enabled/default
    - sudo ln -s /etc/nginx/sites-available/reverseproxy /etc/nginx/sites-enabled/
    - sudo systemctl restart nginx
  ```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/c593ac74-f96d-4883-b8eb-6096e01dea0f)

## Dockerfile
1. We need to create a Dockerfile which contains instructions for building a Docker image. You can find the Dockerfile and the explanation [here](link_to_dockerfile).

## Building the Docker Image
1. Build the Docker Image:
    - Login to Docker from the EC2 instance using:
   ```bash
    - sudo docker login
   ```
   ![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/5e850498-772f-46f6-8331-f46bcbdf22b0)
   ```bash
    - sudo docker build . -t sayanalokesh/containerization
   ```
   ![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/cedf81e6-822a-48c2-8061-36ca96a5f0b3)
   ```bash
    - sudo docker run -it -d -p 3000:80 sayanalokesh/containerization
   ```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/845ba934-27ac-45bc-a1cf-55949834110e)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/c94511dd-903d-4f35-bafc-b2b8d0920e07)

   - Now pushing the same image to my Docker hub. You can find the image [here](https://hub.docker.com/repository/docker/sayanalokesh/containerization/general).
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/199f9c55-22e0-4fed-ba8b-2df4741c1441)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/fd3067c2-1263-4e3d-ab1a-62d899fae9b1)

## Push the image on ECR (Amazon Elastic Container Registry)
1. To push the image to AWS ECR, we must have AWS CLI installed in our instance. You can just follow the commands to install the same in the instance.
```bash
    - sudo apt install awscli -y
```
3. Configure access keys obtained from IAM by following the instructions provided. Go to IAM and click on [My security credentials](https://us-east-1.console.aws.amazon.com/iam/home?region=us-east-1#/security_credentials) under quick links.
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/7172602b-4945-4713-b833-59e093c19238)
    - Scroll down and you will find Access Keys. Click on that. Download the CSV file and keep it safe.
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/aec3d21f-8d5c-41dd-8881-61831266e889)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/a8c9eb5c-dabc-4f9b-9753-b27ae4adbf1b)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/aff0a74b-c31f-4f71-89a9-d502f3749690)

5. Once you have got the access key, you can now configure the same in the instance using the below commands.
```bash
    - aws configure
```
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/fefc660d-1c3f-49ac-902d-7fe4b1a32c90)

6. Now navigate to ECR and create a new public repository.
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/4756731d-0b2a-4484-868e-3a0b8d7af1d6)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/0c3b84b8-5099-4ae8-bfb5-a6bf199ce156)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/07808fda-4220-43e1-8fd9-803640527378)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/b6643a21-420b-4eaf-86b4-f568a692af30)

7. Once you create a repository, you can see the View push commands tab once you select the repository. Click on that and use the commands to push the image to ECR.
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/a2383aa0-9fba-465a-bc57-b87de7ba9dfd)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/e6992d3f-c7d9-4c76-abde-dc881e5940cf)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/9e91d0f8-e688-41ef-b587-1641b85c74e8)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/97398d42-c9b7-4654-aa66-6970275611c2)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/4b0631e1-d5ee-42d7-84da-ac9ec397d800)
![image](https://github.com/sayanalokesh/Dockerizing-a-Plain-HTML-Page-with-Nginx/assets/105637305/89b8134f-ee44-446e-93a6-1fc79768c066)

    - You can access the Amazon ECR image [here](https://gallery.ecr.aws/c3w1m1q2/lokesh_containerization).
