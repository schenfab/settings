#!/bin/bash

# Path settings
ANDROID_PATH='/storage/sdcard1/DCIM/Camera/'
LOCAL_PATH='/home/fschenkel/Photos/Android/Camera/'

# Wait until a device is connected
echo -n "Waiting for device... "
adb wait-for-device > /dev/null
[[ $? -ne 0 ]] && echo "No device could be found!" && exit
echo "Device found!"

# Get a list of files that don't exist locally
DIFF=($(comm -13 --check-order <(adb shell ls ${ANDROID_PATH} | dos2unix | sort) <(\ls -1 ${LOCAL_PATH} | sort)))

# Exit if list is empty
[[ ${#DIFF[@]} -eq 0 ]] && echo "Found nothing to do..." && exit

# Ask for confirmation
printf '%s\n' "${DIFF[@]}"
echo "Found ${#DIFF[@]} obsolete files. Do you wish to continue?"
select ANS in "Yes" "No"; do
    case $ANS in
        Yes ) break;;
        No ) exit;;
    esac
done

# Delete files
CNT=0
for FILE in "${DIFF[@]}"
do
    ((CNT++))
    echo "$CNT/${#DIFF[@]}: ${FILE}"
    display -resize 1024x768 "${LOCAL_PATH}/${FILE}"
    rm -i "${LOCAL_PATH}/${FILE}"
done

# Done
echo "Done!"
