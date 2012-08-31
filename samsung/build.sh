#!/bin/bash

# Common defines
txtrst='\e[0m'  # Color off
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue

echo -e "${txtylw}##############################################"
echo -e "${txtylw}#                                            #"
echo -e "${txtylw}#           COLLECTIVE BUILDSCRIPT           #"
echo -e "${txtylw}# Follw us on twitter @CollectiveAndroidDevs #"
echo -e "${txtylw}#                                            #"
echo -e "${txtylw}##############################################"
echo -e "\r\n ${txtrst}"

# Starting Timer
START=$(date +%s)
DEVICE="$1"
ADDITIONAL="$2"
THREADS=`cat /proc/cpuinfo | grep processor | wc -l`

# Device specific settings
case "$DEVICE" in
	captivatemtd)
		board=aries
		lunch=aocp_captivatemtd-userdebug
		brunch=aocp_captivatemtd-userdebug
	;;
	galaxysmtd)
		board=aries
		lunch=aocp_galaxysmtd-userdebug
		brunch=aocp_galaxysmtd-userdebug
		;;
        d2att)  
                board=msm8690
                lunch=aocp_d2att-userdebug
                brunch=aocp_d2att-userdebug
                ;;
        infuse4g)
                board=aries
                lunch=aocp_infuse4g-userdebug
                brunch=aocp_infuse4g-userdebug
                ;;
	maguro)
		board=tuna
		lunch=aocp_maguro-userdebug
		brunch=aocp_maguro-userdebug
		;;
        quincyatt)
                board=msm8660
                lunch=aocp_quincyatt-userdebug
                brunch=aocp_quincyatt-userdebug
                ;;
        toro)
                board=tuna
                lunch=aocp_toro-userdebug
                brunch=aocp_toro-userdebug
                ;;
	*)
		echo -e "${txtblu}Usage: $0 DEVICE ADDITIONAL"
		echo -e "Example: ./build.sh captivatemtd"
		echo -e "Example: ./build.sh captivatemtd kernel"
		echo -e "Supported Devices: captivatemtd, quincyatt, galaxysmtd, d2att, infuse4g, maguro, toro${txtrst}"
		exit 2
		;;
esac

# Setting up Build Environment
echo -e "${txtgrn}Setting up Build Environment...${txtrst}"
. build/envsetup.sh
lunch ${lunch}

# Start the Build
case "$ADDITIONAL" in
	kernel)
		echo -e "${txtgrn}Building Kernel...${txtrst}"
		cd kernel/samsung/${board}
		./build.sh "$DEVICE"
		cd ../../..
		echo -e "${txtgrn}Building Android...${txtrst}"
		brunch ${brunch}
		;;
	*)
		echo -e "${txtgrn}Building Android...${txtrst}"
		brunch ${brunch}
		;;
esac

END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n" $E_SEC
