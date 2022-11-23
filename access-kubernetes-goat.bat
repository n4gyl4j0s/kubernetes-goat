rem Windows CMD
rem Author: Lajos Nagy
rem This program has been created as part of Kuberentes Goat
rem Kuberentes Goat Access vulnerable infrastrcuture

rem Checking kubectl setup
@rem echo off
kubectl version --short >NUL 2>&1
if %ERRORLEVEL% == 0 (
     echo "kubectl setup looks good."
) else (
     echo "Error: Could not find kubectl or an other error happend, please check kubectl setup."
     exit 
	)


echo 'Creating port forward for all the Kubernetes Goat resources to locally. We will be using 1230 to 1236 ports locally!'

rem Exposing Sensitive keys in code bases Scenario
kubectl get pods --namespace default -l "app=build-code" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=build-code" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1230:3000 > NUL 2>&1

rem Exposing DIND (docker-in-docker) exploitation Scenario
kubectl get pods --namespace default -l "app=health-check" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=health-check" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1231:80 > NUL 2>&1

rem Exposing SSRF in K8S world Scenario
kubectl get pods --namespace default -l "app=internal-proxy" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=internal-proxy" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1232:3000 > NUL 2>&1

rem Exposing Container escape to access host system Scenario
kubectl get pods --namespace default -l "app=system-monitor" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=system-monitor" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1233:8080 > NUL 2>&1

rem Exposing Kubernetes Goat Home
kubectl get pods --namespace default -l "app=kubernetes-goat-home" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=kubernetes-goat-home" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1234:80 > NUL 2>&1

rem Exposing Attacking private registry Scenario
kubectl get pods --namespace default -l "app=poor-registry" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace default -l "app=poor-registry" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl port-forward %POD_NAME% --address 0.0.0.0 1235:5000 > NUL 2>&1

rem Exposing DoS resources Scenario
kubectl get pods --namespace big-monolith -l "app=hunger-check" -o jsonpath="{.items[0].metadata.name}" > tmp.txt
set /p POD_NAME= < tmp.txt
rem export POD_NAME=$(kubectl get pods --namespace big-monolith -l "app=hunger-check" -o jsonpath="{.items[0].metadata.name}")
start /B "" kubectl --namespace big-monolith port-forward %POD_NAME% --address 0.0.0.0 1236:8080 > NUL 2>&1


echo "Visit http://127.0.0.1:1234 to get started with your Kuberenetes Goat hacking!"