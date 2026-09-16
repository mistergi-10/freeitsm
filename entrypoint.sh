#!/bin/sh
set -e

# Redirect every path that needs to persist onto the single Render disk
# mounted at /data, so uploads/keys survive redeploys.
mkdir -p /data/encryption_keys /data/tickets-attachments /data/change-management-attachments \
  /data/uploads /data/recordings /data/lms-content /data/contracts-rfp-builder-uploads \
  /data/system-uploads-branding /data/war-room-attachments
chown -R www-data:www-data /data

mkdir -p /var/www/html/tickets /var/www/html/change-management /var/www/html/lms \
  /var/www/html/contracts/rfp-builder /var/www/html/system/uploads /var/www/html/war-room

rm -rf /var/www/encryption_keys /var/www/html/tickets/attachments \
  /var/www/html/change-management/attachments /var/www/html/uploads /var/www/html/recordings \
  /var/www/html/lms/content /var/www/html/contracts/rfp-builder/uploads \
  /var/www/html/system/uploads/branding /var/www/html/war-room/attachments

ln -s /data/encryption_keys /var/www/encryption_keys
ln -s /data/tickets-attachments /var/www/html/tickets/attachments
ln -s /data/change-management-attachments /var/www/html/change-management/attachments
ln -s /data/uploads /var/www/html/uploads
ln -s /data/recordings /var/www/html/recordings
ln -s /data/lms-content /var/www/html/lms/content
ln -s /data/contracts-rfp-builder-uploads /var/www/html/contracts/rfp-builder/uploads
ln -s /data/system-uploads-branding /var/www/html/system/uploads/branding
ln -s /data/war-room-attachments /var/www/html/war-room/attachments

exec apache2-foreground
