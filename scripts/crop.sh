#!/bin/bash

IN="${1}"
OUT="${2}"
BS="${3}"

ORIG_DIM=1440
NEW_DIM=128
SKIP_X=800
SKIP_Y=720

rm -f "${OUT}"
for Y in $(seq ${SKIP_Y} $((${SKIP_Y} + ${NEW_DIM} - 1))); do
    dd if="${IN}" bs=${BS} skip=$((${Y} * ${ORIG_DIM} + ${SKIP_X})) count=${NEW_DIM} status=none >> "${OUT}"
done
