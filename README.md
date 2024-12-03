# Quadletron

Generate live Arch images that just run Podman Quadlets!

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
`mkarchiso` tool, which creates live Arch images for use with removeable media.
The Quadletron container includes `archiso` and the profile directory on build.
With each run, the container makes a variation of `archiso-profile` that
incorporates changes from a "Quadletron dir", which contains Podman Quadlets
(ending in ".container") as well as env var configs for individual users (ending
in ".user").

An example Quadletron dir is available in `example_quadletron_dir`. Note that it
includes a file with neither of the extensions the script looks for. This file,
and any others lacking ".container" or ".user", will be ignored.

### Helper script

Command to create the container:

```bash
./helper.sh build
```

Command to build a Quadletron iso for a given Quadletron dir:

```bash
./helper.sh run <quadletron_dir>
```

### Customizing the archiso profile

Be very careful to follow Arch Linux's documentation on archiso profiles. After
changing anything in `archiso-profile`, you will need to run `./helper.sh build`
again for the changes to take effect.
