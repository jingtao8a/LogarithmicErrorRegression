#!/bin/bash

# 切换到脚本所在目录的上级目录，确保路径正确
root_dir=$(cd `dirname $0`/..; pwd)
exec=${root_dir}/LogarithmicErrorRegression/bin/benchmark

# 数据文件路径（保持不变）
data_path=/home/chengang/chengang/jingtao8a/reconstruct_NFL/data/longitudes_200M_double.bin

# 循环参数配置
start_num=10000       # 起始值
end_num=100000000     # 终止值
step=1000             # 每次增加的步长

# 检查可执行文件是否存在（增加健壮性）
if [ ! -x "${exec}" ]; then
    echo "错误：可执行文件 ${exec} 不存在或无执行权限！"
    exit 1
fi

# 检查数据文件是否存在
if [ ! -f "${data_path}" ]; then
    echo "错误：数据文件 ${data_path} 不存在！"
    exit 1
fi

# 执行循环（使用for循环，兼容bash的大数值处理）
# 注意：从10000到1亿，步长1000，总共99991次循环，执行时间会很长！
for (( num=start_num; num<=end_num; num+=step )); do
    # 打印当前执行的命令（便于调试和日志查看）
    echo "当前执行：${exec} ${data_path} ${num}"
    # 执行目标程序，并捕获执行状态
    ${exec} ${data_path} ${num}

    # 可选：检查程序是否执行成功，失败则打印提示并继续（避免循环中断）
    if [ $? -ne 0 ]; then
        echo "警告：num=${num} 时程序执行失败！继续下一轮..."
    fi

    # 可选：添加短暂休眠（避免CPU/IO过载，根据需要调整或注释）
    # sleep 0.1
done

echo "所有循环执行完成！"