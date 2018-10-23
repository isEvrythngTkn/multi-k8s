docker build -t paulgoertzen/multi-client:latest -t paulgoertzen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paulgoertzen/multi-server:latest -t paulgoertzen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulgoertzen/multi-worker:latest -t paulgoertzen/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push paulgoertzen/multi-client:latest
docker push paulgoertzen/multi-server:latest
docker push paulgoertzen/multi-worker:latest
docker push paulgoertzen/multi-client:$SHA
docker push paulgoertzen/multi-server:$SHA
docker push paulgoertzen/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=paulgoertzen/multi-server:$SHA
kubectl set image deployments/client-deployment server=paulgoertzen/multi-client:$SHA
kubectl set image deployments/worker-deployment server=paulgoertzen/multi-worker:$SHA
