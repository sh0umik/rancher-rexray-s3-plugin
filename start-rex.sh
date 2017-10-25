#!/usr/bin/env sh

cd /etc/rexray/
sed -i "s/S3FS_ACCESSKEY/$S3FS_ACCESSKEY/g" /etc/rexray/config.yml
sed -i "s/S3FS_SECRETKEY/$S3FS_SECRETKEY/g" /etc/rexray/config.yml

/usr/bin/rexray version
/usr/bin/rexray start --logLevel=info --nopid