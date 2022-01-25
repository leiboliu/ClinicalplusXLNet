#!/bin/bash
STORAGE_BUCKET={YOUR_GOOGLE_BUCKET_NAME}

TPU_NAME={YOUR_TPU_NAME}
MODEL_DIR=$STORAGE_BUCKET/model
DATA_DIR=$STORAGE_BUCKET/data

now=`date +'%Y%m%d%H%M%S'`

python3 train.py \
  --tpu=${TPU_NAME} \
  --record_info_dir=${DATA_DIR}/{tfrecords_path}/tfrecords/ \
  --model_dir=${MODEL_DIR}/{model_name}_${now}/ \
  --init_checkpoint=${MODEL_DIR}/xlnet_cased_L-12_H-768_A-12/xlnet_model.ckpt \
  --train_batch_size=64 \
  --seq_len=512 \
  --reuse_len=256 \
  --mem_len=384 \
  --perm_size=256 \
  --n_layer=12 \
  --d_model=768 \
  --d_embed=768 \
  --n_head=12 \
  --d_head=64 \
  --d_inner=3072 \
  --untie_r=True \
  --ff_activation=gelu \
  --n_token=32000 \
  --mask_alpha=6 \
  --mask_beta=1 \
  --num_predict=85 \
  --num_hosts=1 \
  --num_core_per_host=8 \
  --train_steps=1000000 \
  --warmup_steps=40000 \
  --iterations=500 \
  --save_steps=50000 \
  --dropout=0.1 \
  --dropatt=0.1 \
  --learning_rate=4e-4 \
  --adam_epsilon=1e-6 \
  --weight_decay=0.01 \
  --uncased=False  2>&1 | tee -a log_train_${now}.txt
