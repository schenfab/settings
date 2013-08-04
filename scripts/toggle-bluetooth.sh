#!/bin/bash

ENABLED=$(grep -c "enabled" /proc/acpi/ibm/bluetooth)

[[ $ENABLED -eq 0 ]] && sudo sh -c 'echo "enable"  > /proc/acpi/ibm/bluetooth'
[[ $ENABLED -eq 1 ]] && sudo sh -c 'echo "disable" > /proc/acpi/ibm/bluetooth'
