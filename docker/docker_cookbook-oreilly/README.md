# #116 Docker Cookbook (O'Reilly)

Book notes - Docker Cookbook, 3rd Edition by Steve Oualline, published by O'Reilly

## Notes

## Table of Contents - Highlights

### 1 Getting Started with Docker

* 1.1 Installing Docker on Ubuntu 14.04
* 1.2 Installing Docker on CentOS 6.5
* 1.3 Installing Docker on CentOS 7
* 1.4 Setting Up a Local Docker Host by Using Vagrant
* 1.5 Installing Docker on a Raspberry Pi
* 1.6 Installing Docker on OS X Using Docker Toolbox
* 1.7 Using Boot2Docker to Get a Docker Host on OS X
* 1.8 Running Boot2Docker on Windows 8.1 Desktop
* 1.9 Starting a Docker Host in the Cloud by Using Docker Machine
* 1.10 Using Docker Experimental Binaries
* 1.11 Running Hello World in Docker
* 1.12 Running a Docker Container in Detached Mode
* 1.13 Creating, Starting, Stopping, and Removing Containers
* 1.14 Building a Docker Image with a Dockerfile
* 1.15 Using Supervisor to Run WordPress in a Single Container
* 1.16 Running a WordPress Blog Using Two Linked Containers
* 1.17 Backing Up a Database Running in a Container
* 1.18 Sharing Data in Your Docker Host with Containers
* 1.19 Sharing Data Between Containers
* 1.20 Copying Data to and from Containers

### 2 Image Creation and Sharing

* 2.1 Keeping Changes Made to a Container by Committing to an Image
* 2.2 Saving Images and Containers as Tar Files for Sharing
* 2.3 Writing Your First Dockerfile
* 2.4 Packaging a Flask Application Inside a Container
* 2.5 Optimizing Your Dockerfile by Following Best Practices
* 2.6 Versioning an Image with Tags
* 2.7 Migrating from Vagrant to Docker with the Docker Provider
* 2.8 Using Packer to Create a Docker Image
* 2.9 Publishing Your Image to Docker Hub
* 2.10 Using ONBUILD Images
* 2.11 Running a Private Registry
* 2.12 Setting Up an Automated Build on Docker Hub for Continuous Integration/Deployment
* 2.13 Setting Up a Local Automated Build by Using a Git Hook and a Private Registry
* 2.14 Using Conduit for Continuous Deployment

### 3 Docker Networking

* 3.1 Finding the IP Address of a Container
* 3.2 Exposing a Container Port on the Host
* 3.3 Linking Containers in Docker
* 3.4 Understanding Docker Container Networking
* 3.5 Choosing a Container Networking Namespace
* 3.6 Configuring the Docker Daemon IP Tables and IP Forwarding Settings
* 3.7 Using pipework to Understand Container Networking
* 3.8 Setting Up a Custom Bridge for Docker
* 3.9 Using OVS with Docker
* 3.10 Building a GRE Tunnel Between Docker Hosts
* 3.11 Running Containers on a Weave Network
* 3.12 Running a Weave Network on AWS
* 3.13 Deploying flannel Overlay Between Docker Hosts
* 3.14 Networking Containers on Multiple Hosts with Docker Network
* 3.15 Diving Deeper into the Docker Network Namespaces Configuration

### 4 Docker Configuration and Development

* 4.1 Managing and Configuring the Docker Daemon
* 4.2 Compiling Your Own Docker Binary from Source
* 4.3 Running the Docker Test Suite for Docker Development
* 4.4 Replacing Your Current Docker Binary with a New One
* 4.5 Using nsenter
* 4.6 Introducing runc
* 4.7 Accessing the Docker Daemon Remotely
* 4.8 Exploring the Docker Remote API to Automate Docker Tasks
* 4.9 Securing the Docker Daemon for Remote Access
* 4.10 Using docker-py to Access the Docker Daemon Remotely
* 4.11 Using docker-py Securely
* 4.12 Changing the Storage Driver

### 5 Kubernetes

* 5.1 Understanding Kubernetes Architecture
* 5.2 Networking Pods for Container Connectivity
* 5.3 Creating a Multinode Kubernetes Cluster with Vagrant
* 5.4 Starting Containers on a Kubernetes Cluster with Pods
* 5.5 Taking Advantage of Labels for Querying Kubernetes Objects
* 5.6 Using a Replication Controller to Manage the Number of Replicas of a Pod
* 5.7 Running Multiple Containers in a Pod
* 5.8 Using Cluster IP Services for Dynamic Linking of Containers
* 5.9 Creating a Single-Node Kubernetes Cluster Using Docker Compose
* 5.10 Compiling Kubernetes to Create Your Own Release
* 5.11 Starting Kubernetes Components with the hyperkube Binary
* 5.12 Exploring the Kubernetes API
* 5.13 Running the Kubernetes Dashboard
* 5.14 Upgrading from an Old API Version
* 5.15 Configuring Authentication to a Kubernetes Cluster
* 5.16 Configuring the Kubernetes Client to Access Remote Clusters

