#!/bin/bash

# Install Vagrant and VirtualBox
sudo apt-get update
sudo apt-get install -y vagrant virtualbox

# Create a Vagrantfile that specifies the Linux distribution and IP address for the virtual machine
vagrant init ubuntu/bionic64 192.168.42.110

# Start the virtual machine
vagrant up

# Install the Kubernetes command-line tool
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Create a Kubernetes cluster on the virtual machine
kubectl create cluster-info

# Create the three web apps
kubectl create deployment app1 --image=<image-name-1>
kubectl create deployment app2 --image=<image-name-2>
kubectl create deployment app3 --image=<image-name-3>

# Create an Ingress resource with rules for routing requests to the web apps
cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: web-ingress
spec:
  rules:
  - host: app1.com
    http:
      paths:
      - path: /
        backend:
          serviceName: app1
          servicePort: 80
  - host: app2.com
    http:
      paths:
      - path: /
        backend:
          serviceName: app2
          servicePort: 80
  - http:
      paths:
      - path: /
        backend:
          serviceName: app3
          servicePort: 80
EOF

# Create replicas of the app2 web app
kubectl scale deployment app2 --replicas=3

