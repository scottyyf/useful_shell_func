# load function
for lib in log globals
do
    . path_to_dir/$lib
done

# pipeline

# < file_path 文件做输入
# < < 对多行字符做输入
# <<< 对here string 做输入
## 从echo中来，作为子命令传给后面 echo "show" | ip add
# echo a b |read x y
# here string 提供标准输入。 read x y <<< "a b"


while_read(){
    while read command syscommand
    do
        USE $command $syscommand
    done < <(awk -F= '{print $1, $2} file_path')
}

# IFS 字符分隔符。 IFS="|" read x y z <<<"a|b|c"
split_compare()
{
    local x
    IFS="/" read ip mask nic <<< "$x"
    #
    ip2=$(echo "$x"|awk -F/ '{print $1}')
    mask2=$(echo "$x"|awk -F/ '{print $2}')
    nic2=$(echo "$x"|awk -F/ '{print $2}')
}

# check para 1 is true or false
is_true()
{
    local value=$1
    local lvalue=$(echo "$value"|tr "[a-z]" "[A-Z]")
    if [ "$lvalue" = "YES" -o ... ];then
        return 0
    fi
    return 1
}

# $* $@ 双引号没有使用时，是一样的，使用后$@不变，而$*将 “”中的看做一个字符

# $RANDOM生成随机int数