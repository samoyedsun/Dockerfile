IMAGE_VERSION=stable
docker build -f $IMAGE_VERSION.Dockerfile --tag samoyedsun/ssproxy:$IMAGE_VERSION ./
docker push samoyedsun/ssproxy:$IMAGE_VERSION
docker rmi samoyedsun/ssproxy:$IMAGE_VERSION
