# Standalone Immers Social Networking Server

Deploy a standalone Immers Server that you will integrate with your own unique Immersive Web experience.

## Who is this guide for?

This is a more advanced guide for experienced Immersive Web developers.

## Prerequisites

Get your tools and services ready.

### Domains

The Immers Server can share a domain with your existing site.
For the best experience, put the Immers Server on the bare domain, as this becomes a part of usernames,
and put your web content on a subdomain.
The Immers Server will redirect to your web content subdomain.

### SMTP Email Provider

Immers uses e-mail to handle password resets.
Find an e-mail delivery provider that allows sending over SMTP.
[SendGrid](https://sendgrid.com/docs/for-developers/sending-email/getting-started-smtp/), for example, offers a free plan that should be more than enough.
Make note of your SMTP domain name, username, and password.
To help escape spam folders, follow your provider's instructions for domain verification.

### Web Monetization Payment Pointer

Earn money from your immer without including intrusive ads or
compromising user privacy using Web Monetization.
[Sign up for a free creator account at Coil.com](https://coil.com/creator)
and follow the instructions there to setup
a wallet and get a payment pointer.

## Immers social networking server

Deploy your portal to the Immers Space metaverse

### Step 0 - Server

You'll need a server with Docker & Docker Compose installed. Your hosting provider might provide a ready-to-use image you can deploy ([Digital Ocean](https://marketplace.digitalocean.com/apps/docker), [AWS](https://aws.amazon.com/marketplace/pp/B08SHXDLL3?qid=1616591908920)), or you can [install Docker](https://docs.docker.com/get-docker/).
Once your server is setup, connect to its command prompt over SSH before proceeding. 

### Step 1 - Setup

Download a copy of this project to your server

```
git clone https://github.com/immers-space/immers-app.git
cd immers-app/immers
```

Run the setup script.
It will prompt you to enter the necessary configuration details.

```
./setup.sh
```

You can find detailed descriptions of the configuration options and additional customization options
[in the immers readme](https://github.com/immers-space/immers#configuration).
To add static files such as a custom `backgroundImage`,
place the files in `~/immers`
and then edit the file name into the `.env` file
(don't include a leading `/` or the immers folder name).

### Step 2 - Go

Start up the server

```
docker-compose up -d
```

That's it! Your immer is running.
If you haven't already done so, make sure to update your domain provider
to point your domain to the IP address of your new server and then visit
`my-immer.com/auth/login` to confirm you see your login page.
The first time you load, it will take longer as it sets up your security certificate (you can watch it happening in real time with `docker-compose logs -f`)

### Step 3 - Integrating Immers Space into your Immersive Web content

Coming soon...

### Step 4 - Updates

Updates are accomplished with `docker-compose pull`.
The `update.sh` script will backup the db, pull, apply migrations, and restart the the server.
Just make sure you `git pull` the latest version of this project first.

Recover from a failed migration with `dbrestore.sh`

If you make changes to your `.env` file settings after starting your Immers Server,
you'll need to run the following command to make them take effect:

```
docker-compose up -d immer
```
