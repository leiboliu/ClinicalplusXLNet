#!/bin/bash
STORAGE_BUCKET={YOUR_GOOGLE_BUCKET_NAME}

DATA_DIR=$STORAGE_BUCKET/data
now=`date +'%Y%m%d%H%M%S'`

python3 data_utils.py \
  --bsz_per_host=64 \
  --num_core_per_host=1 \
  --seq_len=512 \
  --reuse_len=256 \
  --input_glob=${DATA_DIR}/mimiciii_uncased_sentences_preprocessed_total.txt \
  --save_dir=${DATA_DIR}/mimiciii_tfrecord_total_${now}/ \
  --num_passes=5 \
  --bi_data=True \
  --sp_path=./spiece.model \
  --mask_alpha=6 \
  --mask_beta=1 \
  --num_predict=85 2>&1 | tee -a log_${now}.txt
