I’ll give you a **complete, step-by-step explanation** of the task, including:

* ✅ Project overview
* 🔧 Setup workflow with Jenkins + Docker
* ⚙️ All necessary Docker & Jenkins commands
* 🌐 Final output verification
* 📂 GitHub repo structure (for sharing)
* 🧠 Clear understanding for your friends or interviewers

---

## ✅ **DevOps Internship Task 2: Jenkins CI/CD Pipeline for Node.js App using Docker**

### 🔷 **Objective**

Automate the CI/CD pipeline using Jenkins to:

1. Build a Docker image from a Node.js app
2. Push the image to DockerHub
3. Run the container and access the app in the browser

---

## 📁 **Project Directory Structure**

```
TASK2/
├── APP/
│   ├── INDEX.js           # Node.js server file
│   └── package.json       # Node.js dependencies
├── Dockerfile             # Docker instructions
├── jenkins-pipeline.txt   # (Optional) Jenkins pipeline script
├── README.md              # Documentation
```

---

## 🔧 **Step-by-Step Workflow**

### 1️⃣ Create Node.js App

📄 **APP/INDEX.js**

```js
const http = require('http');

const server = http.createServer((req, res) => {
  res.end('Server running on port 3000');
});

server.listen(3000);
```

📄 **APP/package.json**

```json
{
  "name": "jenkins-node-app",
  "version": "1.0.0",
  "main": "INDEX.js",
  "scripts": {
    "start": "node INDEX.js"
  },
  "dependencies": {}
}
```

---

### 2️⃣ Create Dockerfile

📄 **Dockerfile**

```dockerfile
FROM node:18

WORKDIR /app

COPY APP/package.json .
COPY APP/INDEX.js .

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
```

---

### 3️⃣ Build Docker Image

```bash
docker build -t 19c51a0534/task2-app .
```

---

### 4️⃣ Run Locally to Test

```bash
docker run -p 3000:3000 19c51a0534/task2-app
```

✅ Visit: `http://localhost:3000` → Output: `Hello from Jenkins Pipeline!`

---

### 5️⃣ Push to DockerHub

Make sure you're logged in:

```bash
docker login
```

Now push:

```bash
docker push 19c51a0534/task2-app
```

✅ Image now available at: [https://hub.docker.com/r/19c51a0534/task2-app](https://hub.docker.com/r/19c51a0534/task2-app)

---

### 6️⃣ Jenkins CI/CD Pipeline

#### ✔️ Setup Jenkins in Docker

```bash
docker run -d -p 9090:8080 -p 50000:50000 --name jenkins-task2 jenkins/jenkins:lts
```

* Access Jenkins: `http://localhost:9090`
* Install recommended plugins
* Create an admin user
* Install **Docker Pipeline Plugin**

---

### 7️⃣ Jenkins Job Configuration

* Go to Jenkins Dashboard → **New Item**
* Choose **Pipeline** → name it `task2-app-deploy`
* In Pipeline config, use:

```groovy
pipeline {
    agent any
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/chandramah/TASK2.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t 19c51a0534/task2-app .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh 'docker push 19c51a0534/task2-app'
            }
        }

        stage('Deploy Container') {
            steps {
                sh 'docker stop task2-container || true'
                sh 'docker rm task2-container || true'
                sh 'docker run -d --name task2-container -p 3000:3000 19c51a0534/task2-app'
            }
        }
    }
}
```

> 🔐 Add your DockerHub credentials in Jenkins:
> Jenkins → **Manage Jenkins** → **Credentials** → Global → Add Credentials → `ID = dockerhub-creds`

---

### 8️⃣ Final Verification

```bash
docker ps
```

You'll see:

```
CONTAINER ID   IMAGE                  ...   PORTS
xxxxx          19c51a0534/task2-app   ...   0.0.0.0:3000->3000/tcp
```

Visit: [http://localhost:3000](http://localhost:3000)
✅ Output: `Server running on port 3000`

---

## 🧾 **All Docker Commands Summary**

| Step                   | Command                                        |
| ---------------------- | ---------------------------------------------- |
| Build Image            | `docker build -t 19c51a0534/task2-app .`       |
| Run Container          | `docker run -p 3000:3000 19c51a0534/task2-app` |
| Login DockerHub        | `docker login`                                 |
| Tag Image              | `docker tag <old-name> 19c51a0534/task2-app`   |
| Push Image             | `docker push 19c51a0534/task2-app`             |
| See Running Containers | `docker ps`                                    |

---

## 📂 GitHub Repo for Sharing

You can simply:

```bash
git clone https://github.com/chandramah/TASK2.git
cd TASK2
docker build -t <your_dockerhub_username>/task2-app .
docker run -p 3000:3000 <your_dockerhub_username>/task2-app
```

---
