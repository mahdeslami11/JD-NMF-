# Joint Dictionary Learning-based Non-Negative Matrix Factorization for Voice Conversion to Improve Speech Intelligibility After Oral Surgery (TBME 2016)


IEEE Transactions on Biomedical Engineering, 2016


### Introduction
The Joint Dictionary Learning-based Non-Negative Matrix Factorization (JD-NMF) is used for training joint dictionary (source & target) with an application in voice conversion. But this method can be used in other applications where the two dictionaries have to be aligned. The basic idea is that if two signals are aligned by some method (e.g., DTW in speech), to reconstruct the coupled training data with shared activation matrix, the learned dictionaries are automatcally forced to couple with each other to minimize the distance (e.g., KL divergence).


For more details and evaluation results, please check out our  [paper](http://ieeexplore.ieee.org/document/7797132/).

![teaser](https://jasonswfu.github.io/JasonFu.github.io/images/Joint_NMF.png)

### Usuage

`JDNMF.m`: convert the source speech files listed in Gitsource_Test.list with spectrogram features to the Converted_speech folder.


`JDNMF_STRAIGHT.m`: convert the source speech files listed in Gitsource_Test.list with STRAIGHT features to the Converted_speech_STRAIGHT folder. This may perform better, but you have to ask the code from [here](http://www.wakayama-u.ac.jp/~kawahara/index-e.html).

