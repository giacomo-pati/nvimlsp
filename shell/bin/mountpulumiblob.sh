#!/bin/bash
echo "accountName $AZURE_STORAGE_ACCOUNT" > "$HOME/fuse_connection.cfg"
echo "accountKey $AZURE_STORAGE_KEY" >> "$HOME/fuse_connection.cfg"
echo "containerName azapphost" >> "$HOME/fuse_connection.cfg"
sudo mkdir -p /mnt/aahdsapulumi
sudo chown "$USER" /mnt/aahdsapulumi
sudo mkdir -p /mnt/resource
sudo chown "$USER" /mnt/resource
mkdir -p /mnt/resource/blobfusetmp

blobfuse /mnt/aahdsapulumi --tmp-path=/mnt/resource/blobfusetmp  --config-file=/home/s3u3ix/fuse_connection.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120
