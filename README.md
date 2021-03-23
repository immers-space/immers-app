# immers app
Tools to deploy your own Immers Space destination in the federated metaverse.


## Deploying the immers social networking server

### Step 0

You'll need a server with Docker & Docker Compose installed. Your hosting provider might provide [a ready-to-use image you can deploy](https://marketplace.digitalocean.com/apps/docker), or you can [install Docker](https://docs.docker.com/get-docker/).
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

You can find more detailed descriptions of the configuration options [in the immers readme](https://github.com/immers-space/immers).


### Step 2 - Go

Start up the server

```
docker-compose up -d
```

That's it! Your immer is running.
If you haven't already done so, make sure to update your domain provider
to point your domain to the ip address of your new server and then visit
`yourdomain.com/auth/login` to confirm you see your login page.

## Using with Mozilla Hubs Cloud

### Domains

For the best user experience, install your hubs-cloud on a subdomain (e.g. hub.yourdomain.com) when
running the hubs-cloud setup and then use the main domain (e.g. yourdomain.com) for your immer.
This way users only need to use the main domain in the immers handle (user@yourdomain.com).
Attempts to navigate to the main domain will be redirected to the hub homepage automatically.


### Hubs cloud setup

1. [Deply custom hubs client](https://hubs.mozilla.com/docs/hubs-cloud-custom-clients.html) from [immers-space/hubs#immers-integration](https://github.com/immers-space/hubs/tree/immers-integration)
1. Add config in hubs cloud admin -> setup -> sever settings -> advanced
  * Extra room Header HTML: `<meta name="env:immers_server" content="https://your.immers.server">`
  (replace value in content with your immers server url)
  * Extra Content Security Policy connect-src Rules: `https: wss:`
  (allows API and streaming connections to remote users home instances)
  * Allowed CORS origins: `*`
  (temporary measure cross-hub for avatar sharing)