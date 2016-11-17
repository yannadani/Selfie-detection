#!/usr/bin/env sh
cd ~/caffe/
./build/tools/caffe train \
    --solver=selfie/alexnetselfie_solver.prototxt \
    --weights=models/bvlc_alexnet/bvlc_alexnet.caffemodel
