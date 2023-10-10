#!/bin/bash

if [ "$(docker ps --format '{{ .Names }}' | grep 'train-schedule' | wc -l)" != "0" ]
then
  docker stop train-schedule
  docker rm train-schedule
fi

docker run --name=train-schedule   -p 9080:8080   -d odusseos2017/train-schedule

exit 0
