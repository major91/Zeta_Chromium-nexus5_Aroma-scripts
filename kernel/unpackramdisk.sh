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
/tmp/busybox sed -i 's/service sdcard.*/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot\n\nservice sdcard_2 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/mnt\/shell\/emulated\/obb \/mnt\/shell\/emulated\/0\/Android\/obb\n    class core\n    user root\n    oneshot/g' $outputdir/init.hammerhead.rc
fi

#user is coming from old version of Zeta Chromium
if grep "mount -t sdcardfs" $outputdir/init.hammerhead.rc
then
if ! grep "service sdcard_2" $outputdir/init.hammerhead.rc
then
/tmp/busybox sed -i 's/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot\n\nservice sdcard_2 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/mnt\/shell\/emulated\/obb \/mnt\/shell\/emulated\/0\/Android\/obb\n    class core\n    user root\n    oneshot/g' $outputdir/init.hammerhead.rc
fi
fi

#user is coming from old test version of Zeta Chromium
if grep "service sdcard_3" $outputdir/init.hammerhead.rc
then
/tmp/busybox sed -i 's/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot\n\nservice sdcard2 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media\/0 \/storage\/emulated\/0\n    class core\n    user root\n    oneshot\n\nservice sdcard_3 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media\/legacy \/storage\/emulated\/legacy\n    class core\n    user root\n    oneshot/service sdcard \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/data\/media \/mnt\/shell\/emulated\n    class core\n    user root\n    oneshot\n\nservice sdcard_2 \/sbin\/busybox mount -t sdcardfs -o rw,nosuid,nodev,noatime,nodiratime,uid=1023,gid=1023 \/mnt\/shell\/emulated\/obb \/mnt\/shell\/emulated\/0\/Android\/obb\n    class core\n    user root\n    oneshot/g' $outputdir/init.hammerhead.rc
fi

if ! grep "/data/media/0/Android/obb" $outputdir/fstab.hammerhead
then
/tmp/busybox echo "/data/media/obb	/data/media/0/Android/obb	none	bind	wait" >> $outputdir/fstab.hammerhead
fi

/tmp/busybox sed -i -e 's/on init/on init\n    setenforce 0\n    setprop ro.boot.selinux 0/g' $outputdir/init.hammerhead.rc

/tmp/busybox mv /tmp/zetaChromium.sh $outputdir/sbin/zetaChromium.sh

find . | cpio -o -H newc | gzip > ../boot.img-ramdisk.gz
