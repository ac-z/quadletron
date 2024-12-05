# Quadletron

Generate live Arch images that *just* run Podman Quadlets!

### Why?

Immutable server and IoT infrastructure! I don't need any fancy shmancy atomic
update system. Updating by writing an iso to a USB is still atomic, and you can
still roll back as long as you keep your old isos around.

I could have used an automation file with a stable distro like Debian, but
package stability is less important if you rely on a very small amount of
packages with stability effort from upstream. This way, security fixes from
upstream are available immediately, instead of whenever they get backported.

### How?

The directory `archiso-profile` is set up for use with Arch Linux's fantastic
`mkarchiso` tool, which creates live Arch images to boot from removeable media.
The Quadletron container includes `mkarchiso` and a copy of the profile dir on
build. With each run, the container makes a variation of `archiso-profile` that
incorporates changes from a "Quadletron dir", which contains Podman Quadlet 
files as well as *.user files that the container script reads in order to add 
users and SSH public keys. 

### Helper script

Command to create the container:

```bash
./helper.sh build
```

Command to build a Quadletron iso for a given Quadletron dir:

```bash
./helper.sh run <quadletron_dir>
```

### Valid file extensions 

Podman Quadlets:
* *.container
* *.volume
* *.network
* *.build
* *.pod
* *.kube

Quadletron configs:
* *.user
* (maybe more in the future)

An example Quadletron dir is available in `example_quadletron`. Note that it
includes a file with none of the extensions the script looks for. This file,
and any others lacking the file extensions above, will be ignored.

### Config files

Any *.user files picked up by the container script will be sourced as bash
scripts inside the container. In these scripts, the following variables are
necessary, or else the iso won't build.
* `NAME`: The desired username for the user being created
* `PUBKEY`: The public SSH key to be placed in the user's authorized_keys file

The following optional variables are also available:
* `SUDO`: If set to true, the user will be given sudo privileges.
* `USER_ID`: The user ID to be used. If not specified, each user is given a
unique ID incrementally starting from 1000.

### Customizing the archiso profile

Be very careful to follow Arch Linux's documentation on archiso profiles. After
changing anything in `archiso-profile`, you will need to run `./helper.sh build`
again for the changes to take effect.
