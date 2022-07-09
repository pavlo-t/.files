### Downgrading the kernel from liveCD if you can't boot

Find root partition:

```sh
lsblk
mount <root_partition> /mnt
arch-chroot /mnt /bin/bash
cd /var/cache/pacman/pkg/
```

At least downgrade linux, linux-headers and any kernel modules. For example:

```sh
pacman -U linux-3.5.6-1-x86_64.pkg.tar.xz linux-headers-3.5.6-1-x86_64.pkg.tar.xz virtualbox-host-modules-4.2.0-5-x86_64.pkg.tar.xz
```

### Downgrading packages

```sh
cd /var/cache/pacman/pkg/
pacman -U <file_name_of_the_package>
```

### Ignoring packages while upgrading

Use `--ignore` option with __comma-separated__ list of packages like:

```sh
pacman -Syu --ignore <package>
```

### Adding packages to pacman's ignore list

In `/etc/pacman.conf` find line with `IgnorePkg =` and list packages that shouldn't update

```conf
#IgnorePkg   =
IgnorePkg=<package> <package>
IgnorePkg=<package>
#IgnoreGroup =
IgnoreGroup=<group>
```

*You can use both space separated list and multiple lines*

*You still can upgrade ignored packages with `pacman -S <package>`*

### Restoring packages to a specific date

#### 1a. You can either replace your /etc/pacman.d/mirrorlist by the following content:

```
##
## Arch Linux repository mirrorlist
## Generated on 2042-01-01
##
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch
```

#### 1b. Or you can edit /etc/pacman.conf and use the following server directive:

```
...
[core]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch

[extra]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch

[community]
SigLevel = PackageRequired
Server=https://archive.archlinux.org/repos/2014/03/30/$repo/os/$arch
...
```

#### 2. Update the database and force downgrade:

```sh
pacman -Syyuu
```
