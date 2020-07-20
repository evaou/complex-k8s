docker build -t evaou/complex-client:latest -t evaou/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t evaou/complex-server:latest -t evaou/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t evaou/complex-worker:latest -t evaou/complex-worker:$SHA -f ./worker/Dockerfile ./worker
docker push evaou/complex-client:latest
docker push evaou/complex-server:latest
docker push evaou/complex-worker:latest
docker push evaou/complex-client:$SHA
docker push evaou/complex-server:$SHA
docker push evaou/complex-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=evaou/complex-server:$SHA
kubectl set image deployments/client-deployment client=evaou/complex-client:$SHA
kubectl set image deployments/worker-deployment worker=evaou/complex-worker:$SHA