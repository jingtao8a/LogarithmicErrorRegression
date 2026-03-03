#!/bin/bash

root_dir=$(cd `dirname $0`/..; pwd)
exec=${root_dir}/LogarithmicErrorRegression/bin/benchmark

data_path=/home/chengang/chengang/jingtao8a/reconstruct_NFL/data/longitudes_200M_double.bin
num=300000

echo "${exec} ${data_path} ${num}"
${exec} ${data_path} ${num}
