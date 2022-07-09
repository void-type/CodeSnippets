#! /bin/bash

# Raspi Monitor
# A simple script to measure CPU parameters on the Raspberry Pi
# press ctrl c to exit
# @author: Jeff Schreiner

function get_params {

	THERM=$(cat /sys/class/thermal/thermal_zone0/temp)
	let THERM=THERM/1000

	CPU=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
	let CPU=CPU/1000

	MIN=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq)
	let MIN=MIN/1000

	MAX=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq)
	let MAX=MAX/1000

	GPU=$(vcgencmd measure_clock core | cut -d"=" -f2)
	let GPU=GPU/1000000

	VOLTS=$(vcgencmd measure_volts | cut -d"=" -f2 | cut -d"V" -f1)
}

function print_all {

	echo
	echo Raspi Monitor
	echo ---------------
	echo "CPU Temp : $THERM C"
	echo "CPU Speed: $CPU Mhz"
	echo "GPU Speed: $GPU Mhz"
	echo "CPU Volts: $VOLTS V"
	echo "CPU Min  : $MIN Mhz"
	echo "CPU Max  : $MAX Mhz"
	echo --------------
	echo Press Ctrl-C to Exit
	echo

}

while true; do
	get_params
	print_all
	sleep 3
done

exit 0
