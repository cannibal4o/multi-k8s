docker build -t georglv/multi-client:latest -t georglv/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t georglv/multi-server:latest -t georglv/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t georglv/multi-worker:latest -t georglv/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push georglv/multi-client:latest
docker push georglv/multi-server:latest
docker push georglv/multi-worker:latest
docker push georglv/multi-client:$SHA
docker push georglv/multi-server:$SHA
docker push georglv/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=georglv/multi-server:$SHA
kubectl set image deployment/client-deployment client=georglv/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=georglv/multi-worker:$SHA
