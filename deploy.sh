docker build -t debiasej/multi-client-learning:latest -t debiasej/multi-client-learning:$SHA -f ./client/Dockerfile ./client
docker build -t debiasej/multi-server-learning:latest -t debiasej/multi-server-learning:$SHA -f ./server/Dockerfile ./server
docker build -t debiasej/multi-worker-learning:latest -t debiasej/multi-worker-learning:$SHA -f ./worker/Dockerfile ./worker

docker push debiasej/multi-client-learning:latest
docker push debiasej/multi-server-learning:latest
docker push debiasej/multi-worker-learning:latest

docker push debiasej/multi-client-learning:$SHA
docker push debiasej/multi-server-learning:$SHA
docker push debiasej/multi-worker-learning:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=debiasej/multi-server-learning:$SHA
kubectl set image deployments/client-deployment client=debiasej/multi-client-learning:$SHA
kubectl set image deployments/worker-deployment worker=debiasej/multi-worker-learning:$SHA

