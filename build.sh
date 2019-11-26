IMAGE_NAME=$1
REGISTRY=$registry
VERSION=$(cat version)

revisioncount=$(git log --oneline | wc -l | tr -d ' ')
projectversion=$(git describe --long --tags --always)
cleanversion=${projectversion%%-*}
branch="$(git rev-parse --abbrev-ref HEAD)"
hash=$(git rev-parse --short HEAD)
version=${cleanversion}-${branch:0:2}.${revisioncount}-${hash}

if [[ $BUILD_ENV == "PROD" ]]
then
  version=${cleanversion}-${revisioncount}
fi

version=${BUILD_PREFIX}${version}${BUILD_SUFFIX}


DOCKER_BUILDKIT=1 docker build --ssh default --build-arg version="${version}" -t utreg:5000/httpbin-testing:"${version}" --squash .  >> /var/go/test
docker push utreg:5000/httpbin-testing:"${version}" >> /var/go/test
echo "$version" > version >> /var/go/test


#IMAGE_NAME=$1
#REGISTRY=$registry
#VERSION=$(cat version)
#docker build -t $IMAGE_NAME:$VERSION .
#docker tag $IMAGE_NAME:$VERSION $REGISTRY/$IMAGE_NAME:$VERSION
#docker push $REGISTRY/$IMAGE_NAME:$VERSION
