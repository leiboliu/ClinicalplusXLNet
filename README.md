# Clinical+XLNet
Pretrained XLNet on the whole clinical notes of MIMIC-III

## Pretrained Models
* [**Clinical+XLNet-Base**](https://drive.google.com/drive/folders/14qMYr7Py9KAa7ygvks1NqnOONwLOyYaU?usp=sharing)
* [**Clinical+XLNet-DS-Base**](https://drive.google.com/drive/folders/150X6ff00sJ97CeKEs4zF_sdBpZLHX98K?usp=sharing)

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


