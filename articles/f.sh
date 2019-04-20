#!bin/sh
for file in ./*
do
    if test -f $file
    then
        echo $file
    else
        echo 'shit'
    fi
done
