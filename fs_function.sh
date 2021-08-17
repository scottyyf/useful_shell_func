# 磁盘的问题，首先查当前系统中的各种设备的marjor id，/proc/devices
# 然后根据不同类型的设备，和当前查找的设备major一一比对

# sed 中group \( \)，单引号且变量也是单引号
# 设备号 major, minor
get_major()
{
    local device="$1"
    local type="$2"
    echo -e "$device"|sed -n 's&\s*\([0-9]\+\)\s\+'$type'&\1&p' # 取括号中的数字
}

get_major "$device" device-mapper # get mapper device,eg lvm multipath

# device的id, MAJOR 和 MINOR
get_dev_id()
{
    ls -lL $device
    devno=$(echo -e $ret|awk '{print $5,$6}'|sed 's/, /:/g')
}


# 运算 $((+-*%))
# ${para:-word} //para为空或不存在返回word的值,para不变
# ${para-word} // para不存在才返回word，否则返回para
# ${para:=word} //para为空或不存在则直接赋值
# ${para=word} //para不存在才赋值
# doc https://www.ibm.com/docs/en/zos/2.4.0?topic=descriptions-sh-invoke-shell
# /proc/uptime para1: 启动运行时间， para2:启动后服务器空闲时间
is_timeout()
{
    local timeout=${xx:=15} # 未定义则赋值
    local last_time=$(cat file_with time)
    local now_time=$(get_uptime)
    if [ $(($now_time-$last_time)) -gt $timeout ];then
        return 0
    fi
}

#
device_match()
{
    # remove last /
    # if deva == devb return
    # if dev startswith UUID,then dev=/dev/disk/by-uuid/UUID
    # if dev is not block dev ,return
    # at last check dev id
    return 1
}

is_mpoint()
{
    cat /proc/mounts |awk AREA|sort|uniq
    for x in last_ret;do
        if x equal compare_point: return True
    done
    reutrn False
}

# let /dev/mapper/mpatha to sg device , ex /dev/sg1
get_sg_device()
{
    # mapper to sd device,
    # 获取mapper的majorid minid， use: ls -lL
    devno=$(get_dev_id $dev)

    # 遍历device,如果majorid 和当前系统的get_mojor返回的类型进行一一比对，如果是DM_major
    bdevs=$(ls /sys/block/dm-$minor/slaves/) # 返回sda2类的分区
    #

    # cat /sys/block/sda/device/generic/dev 返回21:0 (类型:diskid)
    echo /dev/sg$num
}

