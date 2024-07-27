# Embedded Xinu executable environment with mipsel QEmu.

## How to use

```
$ git clone git@github.com:yutaka-m/xinu-qemu-docker-env.git
$ cd xinu-qemu-docker-env
$ docker build -t xinu-qemu-docker-env .
$ docker run -it xinu-qemu-docker-env sh
$ qemu-system-mipsel -M mips -m 16M -kernel /build/xinu/compile/xinu.boot -nographic
```

## Example

```
$ docker run -it xinu-qemu-docker-env sh
# qemu-system-mipsel -M mips -m 16M -kernel /build/xinu/compile/xinu.boot -nographic
qemu-system-mipsel: warning: could not load MIPS bios 'mipsel_bios.bin'
(Embedded Xinu) (mipsel-qemu) #0 (root@buildkitsandbox) Sat Jul 27 14:31:57 UTC 2024

   8388608 bytes physical memory.
      4096 bytes reserved system area.
     93448 bytes Xinu code.
      8196 bytes stack space.
   8261592 bytes heap space.


--------------------------------------
      ____  ___.__
      \   \/  /|__| ____  __ __
       \     / |  |/    \|  |  \
       /     \ |  |   |  \  |  /
      /___/\  \|__|___|  /____/
            \_/        \/       v2.0
--------------------------------------

Welcome to the wonderful world of Xinu!
xsh$
```

