docker build -t opeomotayo/multi-client:latest -t opeomotayo/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t opeomotayo/multi-server:latest -t opeomotayo/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t opeomotayo/multi-worker:latest -t opeomotayo/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push opeomotayo/multi-client:latest
docker push opeomotayo/multi-server:latest
docker push opeomotayo/multi-worker:latest
docker push opeomotayo/multi-client:$SHA
docker push opeomotayo/multi-server:$SHA
docker push opeomotayo/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=opeomotayo/multi-server:$SHA
kubectl set image deployments/client-deployment client=opeomotayo/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=opeomotayo/multi-worker:$SHA