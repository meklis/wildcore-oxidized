#!/bin/bash
envsubst '$OXIDIZED_THREADS $OXIDIZED_INTERVAL $OXIDIZED_TIMEOUT' < /home/oxidized/.config/oxidized/config.example > /home/oxidized/.config/oxidized/config
echo "Sleep 10 seconds before starting..."
sleep 10
while true
do
status_code=$(curl --write-out %{http_code} --silent --output /dev/null http://wca-nginx/api/v1/component/oxidized/internal/devices-list)
if [[ $status_code -eq  200 ]];
then
  /sbin/my_init
  sleep 10
else
  echo "No response from API by oxidized devices list, sleep..."
  sleep 300
fi
done