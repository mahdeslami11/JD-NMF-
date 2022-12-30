# Joint Dictionary Learning-based Non-Negative Matrix Factorization for Voice Conversion to Improve Speech Intelligibility After Oral Surgery (TBME 2016)


IEEE Transactions on Biomedical Engineering, 2016


### Introduction
The Joint Dictionary Learning-based Non-Negative Matrix Factorization (JD-NMF) is used for training joint dictionary (source & target) for voice conversion. But this method can also be used in other applications where the two dictionaries have to be aligned. The basic idea is that if two signals are first aligned by some methods (e.g., DTW in speech processing), to reconstruct the coupled training data with shared activation matrix, the learned dictionaries are automatcally forced to couple with each other to minimize the distance (e.g., KL divergence).


For more details and evaluation results, please check out our  [paper](http://ieeexplore.ieee.org/document/7797132/).

![teaser](https://jasonswfu.github.io/JasonFu.github.io/images/Joint_NMF.png)

### Usuage

`Gitsource.list` is the list of source speech files used for training JD-NMF.
`Gittarget.list` is the list of target speech files used for training JD-NMF.
`Gitsource_Test.list` is the list of source speech files used for testing (conversion).

`JDNMF.m`: Convert the source speech files listed in `Gitsource_Test.list` (with spectrogram features) to the `Converted_speech` folder.


`JDNMF_STRAIGHT.m`: Convert the source speech files listed in `Gitsource_Test.list` (with STRAIGHT features) to the `Converted_speech_STRAIGHT` folder. This may perform better, but you have to ask the STRAIGHT code from [here](http://www.wakayama-u.ac.jp/~kawahara/index-e.html).


### Citation

If you find the code and datasets useful in your research, please cite:

    @article{fu2016joint,
      title={Joint Dictionary Learning-based Non-Negative Matrix Factorization for Voice Conversion to Improve Speech Intelligibility After Oral Surgery},
      author={Fu, Szu-Wei and Li, Pei-Chun and Lai, Ying-Hui and Yang, Cheng-Chien and Hsieh, Li-Chun and Tsao, Yu},
      journal={IEEE Transactions on Biomedical Engineering},
      year={2016},
      publisher={IEEE}
    }
    
### Contact

e-mail: jasonfu@iis.sinica.edu.tw or d04922007@ntu.edu.tw

Narges Rezaei is a master's student from South Tehran University

Digital signal processing course

professor Dr.Mande Eslami


Summary by Narges rezaei

VW.H Abstract of the paper The paper focuses on machine learning-based audio transformation techniques to better understand the speech of amputated patients.  Performs outside the mouth.  These articulators are divided into three categories based on movement and anatomy, one category is simple hinged articulators, one category is preset articulators, and the third category is adjustable articulators.  Due to the removal of parts of the patient's speech articulator, the patient's speech may be unclear and it becomes difficult to understand the patient's speech. To overcome this problem, a system is used that can convert the unclear sound of the patient's speech into clear speech.  This method has 75 names.  To design this method, two important points should be considered. The amount of training data may be limited because it is difficult for patients to speak for a long time after the operation.  The method proposed by the article is a new algorithm based on joint dictionary learning of non-negative matrix factorization (JINM).  This method is a set of algorithms for decomposing a matrix into two matrices. The factorization of matrices is usually one-bit and various methods are provided to do it. Compared to normal VC techniques, JD NMT can efficiently and effectively 770  With only a small amount of training data, the experimental results showed that this II-NMF method is a standardized evaluation criterion compared to the transformed speech methods, and this method is more efficient and more effective than the VC method.

