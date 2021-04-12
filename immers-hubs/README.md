# Immers App

Tools to deploy your own Immers Space destination in the federated metaverse using Mozilla Hubs Cloud.

## Who is this guide for?

We want hosting an immer to be as accessible as possible,
so we've made our best efforts to streamline this process.
You don't need to be exerienced with system administration or
programming follow this guide,
but you should be a little adventerous and willing to search the web
or [ask us for help](https://github.com/immers-space/immers-app/issues/new) if you come across an instruction you're not familiar with.
If you're comfortable with the command line and have setup your own
website before, then this should be a breeze.

## Prerequisites

Get your tools, services, and Hubs Cloud ready.

### Domains

You'll need two (or three if using AWS) domain names that you control

1. The main domain for your immer that becomes a part of the user handle for immersers based there (e.g. `my-immer.com`)
2. A short domain to make typing in links to your immer easy (e.g `myimmer.link`)
3. (if using AWS hosting for Hubs) An internal domain name most people will never see (e.g. `my-immer-internal.com`)

### Mozilla Hubs Cloud

Deploy your own [Mozilla Hubs Cloud](https://hubs.mozilla.com/cloud).
At this time, Mozilla offers easy to setup hosting solutions with AWS or Digital Ocean,
but we regretfully recommend the AWS option as it is better supported
by the Hubs staff.

1. Follow the [Hubs Cloud AWS quick start guide](https://hubs.mozilla.com/docs/hubs-cloud-aws-quick-start.html)
2. Use [domain recipe 2](https://hubs.mozilla.com/docs/hubs-cloud-aws-domain-recipes.html#recipe-2-domain-is-in-use-configure-subdomain-for-hub-on-route-53) and place your hub on a subdomain of your main domain such as `hub.my-immer.com`
3. Skip the final section "After Deployment Admin Setup" - you won't need to complete these steps

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

Deploy your portal to the Immers Space metaverse and connect it to your Hubs Cloud

### Step 0 - Server

You'll need a server with at least 2GB RAM[¹](#footnotes), 20GB storage, and Docker Compose installed. Your hosting provider might provide a ready-to-use image you can deploy ([Digital Ocean](https://marketplace.digitalocean.com/apps/docker), [AWS](https://aws.amazon.com/marketplace/pp/B08SHXDLL3?qid=1616591908920)), or you can [install Docker](https://docs.docker.com/get-docker/).
Your Immers Server does not need to be on the same hosting provider as your Hubs Cloud.
Once your server is setup, point your main domain to the IP address of your new server (i.e. add a DNS "A" record, [Digital Ocean](https://docs.digitalocean.com/products/networking/dns/how-to/manage-records/), [AWS](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-ec2-instance.html))
and connect to its command prompt over SSH before proceeding.

### Step 1 - Setup

Download a copy of this project to your server

```
git clone https://github.com/immers-space/immers-app.git
cd immers-app/immers-hubs
```

Run the setup script.
It will prompt you to enter the necessary configuration details.

```
./setup.sh
```

You can find detailed descriptions of the configuration options and additional customization options
[in the `immers` readme](https://github.com/immers-space/immers#configuration).
To add static files such as a custom `backgroundImage`,
place the files in `~/immers`
and then edit the file name into the `.env` file
(don't include a leading `/` or the `immers` folder name).

### Step 2 - Go

Start up the server

```
docker-compose up -d
```

This command will start up your Immers Server and connect to your Hubs Cloud and configure it to connect with your Immers Server.
You can monitor the Hubs Cloud Setup progress with `docker-compose logs -f hubdeployer` (press CTRL+C to exit that view later)

\- You must check your Hubs Cloud admin email and click the login link that arrives in order to authorize this process.

After that, you're done! Your Immer is running.
After a short wait the first time your visit (setting up your security certificate),
you'll be redirected to your Hubs Cloud homepage.

### Step 3 - Content

Your immer is now live! However, it's completely empty.
Check out our guide on customizing your immer,
populating it with content,
and using our fremium monetization features (coming soon - in the meantime try the [Hubs documentation](https://hubs.mozilla.com/docs/hubs-cloud-importing-content.html))

### Step 4 - Updates

Log back into your server in the future to apply updates to the Immers Server or the
custom hubs client:

```
cd ~/immers-app/immers-hubs
git pull
./update.sh
```

This will check for updates, make a backup of your database, and,
if necessary, update your Immers Server and/or your Hubs Cloud.

If you make changes to your `.env` file settings after starting your Immers Server,
you'll need to run the following command to make them take effect:

```
docker-compose up -d immer
```

### Footnotes

1. 2GB RAM is required for installs & updates, but, if you're on a budget, you may downsize your Immers Server to 1GB afterwards for routine usage
