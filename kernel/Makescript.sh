#!/sbin/sh

#if [ ! -d /system/etc/init.d ]
#then
#mkdir -p /system/etc/init.d
#fi

#Build config file
SCRIPT="/tmp/zetaChromium.sh"

#CPU Setting
GOVERNOR=`grep "selected.1" /tmp/aroma/cpu.prop | cut -d '=' -f2`
MAXFREQ=`grep "selected.2" /tmp/aroma/cpu.prop | cut -d '=' -f2`
MINFREQ=`grep "selected.3" /tmp/aroma/cpu.prop | cut -d '=' -f2`
IDLEMAXFREQ=`grep "selected.4" /tmp/aroma/cpu.prop | cut -d '=' -f2`

#IO Settings
IO=`grep "selected.1" /tmp/aroma/io.prop | cut -d '=' -f2`
BUFFERSIZE=`grep "selected.2" /tmp/aroma/io.prop | cut -d '=' -f2`

#Sleep Setting
S2W=`grep "selected.1" /tmp/aroma/sleep.prop | cut -d '=' -f2`
DTW=`grep "selected.2" /tmp/aroma/sleep.prop | cut -d '=' -f2`

#VIB ----
VIB=`grep "selected.1" /tmp/aroma/vib.prop | cut -d '=' -f2`

#Misc Setting
COLOR=`grep "item.1.1" /tmp/aroma/misc.prop | cut -d '=' -f2`
FCG=`grep "item.1.2" /tmp/aroma/misc.prop | cut -d '=' -f2`
BLD=`grep "item.1.3" /tmp/aroma/misc.prop | cut -d '=' -f2`
FSC=`grep "item.1.4" /tmp/aroma/misc.prop | cut -d '=' -f2`
#Start
echo "#!/sbin/busybox sh" > $SCRIPT

#Governor Setting
if [ $GOVERNOR = 1 ]; then
echo "echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 2 ]; then
echo "echo lazy > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 3 ]; then
echo "echo dancedance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 4 ]; then
echo "echo wheatley > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 5 ]; then
echo "echo intellidemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 6 ]; then
echo "echo conservation > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 7 ]; then
echo "echo ondemand > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 8 ]; then
echo "echo ondemandplus > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 9 ]; then
echo "echo intelliactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 10 ]; then
echo "echo HYPER > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 11 ]; then
echo "echo nightmare > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
elif [ $GOVERNOR = 12 ]; then
echo "echo pegasusq > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor" >> $SCRIPT;
fi

#Max Freq Setting
if [ $MAXFREQ = 1 ]; then
echo "echo 2265600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $SCRIPT;
elif [ $MAXFREQ = 2 ]; then
echo "echo 1958400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $SCRIPT;
elif [ $MAXFREQ = 3 ]; then
echo "echo 1728000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $SCRIPT;
elif [ $MAXFREQ = 4 ]; then
echo "echo 1574400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq" >> $SCRIPT;
fi

#Min Freq Setting
if [ $MINFREQ = 1 ]; then
echo "echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $SCRIPT;
elif [ $MINFREQ = 2 ]; then
echo "echo 422400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $SCRIPT;
elif [ $MINFREQ = 3 ]; then
echo "echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $SCRIPT;
elif [ $MINFREQ = 4 ]; then
echo "echo 729600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $SCRIPT;
elif [ $MINFREQ = 5 ]; then
echo "echo 883200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" >> $SCRIPT;
fi

#IDLEMAXFREQ
if [ $IDLEMAXFREQ = 1 ]; then
echo "echo 1190400 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq" >> $SCRIPT;
elif [ $IDLEMAXFREQ = 2 ]; then
echo "echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq" >> $SCRIPT;
elif [ $IDLEMAXFREQ = 3 ]; then
echo "echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq" >> $SCRIPT;
elif [ $IDLEMAXFREQ = 4 ]; then
echo "echo 883200 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq" >> $SCRIPT;
elif [ $IDLEMAXFREQ = 5 ]; then
echo "echo 729600 > /sys/devices/system/cpu/cpu0/cpufreq/screen_off_max_freq" >> $SCRIPT;
fi

#IO Setting
if [ $IO = 1 ]; then
echo "echo sio > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 2 ]; then
echo "echo noop > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 3 ]; then
echo "echo deadline > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 4 ]; then
echo "echo row > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 5 ]; then
echo "echo cfq > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 6 ]; then
echo "echo fiops > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
elif [ $IO = 7 ]; then
echo "echo zen > /sys/block/mmcblk0/queue/scheduler" >> $SCRIPT;
fi

#IO BufferSize
if [ $BUFFERSIZE = 1 ]; then
echo "echo 128 > /sys/block/mmcblk0/queue/read_ahead_kb" >> $SCRIPT;
elif [ $BUFFERSIZE = 2 ]; then
echo "echo 256 > /sys/block/mmcblk0/queue/read_ahead_kb" >> $SCRIPT;
elif [ $BUFFERSIZE = 3 ]; then
echo "echo 384 > /sys/block/mmcblk0/queue/read_ahead_kb" >> $SCRIPT;
elif [ $BUFFERSIZE = 4 ]; then
echo "echo 512 > /sys/block/mmcblk0/queue/read_ahead_kb" >> $SCRIPT;
fi

#S2W
if [ $S2W = 1 ]; then
echo "echo 0 > /sys/android_touch/sweep2wake" >> $SCRIPT;
elif [ $S2W = 2 ]; then
echo "echo 1 > /sys/android_touch/sweep2wake" >> $SCRIPT;
elif [ $S2W = 3 ]; then
echo "echo 2 > /sys/android_touch/sweep2wake" >> $SCRIPT;
fi

#DT2W
if [ $DTW = 1 ]; then
echo "echo 0 > /sys/android_touch/doubletap2wake" >> $SCRIPT;
elif [ $DTW = 2 ]; then
echo "echo 1 > /sys/android_touch/doubletap2wake" >> $SCRIPT;
fi

#VIB
if [ $VIB = 1 ]; then
echo "echo 60 > /sys/devices/virtual/timed_output/vibrator/amp" >> $SCRIPT;
elif [ $VIB = 2 ]; then
echo "echo 70 > /sys/devices/virtual/timed_output/vibrator/amp" >> $SCRIPT;
elif [ $VIB = 3 ]; then
echo "echo 80 > /sys/devices/virtual/timed_output/vibrator/amp" >> $SCRIPT;
elif [ $VIB = 4 ]; then
echo "echo 90 > /sys/devices/virtual/timed_output/vibrator/amp" >> $SCRIPT;
elif [ $VIB = 5 ]; then
echo "echo 100 > /sys/devices/virtual/timed_output/vibrator/amp" >> $SCRIPT;
fi

#MISC
if [ $COLOR = 1 ]; then
echo "echo 1 > /sys/module/mdss_dsi/parameters/color_preset" >> $SCRIPT;
fi
if [ $FCG = 1 ]; then
echo "echo 1 > /sys/kernel/fast_charge/force_fast_charge" >> $SCRIPT;
fi
if [ $BLD = 1 ]; then
echo "echo 1 > /sys/module/lm3630_bl/parameters/backlight_dimmer" >> $SCRIPT;
fi
if [ $FSC = 1 ]; then
echo "echo 1 > /sys/kernel/dyn_fsync/Dyn_fsync_active" >> $SCRIPT;
fi

#chmod 755 /system/etc/init.d
chmod 755 $SCRIPT
