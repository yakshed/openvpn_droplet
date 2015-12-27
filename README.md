# Setup an OpenVPN server at DigitalOcean

If you're in desperate need of an OpenVPN you can just use this [Terraform](http://terraform.io) config to start one at [DigitalOcean](https://www.digitalocean.com).

The installation is based on [this guide](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-14-04) and uses the [user data](https://github.com/digitalocean/do_user_scripts/blob/master/Ubuntu-14.04/network/open-vpn.yml) provided by the guide.

## Setup

We use [dotenv](https://github.com/bkeepers/dotenv) to manage the secrets. To install it you need both Ruby and Bundler installed. Run:

```
$ bundle
```

After this copy `.env.sample` to `.env` and fill in your ssh_key ID from DigitalOcean and your DigitalOcean token. A token can be created at the [DigitalOcean website](https://cloud.digitalocean.com/settings/applications#access-tokens). To find your ssh key ID you need to ask the DigitalOcean API:

```
$ curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DIGITAL_OCEAN_TOKEN" "https://api.digitalocean.com/v2/account/keys"
```

## Creating the Droplet

With everything setup you can now create the droplet. OpenVPN will be installed using the above mentioned user data so no special provisioning step is required. You need to first plan your terraform run:

```
$ dotenv terraform plan -out openvpn.out
```

If everything looks good apply the plan:

```
$ dotenv terraform apply openvpn.out
```

## Using the OpenVPN

After the terraform run has been completed you will see the droplet's IP address. Use this address to copy the _unified OpenVPN_ config from the server:

```
$ scp root@$DROPLET_IP:/etc/openvpn/easy-rsa/keys/client.ovpn /path/to/local/DigitalOcean.ovpn
```

Now you could import that config into your OpenVPN client of choice. For more guidance on that topic follow the [DigitalOcean guide](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-ubuntu-14-04#step-5-installing-the-client-profile).
