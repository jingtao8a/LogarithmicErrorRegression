#!/bin/bash

# 切换到脚本所在目录的上级目录，确保路径正确
root_dir=$(cd `dirname $0`/..; pwd)
exec=${root_dir}/LogarithmicErrorRegression/bin/benchmark

# 固定数据量大小
num=90000000

# 定义需要批量执行的数据集列表 ✅
data_name_list=(
    "wiki_ts_200M_double"
)

# 检查可执行文件是否存在
if [ ! -x "${exec}" ]; then
    echo "错误：可执行文件 ${exec} 不存在或无执行权限！"
    exit 1
fi

# 遍历所有数据集 ✅
for data_name in "${data_name_list[@]}"; do
    echo "========================================"
    echo "正在处理数据集：${data_name}"

    data_path=/home/chengang/chengang/jingtao8a/reconstruct_NFL/data/${data_name}.bin

    # 检查数据文件
    if [ ! -f "${data_path}" ]; then
        echo "警告：数据文件 ${data_path} 不存在，跳过！"
        continue
    fi

    # 执行 benchmark
    ${exec} ${data_path} ${num}

    # 重命名并保存结果
    result_src=${root_dir}/LogarithmicErrorRegression/results/benchmark.csv
    result_dst=${root_dir}/LogarithmicErrorRegression/results/${data_name}_benchmark_${num}.csv

    if [ -f "${result_src}" ]; then
        mv ${result_src} ${result_dst}
        echo "✅ 已保存结果：${result_dst}"
    else
        echo "⚠️  未生成 benchmark.csv 文件！"
    fi
done

echo "========================================"
echo "所有数据集执行完成！"
