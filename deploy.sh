docker build -t jxman/multi-client:latest -t jxman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jxman/multi-server:latest -t jxman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jxman/multi-worker:latest -t jxman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jxman/multi-client:latest
docker push jxman/multi-server:latest
docker push jxman/multi-worker:latest

docker push jxman/multi-client:$SHA
docker push jxman/multi-server:$SHA
docker push jxman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jxman/multi-server:$SHA
kubectl set image deployments/client-deployment client=jxman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jxman/multi-worker:$SHA