### 6 Optimized Operating System Distributions for Docker

* 6.1 Discovering the CoreOS Linux Distribution with Vagrant
* 6.2 Starting a Container on CoreOS via cloud-init
* 6.3 Starting a CoreOS Cluster via Vagrant to Run Containers on Multiple Hosts
* 6.4 Using fleet to Start Containers on a CoreOS Cluster
* 6.5 Deploying a flannel Overlay Between CoreOS Instances
* 6.6 Using Project Atomic to Run Docker Containers
* 6.7 Starting an Atomic Instance on AWS to Use Docker
* 6.8 Running Docker on Ubuntu Core Snappy in a Snap
* 6.9 Starting an Ubuntu Core Snappy Instance on AWS EC2
* 6.10 Running Docker Containers on RancherOS

### 7 The Docker Ecosystem: Tools

* 7.1 Using Docker Compose to Create a WordPress Site
* 7.2 Using Docker Compose to Test Apache Mesos and Marathon on Docker
* 7.3 Starting Containers on a Cluster with Docker Swarm
* 7.4 Using Docker Machine to Create a Swarm Cluster Across Cloud Providers
* 7.5 Managing Containers Locally Using the Kitematic UI
* 7.6 Managing Containers Through Docker UI
* 7.7 Using the Wharfee Interactive Shell
* 7.8 Orchestrating Containers with Ansible Docker Module
* 7.9 Using Rancher to Manage Containers on a Cluster of Docker Hosts
* 7.10 Running Containers on a Cluster Using Lattice
* 7.11 Running Containers via Apache Mesos and Marathon
* 7.12 Using the Mesos Docker Containerizer on a Mesos Cluster
* 7.13 Discovering Docker Services with Registrator

### 8 Docker in the Cloud

* 8.1 Accessing Public Clouds to Run Docker
* 8.2 Starting a Docker Host on AWS EC2
* 8.3 Starting a Docker Host on Google GCE
* 8.4 Starting a Docker Host on Microsoft Azure
* 8.5 Starting a Docker Host on AWS Using Docker Machine
* 8.6 Starting a Docker Host on Azure with Docker Machine
* 8.7 Running a Cloud Provider CLI in a Docker Container
* 8.8 Using Google Container Registry to Store Your Docker Images
* 8.9 Using Docker in GCE Google-Container Instances
* 8.10 Using Kubernetes in the Cloud via GCE
* 8.11 Setting Up to Use the EC2 Container Service
* 8.12 Creating an ECS Cluster
* 8.13 Starting Docker Containers on an ECS Cluster
* 8.14 Starting an Application in the Cloud Using Docker Support in AWS Beanstalk

### 9 Monitoring Containers

* 9.1 Getting Detailed Information About a Container with docker inspect
* 9.2 Obtaining Usage Statistics of a Running Container
* 9.3 Listening to Docker Events on Your Docker Hosts
* 9.4 Getting the Logs of a Container with docker logs
* 9.5 Using a Different Logging Driver than the Docker Daemon
* 9.6 Using Logspout to Collect Container Logs
* 9.7 Managing Logspout Routes to Store Container Logs
* 9.8 Using Elasticsearch and Kibana to Store and Visualize Container Logs
* 9.9 Using Collectd to Visualize Container Metrics
* 9.10 Using cAdvisor to Monitor Resource Usage in Containers
* 9.11 Monitoring Container Metrics with InfluxDB, Grafana, and cAdvisor
* 9.12 Gaining Visibility into Your Containers’ Layout with Weave Scope

### 10 Application Use Cases

* 10.1 CI/CD: Setting Up a Development Environment
* 10.2 CI/CD: Building a Continuous Delivery Pipeline with Jenkins and Apache Mesos
* 10.3 ELB: Creating a Dynamic Load-Balancer with Confd and Registrator
* 10.4 DATA: Building an S3-Compatible Object Store with Cassandra on Kubernetes
* 10.5 DATA: Building a MySQL Galera Cluster on a Docker Network
* 10.6 DATA: Dynamically Configuring a Load-Balancer for a MySQL Galera Cluster
* 10.7 DATA: Creating a Spark Cluster

## Getting the Example Source

```sh
git clone https://github.com/how2dock/docbook.git example_source
```

## Credits and References

* [O'Reilly listing](https://learning.oreilly.com/library/view/docker-cookbook/9781491919705/)
* [goodreads](https://www.goodreads.com/book/show/24216689-docker-cookbook)
* [example code source](https://github.com/how2dock/docbook)
