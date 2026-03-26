#!/bin/bash

# 切换到脚本所在目录的上级目录，确保路径正确
root_dir=$(cd `dirname $0`/..; pwd)
exec=${root_dir}/LogarithmicErrorRegression/bin/benchmark
#fb_200M_double.bin
# 数据文件路径（保持不变）
data_name=fb_200M_double
data_path=/home/chengang/chengang/jingtao8a/reconstruct_NFL/data/${data_name}.bin
num=2000000

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

${exec} ${data_path} ${num}
mv ${root_dir}/LogarithmicErrorRegression/results/benchmark.csv ${root_dir}/LogarithmicErrorRegression/results/${data_name}_benchmark_${num}.csv