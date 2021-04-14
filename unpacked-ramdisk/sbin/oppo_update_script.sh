#!/sbin/sh
para_list=$@

#Symlink funtion
if [ "$1" = "symlink" ]; then
    shift
    link_src=$1
    shift
    for link_dest in "$@"
    do
        if [ ${link_dest:0:1} != "/" ]; then
            echo "link dest path not start with root dir"
            exit 1
        fi

        link_dir=$(dirname ${link_dest})
        rm -rf link_dest
        cd ${link_dir}
        ln -sf ${link_src} ${link_dest}
    done
    exit 0
fi

if [ "$1" = "system_user" ]; then
    user_source=/data/misc/vold/user_keys/test_secret
    user_target=/data/misc/test_secret
    if [ -e $user_source ];then
        mount /dev/block/platform/bootdevice/by-name/system /system_root
        mv $user_source $user_target
        chmod 0777 $user_target
        chown 1000:1000 $user_target
        chcon u:object_r:system_data_file:s0 $user_target
        umount /system_root
    fi
    exit 0
fi

#Other fuction
