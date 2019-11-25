$IMAGE_NAME=$1
$VERSION=$(cat version)
docker build -t $IMAGE_NAME:$VERSION .
docker tag $IMAGE_NAME:$VERSION devops.uangteman.com:5357/$IMAGE_NAME:$VERSION
docker push registry.sdmoko.net:5000/$IMAGE_NAME:$VERSION
