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
echo -e "${txtylw}#     Follw us on twitter @CollectiveDevs    #"
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
		i777)
				board=smdk4210
				lunch=aocp_i777-userdebug
				brunch=aocp_i777-userdebug
				;;
        	d2att)  
				board=msm8960
				lunch=aocp_d2att-userdebug
				brunch=aocp_d2att-userdebug
				;;
		d2spr)  
				board=msm8960
				lunch=aocp_d2spr-userdebug
				brunch=aocp_d2spr-userdebug
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
        	skyrocket)
                		board=msm8660
                		lunch=aocp_skyrocket-userdebug
                		brunch=aocp_skyrocket-userdebug
                		;;
        	hercules)
                		board=msm8660
                		lunch=aocp_hercules-userdebug
                		brunch=aocp_hercules-userdebug
                		;;
        	jfltetmo)  
                		board=msm8960
                		lunch=aocp_jfltetmo-userdebug
                		brunch=aocp_jfltetmo-userdebug
                		;;   
        	jflteatt)  
                		board=msm8960
                		lunch=aocp_jflteatt-userdebug
                		brunch=aocp_jflteatt-userdebug
                		;;
		t0lteatt)
				board=smdk4412
				lunch=aocp_t0lteatt-userdebug
				brunch=aocp_t0lteatt-userdebug
				;;			   				     
        	toro)
                		board=tuna
                		lunch=aocp_toro-userdebug
                		brunch=aocp_toro-userdebug
                		;;

		p5110)
				board=espresso10
			        lunch=aocp_p5110-userdebug
			        brunch=aocp_p5110-userdebug
			        ;;
	*)
		echo -e "${txtblu}Usage: $0 DEVICE ADDITIONAL"
		echo -e "Example: ./build.sh captivatemtd"
		echo -e "Example: ./build.sh captivatemtd kernel"
		echo -e "Supported Devices: captivatemtd,  galaxysmtd,  i777, d2att, d2spr, infuse4g, maguro, quincyatt, skyrocket, hercules, jfltetmo, jflteatt, t0lteatt, toro, p5110${txtrst}"
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
