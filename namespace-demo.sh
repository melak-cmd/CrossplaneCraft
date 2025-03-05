#!/usr/bin/env bash
set -exo pipefail

kubectl delete --ignore-not-found namespaces.eaas.konflux-ci.dev/my-namespace

kubectl apply -f 006-claims.yaml

kubectl get namespaces.eaas.konflux-ci.dev
kubectl wait --for=condition=Ready --timeout=10s namespaces.eaas.konflux-ci.dev/my-namespace
kubectl get namespaces.eaas.konflux-ci.dev

kubectl get secrets
kubectl get secret/my-claim-secret --template='{{.data.kubeconfig | base64decode}}' > kubeconfig

export KUBECONFIG=kubeconfig
kubectl config get-contexts
kubectl get serviceaccounts
kubectl get secrets
kubectl get rolebindings
