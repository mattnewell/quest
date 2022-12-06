#!/bin/sh
aws ecr get-login-password --region us-east-1 |
  docker login --username AWS --password-stdin 566613373177.dkr.ecr.us-east-1.amazonaws.com

docker tag quest:latest 566613373177.dkr.ecr.us-east-1.amazonaws.com/quest-eks:latest
docker push 566613373177.dkr.ecr.us-east-1.amazonaws.com/quest-eks:latest
