#!/bin/bash

# Path settings
ANDROID_PATH='/storage/sdcard1/DCIM/Camera/'
LOCAL_PATH='/home/fschenkel/Photos/Android/Camera/'

# Get a list of files that don't exist locally
DIFF=($(comm -23 --check-order <(adb shell ls ${ANDROID_PATH} | dos2unix | sort) <(\ls -1 ${LOCAL_PATH} | sort)))

# Ask for confirmation
printf '%s\n' "${DIFF[@]}"
echo "Found ${#DIFF[@]} new files. Do you wish to continue?"
select ANS in "Yes" "No"; do
    case $ANS in
        Yes ) break;;
        No ) exit;;
    esac
done

# Transfer files
CNT=0
LEN=
for FILE in "${DIFF[@]}"
do
    ((CNT++))
    echo -n "$CNT/${#DIFF[@]}: ${FILE} "
    adb pull "${ANDROID_PATH}/${FILE}" "${LOCAL_PATH}"
done

# Done
echo "Done!"
