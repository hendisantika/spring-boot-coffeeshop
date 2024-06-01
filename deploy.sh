#!/bin/bash
#aws ecr get-login-password | docker login --username AWS --password-stdin "${AWS_ECR_REGISTRY}"
ssh -p "${SERVER_PORT}" "${SERVER_USERNAME}"@"${SERVER_HOST}" -i key.txt -t -t -o StrictHostKeyChecking=no << 'ENDSSH'
cd /home/deployer/coffee-shop
cat .env
set +a
source .env
start=$(date +"%s")
aws ecr get-login-password --region "${AWS_REGION}" | docker login --username AWS --password-stdin "${AWS_ECR_REGISTRY}"
docker pull ${AWS_ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

if [ "$(docker ps -qa -f name=$CONTAINER_NAME)" ]; then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container is running -> stopping it..."
        docker stop $CONTAINER_NAME;
    fi
fi

docker run -d --rm -p 9100:9100 --name ${CONTAINER_NAME}  ${AWS_ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}

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
