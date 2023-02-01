#!/usr/bin/env bash
set -e
if [ -f "./.env" ]; then
  echo ".env file already exists. Exiting to avoid changing secrets. Edit the file directly instead."
  exit 1
fi
echo 'Creating .env settings file'
cat ./.env.defaults > ./.env
echo 'Generating secret keys.'
sessionSecret=$(openssl rand -base64 32)
easySecret=$(openssl rand -base64 32)
sed -Ei "s|(sessionSecret=).*|\1$sessionSecret|" ./.env
sed -Ei "s|(easySecret=).*|\1$easySecret|" ./.env
echo 'Please answer the following prompts to configure your immer.'
echo 'Visit https://github.com/immers-space/immers-app for more info.'
read -p 'Name of your immer (e.g. Immers Space): ' immerName
sed -Ei "s|(name=).*|\1$immerName|" ./.env
read -p 'Base domain for your immer (e.g. immers.space): ' domain
sed -Ei "s|(domain=).*|\1$domain|" ./.env
# nginx reverse proxy config
echo ALLOWED_DOMAINS=$domain >> .env.nignx
echo SITES=$domain=immer:8081 >> .env.nginx
read -p 'Domain for your Immersive Web experience (e.g. hub.immers.space): ' hub
sed -Ei "s|(hub=).*|\1$hub|" ./.env
read -p 'Domain for your smtp email service: ' smptHost
sed -Ei "s|(smptHost=).*|\1$smptHost|" ./.env
read -p 'Port for your smtp email service (default 587): ' smptPort
[ -z "$smptPort" ] || sed -Ei "s|(smptPort=).*|\1$smptPort|" ./.env
read -p 'Username for your smtp email service: ' smtpUser
sed -Ei "s|(smtpUser=).*|\1$smtpUser|" ./.env
read -p 'Password for your smtp email service: ' smtpPassword
sed -Ei "s|(smtpPassword=).*|\1$smtpPassword|" ./.env
sed -Ei "s|(smtpFrom=noreply@mail\.).*|\1$domain|" ./.env
# create host directory for static theme files
mkdir -p ~/immers
echo 'Your immer is configured. Additional options are available by editing the .env file. It is a good idea download a backup copy of this file.'
echo 'Start your immer with the command "docker-compose up -d"'
