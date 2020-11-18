docker build -t bohdanleshchyshyn/multi-client:latest -t bohdanleshchyshyn/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bohdanleshchyshyn/multi-server:latest -t bohdanleshchyshyn/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bohdanleshchyshyn/multi-worker:latest -t bohdanleshchyshyn/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bohdanleshchyshyn/multi-client:latest
docker push bohdanleshchyshyn/multi-server:latest
docker push bohdanleshchyshyn/multi-worker:latest

docker push bohdanleshchyshyn/multi-client:$SHA
docker push bohdanleshchyshyn/multi-server:$SHA
docker push bohdanleshchyshyn/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bohdanleshchyshyn/multi-client:$SHA
kubectl set image deployments/server-deployment server=bohdanleshchyshyn/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bohdanleshchyshyn/multi-worker:$SHA