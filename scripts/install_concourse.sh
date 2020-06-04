#!/usr/bin/env bash

#      _____           _        _ _                                           
#     |_   _|         | |      | | |                                         
#       | |  _ __  ___| |_ __ _| | | 
#       | | | '_ \/ __| __/ _` | | |
#      _| |_| | | \__ \ || (_| | | |
#     |_____|_| |_|___/\__\__,_|_|_|
#             _____                                          
#           / ____|                                         
#          | |     ___  _ __   ___ ___  _   _ _ __ ___  ___ 
#          | |    / _ \| '_ \ / __/ _ \| | | | '__/ __|/ _ \
#          | |___| (_) | | | | (_| (_) | |_| | |  \__ \  __/
#           \_____\___/|_| |_|\___\___/ \__,_|_|  |___/\___|

# Install Pivotal Concourse via Helm

echo '---------------------------------------------------------> INSTALLING CONCOURSE'

set -e -u -o 

set -x    

#echo "CURRENT: ${CURRENT}"
echo "NAMESPACE: ${NAMESPACE}"
echo "CLUSTER_NAME: ${CLUSTER_NAME}"
#echo "USERNAME: ${USERNAME}"
#echo "PASSWORD: ${PASSWORD}"
#echo "ROOT: ${ROOT}"

echo "KUBERNETES_FOLDER: ${KUBERNETES_FOLDER}"
echo "KUBE_CONFIG: ${KUBE_CONFIG}"

#KEYS_FOLDER="${CURRENT}/Keys"
#echo "KEYS_FOLDER: ${KEYS_FOLDER}"

#COMMON_KUBERNETES="${CURRENT}/${ROOT}/../common-kubernetes"
#echo "COMMON_KUBERNETES: ${COMMON_KUBERNETES}"

#echo "SHARED_FOLDER: ${SHARED_FOLDER}"
#echo "CURRENT_FOLDER: ${CURRENT_FOLDER}"

export KUBECONFIG=${KUBE_CONFIG}

kubectl get nodes

#chmod 400 ${KEYS_FOLDER}/*.pem

# Concourse...

kubectl apply --filename ${KUBERNETES_FOLDER}/postgresql-storage-class.yaml
kubectl apply --filename ${KUBERNETES_FOLDER}/postgresql-persistent-volume-0.yaml

kubectl apply --filename ${KUBERNETES_FOLDER}/worker-storage-class.yaml
kubectl apply --filename ${KUBERNETES_FOLDER}/worker-persistent-volume-0.yaml
kubectl apply --filename ${KUBERNETES_FOLDER}/worker-persistent-volume-1.yaml

helm repo add concourse https://concourse-charts.storage.googleapis.com/

#helm repo update

kubectl create namespace ${NAMESPACE}

helm install ${CLUSTER_NAME} \
   --values ${KUBERNETES_FOLDER}/concourse-values.yaml \
   --namespace ${NAMESPACE} \
   --version 10.2.1 \
   concourse/concourse
             
#             --secrets.localUsers=${USERNAME}:${PASSWORD} \             

#kubectl --namespace $NAMESPACE rollout status $NAME

# https://whynopadlock.com
# https://www.ssllabs.com/ssltest/

# https://rancher.com/docs/rancher/v2.x/en/installation/options/troubleshooting/

set +x

echo '----------------------------------------------------------> CONCOURSE INSTALLED'

exit 0