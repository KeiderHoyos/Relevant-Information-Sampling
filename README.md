# Relevant-Information-Sampling
Codes for performing the Relevant Information Sampling approach

In this study, we propose a novel strategy to address the class imbalance issue using a Relevant Information-based sampling approach. In this sense, our RIS methodology employs a principle of relevant information cost function which formulates the sub-sampling issue as a trade-off between the entropy $H_2$ of the sub-sampled version and its descriptive power about the majority class in terms of their relative entropy $D_{CS}$. In other words, RIS approach balances the minimization of redundancy with the distortion between the original data and a compressed version of itself achieved through processing. Also, the RIS approach appear particularly appealing alternatives to capture data structure beyond second order statistics because it computes information theoretic features which quantify more precisely the statistical microstructure of the majority class.

Parameters: 
X      : Majority Class.  
N_size : Samples to select from the majority Class. Generally equal to
the size of the minority class.
lambda : The weighting parameter which combines the regularization and similarity 
terms in appropriate proportion to capture different aspects of the data structure. 
sigma  : The resolution parameter which controls the “scale” of the analysis

Copyright (C) 2018 Automatica Research Group
Keider Hoyos Osorio -Universidad Tecnológica de Pereira 
$Id: ris.m 2018-06-08$
