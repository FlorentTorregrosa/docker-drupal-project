#!/bin/sh

exec varnishd \
     -F \
     -f $VCL_CONFIG \
     -s malloc,$CACHE_SIZE \
     $VARNISHD_PARAMS
