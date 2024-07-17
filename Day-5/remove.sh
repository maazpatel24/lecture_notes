kubectl delete deployment webapp
kubectl delete service webapp
docker service rm nginx-service
docker-compose -f docker-compose-single-volume.yml down