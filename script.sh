#!/bin/bash

cat <<EOF
Welcome to the docker.io/xcellent/challange container
EOF


if [ -z ${DISABLE_SSHD+x} ]; then
	echo ">> starting sshd on port 22"
	/usr/sbin/sshd
fi

while [ 0 -eq 0 ]; do
  echo starting myhelperscript
  python -u myhelperscript.py
done

/bin/bash -c 'while true; do echo "update/fix rights on /userdata"; chmod a+rw -R /userdata; done'

if [ -e '/userdata/.start_container_service' ]; then
  echo yay we are good to go
fi

java -jar my-service.jar &

exec nginx -g deamon off

logrotated &

# exec CMD
echo ">> run docker CMD as user 'app'"
echo "su -s /bin/sh -c \"$@\" app"
su -s /bin/sh -c "$@" app
echo "exit code: $?"
