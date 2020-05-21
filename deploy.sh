docker build -t cassaram09/multi-client:latest -t cassaram09/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t cassaram09/multi-server:latest -t cassaram09/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t cassaram09/multi-worker:latest -t cassaram09/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cassaram09/multi-client:latest
docker push cassaram09/multi-server:latest
docker push cassaram09/multi-worker:latest

docker push cassaram09/multi-client:$SHA
docker push cassaram09/multi-server:$SHA
docker push cassaram09/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=cassaram09/multi-client:$SHA
kubectl set image deployments/server-deployment server=cassaram09/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=cassaram09/multi-worker:$SHA