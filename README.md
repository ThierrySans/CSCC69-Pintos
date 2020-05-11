# Pintos

## Mount, build and run

Mount:

```
docker run -it -v $(pwd)/src:/pintos johnstarich/pintos bash
```

Build:

```
$ cd threads
$ make
```

Run Qemu: 

```
pintos --qemu -- -q run alarm-zero
```

## Original Pintos codebase

```
curl -o pintos.tar.gz -L http://www.stanford.edu/class/cs140/projects/pintos/pintos.tar.gz
```

## Code changes

Source: [JohnStarich/docker-pintos](https://github.com/JohnStarich/docker-pintos)

```
# Fix ACPI bug
## Fix described here under "Troubleshooting": http://arpith.xyz/2016/01/getting-started-with-pintos/
sed -i '/serial_flush ();/a outw( 0x604, 0x0 | 0x2000 );' /pintos/devices/shutdown.c
# Configure Pintos for QEMU
sed -i 's/bochs/qemu/' /pintos/*/Make.vars
## Reconfigure Pintos to use QEMU
sed -i 's/\/usr\/class\/cs140\/pintos\/pintos\/src/\/pintos/' /pintos/utils/pintos-gdb
sed -i 's/LDFLAGS/LDLIBS/' /pintos/utils/Makefile
sed -i 's/\$sim = "bochs"/$sim = "qemu"/' /pintos/utils/pintos
sed -i 's/kernel.bin/\/pintos\/threads\/build\/kernel.bin/' /pintos/utils/pintos
sed -i "s/my (@cmd) = ('qemu');/my (@cmd) = ('qemu-system-x86_64');/" /pintos/utils/pintos
sed -i 's/loader.bin/\/pintos\/threads\/build\/loader.bin/' /pintos/utils/Pintos.pm
```