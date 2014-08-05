#!/tmp/busybox sh
outputdir=/tmp/ramdisk
unpackbootimg=/tmp/unpackbootimg
kernelimage=/tmp/zImage-dtb
ramdisk=/tmp/boot.img-ramdisk.gz

cd /tmp
mkdir $outputdir
mv $ramdisk $outputdir/
cd $outputdir
/tmp/busybox gunzip boot.img-ramdisk.gz
/tmp/busybox cpio -idmv < boot.img-ramdisk
rm boot.img-ramdisk

if [ ! -e $outputdir/sbin/busybox ]
then
/tmp/busybox cp /tmp/busybox $outputdir/sbin/busybox
/tmp/busybox chmod 755 $outputdir/sbin/busybox
fi

if grep zetaChromium $outputdir/init.rc
then
echo 존재
else
echo -e "" >> $outputdir/init.rc
echo "service zetaChromium /sbin/zetaChromium.sh" >> $outputdir/init.rc
echo "    class core" >> $outputdir/init.rc
echo "    user root" >> $outputdir/init.rc
echo "    oneshot" >> $outputdir/init.rc
fi

#user is coming from stock kernel
if grep "service sdcard /system/bin/sdcard" $outputdir/init.hammerhead.rc
then
LINE=$(/tmp/busybox sed -n '/service sdcard/=' $outputdir/init.hammerhead.rc)
let NLINE=$LINE+1
/tmp/busybox sed -i "$NLINE""d" $outputdir/init.hammerhead.rc
/tmp/busybox sed -i 's/service sdcard.*/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023,wgid=1015,derive=legacy,reserved_mb=20 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot/g' $outputdir/init.hammerhead.rc
fi

#user is coming from old test version of Zeta Chromium
if grep "service sdcard_3" $outputdir/init.hammerhead.rc
then
/tmp/busybox sed -i 's/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot\n\nservice sdcard2 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media\/0 \/storage\/emulated\/0\n    class core\n    user root\n    oneshot\n\nservice sdcard_3 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media\/legacy \/storage\/emulated\/legacy\n    class core\n    user root\n    oneshot/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023,wgid=1015,derive=legacy,reserved_mb=20 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot/g' $outputdir/init.hammerhead.rc
fi

if grep "uid=1023,gid=1023 /data/media" $outputdir/init.hammerhead.rc
then
/tmp/busybox sed -i 's/uid=1023,gid=1023 \/data\/media/uid=1023,gid=1023,wgid=1015,derive=legacy,reserved_mb=20 \/data\/media/g' $outputdir/init.hammerhead.rc
fi

if grep "/devices/platform/xhci-hcd auto vfat defaults voldmanaged=usbdisk:auto" $outputdir/fstab.hammerhead
then
echo exist
else
echo "/devices/platform/xhci-hcd auto vfat defaults voldmanaged=usbdisk:auto" >> $outputdir/fstab.hammerhead
fi

if grep "/data/media/0/Android/obb" $outputdir/fstab.hammerhead
then
/tmp/busybox cat $outputdir/fstab.hammerhead | grep -v "/data/media/0/Android/obb" > /tmp/fstab.tmp
/tmp/busybox mv /tmp/fstab.tmp $outputdir/fstab.hammerhead
/tmp/busybox chmod 640 $outputdir/fstab.hammerhead
fi

/tmp/busybox sed -i -e 's/on init/on init\n    setenforce 0\n    setprop ro.boot.selinux 0/g' $outputdir/init.hammerhead.rc

/tmp/busybox mv /tmp/zetaChromium.sh $outputdir/sbin/zetaChromium.sh

find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
