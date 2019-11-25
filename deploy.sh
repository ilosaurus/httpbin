IMAGE_NAME=$1
REGISTRY=$2
oc login -u $oc_username -p $oc_password $oc_url --certificate-authority=$ca --kubeconfig=$kubeconfig
oc import-image $IMAGE_NAME:$(cat version) --from=$REGISTRY/$IMAGE_NAME:$(cat version) --confirm --certificate-authority=$ca --kubeconfig=$kubeconfig
oc set triggers dc $IMAGE_NAME  --from-image=$IMAGE_NAME:$(cat version) --containers=$IMAGE_NAME --certificate-authority=$ca --kubeconfig=$kubeconfig
