#!/bin/bash
#aws ecr get-login-password | docker login --username AWS --password-stdin "${AWS_ECR_REGISTRY}"
ssh -p "${SERVER_PORT}" "${SERVER_USERNAME}"@"${SERVER_HOST}" -i key.txt -t -t -o StrictHostKeyChecking=no << 'ENDSSH'
cd /home/deployer/coffee-shop
touch .env
echo AWS_REGION=$AWS_REGION >> .env
echo HENDI=HENDI >> .env
echo AWS_ECR_REGISTRY=$AWS_ECR_REGISTRY >> .env
echo IMAGE_TAG=$IMAGE_TAG
cat .env
start=$(date +"%s")
aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${AWS_ECR_REGISTRY}"
docker pull 267023985114.dkr.ecr.ap-southeast-1.amazonaws.com/coffee-shop:${IMAGE_TAG}

CONTAINER_NAME=${ECR_REPOSITORY}
if [ "$(docker ps -qa -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container is running -> stopping it..."
        docker stop $CONTAINER_NAME;
    fi
fi

docker run -d --rm -p 9102:9102 --name ${CONTAINER_NAME}  ${AWS_ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

exit
ENDSSH

if [ $? -eq 0 ]; then
  exit 0
else
  exit 1
fi

end=$(date +"%s")

diff=$(($end - $start))

echo "Deployed in : ${diff}s"
