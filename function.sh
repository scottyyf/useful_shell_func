check_para_num()
{
    local num=$1 # 1
    local actual=$2 # $#
    local paras=$3 # $*
    if num -ne actual;then
        enter false state
    fi
    return 0
}

check_cpu()
{
    # ps info
    ps aux --cols 32768|grep -w "process name"| grep -vw grep

    # ps info的第三行cpu%为需求行
    ret=$(echo -e "$ps_info"|grep -w "process name"|awk '{print $3}')

    # 非整数计算
    echo 4.1-3.3|bc
}

get_uptime()
{
    /proc/uptime # 当前启动后运行时间，每个核空闲的总时间(秒)
}

lock_file()
{
    # 每次等待suspend_time,然后尝试lock，失败则sleep对应时间
    # 对于每次获取到lock后，都会hold locktime的时间
    # 如果尝试都locktime时间内，那么将会失败
    lockfile -sleeptime -r retrytime -l lock_time -s suspend_time filename
}

sed_escape()
{
    # 给特殊符号加上\

    echo -e "$sed_var"|sed 's/\([].[\/*?$^]\)/\\\1/g'
}