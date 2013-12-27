TARGETS = mountkernfs.sh mountdevsubfs.sh bootlogd keymap.sh hostname.sh hwclockfirst.sh checkroot.sh hwclock.sh ifupdown-clean module-init-tools mtab.sh checkfs.sh mountall.sh ifupdown mountall-bootclean.sh mountoverflowtmp networking urandom procps x11-common portmap mountnfs.sh mountnfs-bootclean.sh console-screen.sh quota screen-cleanup bootmisc.sh stop-bootlogd-single lm-sensors
INTERACTIVE = keymap.sh checkroot.sh checkfs.sh console-screen.sh
mountdevsubfs.sh: mountkernfs.sh
bootlogd: mountdevsubfs.sh
keymap.sh: mountdevsubfs.sh bootlogd
hostname.sh: bootlogd
hwclockfirst.sh: bootlogd mountdevsubfs.sh
checkroot.sh: mountdevsubfs.sh hostname.sh keymap.sh hwclockfirst.sh bootlogd
hwclock.sh: checkroot.sh bootlogd
ifupdown-clean: checkroot.sh
module-init-tools: checkroot.sh
mtab.sh: checkroot.sh
checkfs.sh: checkroot.sh mtab.sh
mountall.sh: checkfs.sh
ifupdown: ifupdown-clean
mountall-bootclean.sh: mountall.sh
mountoverflowtmp: mountall-bootclean.sh
networking: mountkernfs.sh mountall.sh mountoverflowtmp ifupdown
urandom: mountall.sh mountoverflowtmp
procps: mountkernfs.sh mountall.sh mountoverflowtmp module-init-tools bootlogd
x11-common: mountall.sh mountoverflowtmp
portmap: networking ifupdown mountall.sh mountoverflowtmp
mountnfs.sh: mountall.sh mountoverflowtmp networking ifupdown portmap
mountnfs-bootclean.sh: mountall.sh mountoverflowtmp mountnfs.sh
console-screen.sh: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
quota: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
screen-cleanup: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
bootmisc.sh: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
stop-bootlogd-single: mountall.sh mountoverflowtmp console-screen.sh keymap.sh mountnfs.sh mountnfs-bootclean.sh networking ifupdown hwclock.sh ifupdown-clean portmap quota urandom mountkernfs.sh checkroot.sh hostname.sh mountall-bootclean.sh mountdevsubfs.sh procps module-init-tools hwclockfirst.sh bootlogd checkfs.sh mtab.sh x11-common screen-cleanup bootmisc.sh lm-sensors
lm-sensors: mountall.sh mountoverflowtmp mountnfs.sh mountnfs-bootclean.sh
