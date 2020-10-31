  
docker build -t seejiahao/multi-client:latest -t seejiahao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t seejiahao/multi-server:latest -t seejiahao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t seejiahao/multi-worker:latest -t seejiahao/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push seejiahao/multi-client:latest
docker push seejiahao/multi-server:latest
docker push seejiahao/multi-worker:latest

docker push seejiahao/multi-client:$SHA
docker push seejiahao/multi-server:$SHA
docker push seejiahao/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=seejiahao/multi-server:$SHA
kubectl set image deployments/client-deployment client=seejiahao/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=seejiahao/multi-worker:$SHA