docker build -t marcosantarcangelo/multi-client:latest -t marcosantarcangelo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marcosantarcangelo/multi-server:latest -t marcosantarcangelo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marcosantarcangelo/multi-worker:latest -t marcosantarcangelo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marcosantarcangelo/multi-client:latest
docker push marcosantarcangelo/multi-server:latest
docker push marcosantarcangelo/multi-worker:latest

docker push marcosantarcangelo/multi-client:$SHA
docker push marcosantarcangelo/multi-server:$SHA
docker push marcosantarcangelo/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=marcosantarcangelo/multi-client:$SHA
kubectl set image deployments/server-deployment server=marcosantarcangelo/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=marcosantarcangelo/multi-worker:$SHA
