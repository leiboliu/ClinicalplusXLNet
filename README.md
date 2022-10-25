# Clinical+XLNet
Pretrained XLNet on the whole clinical notes of MIMIC-III

## Pretrained Models
* [**Clinical+XLNet-Base**](https://unsw-my.sharepoint.com/:f:/g/personal/z5250377_ad_unsw_edu_au/Enw5NPgF2kFGrgqeE0LJLgABUKflITL9POL64S4uM7wJfg?e=IbyaNa)
* [**Clinical+XLNet-DS-Base**](https://unsw-my.sharepoint.com/:f:/g/personal/z5250377_ad_unsw_edu_au/Enw5NPgF2kFGrgqeE0LJLgABUKflITL9POL64S4uM7wJfg?e=IbyaNa)

## How to pretrain XLNet
### Prerequisites
The pretraining is based on the original implementation of **XLNet**. Please download 
the source code from [here](https://github.com/zihangdai/xlnet).

Our pretraining was initialized from the checkpoint of [XLNet-Base](https://storage.googleapis.com/xlnet/released_models/cased_L-12_H-768_A-12.zip).

### Steps
1) Dump MIMIC-III data into Postgres database
2) Prepare the training data of sentences from the whole clinical notes of MIMIC-III
3) Download the checkpoint of [XLNet-Base](https://storage.googleapis.com/xlnet/released_models/cased_L-12_H-768_A-12.zip)
4) Generate TF records from the training data
5) Pretrain XLNet on tfrecords data.


