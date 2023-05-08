#!/bin/sh

KERNELS="$(vkpurge list)"
[ "$(echo "$KERNELS" | wc -l)" -gt 2 ] &&
    vkpurge remove "$(echo "$KERNELS" | head -n -2 | tr '\n' ' ')"
