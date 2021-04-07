# Immers App
Tools to deploy your own Immers Space destination in the federated metaverse.

There are two parts that make up an immer.
1. Your Immersive Web experience.
Immers Space is designed to work across platforms and engines with any experience, but here we'll describe the setup specifically with Mozilla Hubs Cloud.
2. The immers social networking server.
This is what connects your experience with the metaverse and allows immersers from other immers to bring their identity, avatars, and friends to your destination.

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

### Software on your computer

You'll need these free applications installed on your computer:

* [git](https://git-scm.com/downloads)
* [NodeJS](https://nodejs.org/en/download/)

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
compromosing user privacy using Web Monetization.
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
cd immers-app
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

## Connect your Hubs Cloud to the Immers Space metaverse

Configure your Hubs Cloud to use our enhanced client to connect to your
immers server and the entire Immers Space metaverse.

### Step 1 - Download the Immers Space Hubs fork to your computer

```
git clone https://github.com/immers-space/hubs.git
cd hubs
```

### Step 2 - Connect to your hubs cloud

You'll be prompted to enter your Hubs Cloud domain (e.g. `hub.my-immer.com`) and the administrator e-mail you provided when you setup your Hubs Cloud.

```
npm run login
```

### Step 3 - Deploy the custom client

This will run for a few minutes as it builds the client on your computer
and then uploads it to your Hubs Cloud

```
npm run deploy
```

### Step 4 - Configure

Head the the admin panel of your hubs cloud at e.g. `hub.my-immer.com/admin` to set a few final configuration options.

**App Settings**

Under the Setup menu, select App Settings and then the "Features" tab

* Toggle **on** "Disable account creation" (your users will create their accounts on your immers server instead).
* Toggle **off** "Enable scene editor" (you can still use it, but your users won't be able to without Hubs accounts)

**Advanced Server Settings**

Under the Setup menu, select Server Settings and then select the "Advanced" tab.
Add the following settings on this page and then click the "Save" button
at the bottom.

Setting name  | What to enter
 --- | ---
 Extra Content Security Policy **connect-src** Rules | `https: wss:`
 Extra **Homepage** Header HTML | `<meta name="env:immers_server" content="https://my-immer.com"><meta name="monetization" content="your-payment-pointer">`
 Extra **Room** Header HTML | `<meta name="env:immers_server" content="https://my-immer.com"><meta name="monetization" content="your-payment-pointer">`
Allowed CORS origins | `*`

There are serveral similar looking options on this page, take note
of the bolded portions in the settings names above, and make sure to
substitute your real main domain name and payment pointers.

### Step 5 - Content

Your immer is now live! However, it's completely empty.
Check out our guide on customizing your immer,
populating it with content,
and using our fremium monetization features (coming soon - in the meantime try the [Hubs documentation](https://hubs.mozilla.com/docs/hubs-cloud-importing-content.html))

