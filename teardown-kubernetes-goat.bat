rem Windows CMD
rem Author: Lajos Nagy
rem This program has been created as part of Kuberentes Goat
rem Teardown Kuberentes Goat setup

rem Removing the superadmin cluster role/binding
kubectl delete clusterrolebindings superadmin
kubectl delete serviceaccount -n kube-system superadmin

rem Removing the helm-tiller cluster role/binding
kubectl delete clusterrole all-your-base
kubectl delete clusterrolebindings belong-to-us

rem Removing metadata db chart
helm delete metadata-db --no-hooks
rem helm2 delete pwnchart --purge

rem Remove tiller deployment
kubectl delete deployments -n kube-system tiller-deploy


rem Delete the scenarios
kubectl delete -f scenarios/batch-check/job.yaml
kubectl delete -f scenarios/build-code/deployment.yaml
kubectl delete -f scenarios/cache-store/deployment.yaml
kubectl delete -f scenarios/health-check/deployment.yaml
kubectl delete -f scenarios/hunger-check/deployment.yaml
kubectl delete -f scenarios/internal-proxy/deployment.yaml
kubectl delete -f scenarios/kubernetes-goat-home/deployment.yaml
kubectl delete -f scenarios/poor-registry/deployment.yaml
kubectl delete -f scenarios/system-monitor/deployment.yaml
kubectl delete -f scenarios/hidden-in-layers/deployment.yaml


echo "The Kubernetes Goat scenarios has been removed. Ensure clean up what you installed and used, It's better to delete the cluster."