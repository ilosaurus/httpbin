$IMAGE_NAME=$1
$VERSION=$(cat version)
docker build -t $IMAGE_NAME:$VERSION .
docker tag $IMAGE_NAME:$VERSION registry.sdmoko.net:5000/$IMAGE_NAME:$VERSION
docker push registry.sdmoko.net:5000/$IMAGE_NAME:$VERSION
