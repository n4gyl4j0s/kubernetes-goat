rem Windows CMD
rem Author: Lajos Nagy
rem This program has been created as part of Kuberentes Goat
rem Kuberentes Goat setup and manage vulnerable infrastrcuture 

rem Checking kubectl setup
@echo off
kubectl version --short >NUL 2>&1
if %ERRORLEVEL% == 0 (
     echo "kubectl setup looks good."
) else (
     echo "Error: Could not find kubectl or an other error happend, please check kubectl setup."
     exit 
	)

rem deploying insecure-rbac scenario
echo "deploying insecure super admin scenario"
kubectl apply -f scenarios/insecure-rbac/setup.yaml

rem deploying helm chart to verify the setup
echo "deploying helm chart metadata-db scenario"
helm install metadata-db scenarios/metadata-db/

rem setup the scenarios/configurations
echo 'deploying the vulnerable scenarios manifests'
kubectl apply -f scenarios/batch-check/job.yaml
kubectl apply -f scenarios/build-code/deployment.yaml
kubectl apply -f scenarios/cache-store/deployment.yaml
kubectl apply -f scenarios/health-check/deployment.yaml
kubectl apply -f scenarios/hunger-check/deployment.yaml
kubectl apply -f scenarios/internal-proxy/deployment.yaml
kubectl apply -f scenarios/kubernetes-goat-home/deployment.yaml
kubectl apply -f scenarios/poor-registry/deployment.yaml
kubectl apply -f scenarios/system-monitor/deployment.yaml
kubectl apply -f scenarios/hidden-in-layers/deployment.yaml

echo 'Successfully deployed Kubernetes Goat. Have fun learning Kubernetes Security!'
echo 'Ensure pods are in running status before running access-kubernetes-goat.sh script'
echo 'Now run the bash access-kubernetes-goat.sh to access the Kubernetes Goat environment.'
