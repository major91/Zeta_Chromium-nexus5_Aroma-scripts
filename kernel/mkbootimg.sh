#!/tmp/busybox sh
outputdir=/tmp/
mkbootimg=/tmp/mkbootimg
kernelimage=/tmp/zImage-dtb
ramdisk=/tmp/boot.img-ramdisk.gz
cmdline="console=ttyHSL0,115200,n8 androidboot.hardware=hammerhead user_debug=31 msm_watchdog_v2.enable=1"
base=0x00000000
pagesize=2048
ramdiskoffset=0x02900000
tagsoffset=0x02700000
outputkernel=newboot.img

$mkbootimg --kernel $kernelimage --ramdisk $ramdisk --cmdline "$cmdline"  --base $base --pagesize $pagesize  --ramdisk_offset $ramdiskoffset --tags_offset $tagsoffset --output $outputdir$outputkernel
