#!/bin/sh

#How to Find The Kernel Version
#http://www.linfo.org/find_kernel_version.html
uname -r

#cat /proc/version

#iterator the files in a folder
for file in ~/*
  do
    outfile=`basename $file`
    echo file="'$file'" \
    outfile="'$outfile'"
  done

