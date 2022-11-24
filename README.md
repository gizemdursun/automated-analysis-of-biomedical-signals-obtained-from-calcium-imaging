This repository contains MATLAB code to implement a segmentation and classification-based approach for assembling an automated screening system for the analysis of calcium imaging.  

# Setup

- [Prerequisites](#Prerequisites)
- [Getting started](#getting-started)
    - [Installation](#installation)
    - [Projection](#projection)
    - [Multi-level Thresholding](#Multi-level-Thresholding)
    - [Feature Image Generation](#Feature-Image-Generation)
    - [Preparation of Classification Data](#Preparation-of-Classification-Data)
    - [Classification](#Classification)
- [Any problems?](#any-problems)
- [Finally](#finally)
	
## Prerequisites

Make sure you have the following requirements:

- MATLAB (we used Version of 2022a.)
- Statistics and Machine Learning Toolbox

## Getting Started

Ensure that all required files are added to the MATLAB path and run the function `main.m`

### Installation

To load the calcium imaging video and the .zip file belong to video's ground truth data, run the function `install.m` to ensure that all required files are added to the MATLAB path. We use free softwares named as `ReadImageJROI.m` and `tiffread2.m` written by `Dylan Muir` and `Francois Nedelec` in this part for reading ImageJ binary ROI file format and converting .stk files to .tiff video frames, respectively. We use these video frames for creating the video data.

```matlab
install();
```
### Projection

To convert video to image, run the function `projection.m`

```matlab
projection();
```
### Multi level Thresholding

The segmentation step we will describe here is applied to the images generated by the projection methods to obtain ROIs that could be assigned to individual astrocytes. Multi-level thresholding is implemented to determine the boundaries of each astrocyte. Segmentation metrics including precision and recall are calculated using these boundaries and ground truths to evaluate compatibility of them.

```matlab
mlt();
calcmetrics();
```
### Feature Image Generation

In this part of repository, feature images are created for classification for assembling an automated screening system for the analysis of calcium imaging. Feature images are created from a segmented image obtained after applying MLT. 

```matlab
createfeatimg();
```

### Preparation of Classification Data

This code is used for preparation of classification data. In our work, we used 33 calcium imaging videos and generated `PixDataTrain` and `PixDataTest` to use for training and testing step of classification. You can find the code of this process:

```matlab
[PixDataTrain,PixDataTest] = prepClassData(MethodStr);
```

This repository contains only one example of calcium imaging video. Therefore, we share `PixDataTrain.mat` and `PixDataTest.mat` files obtained from 33 calcium imaging video using with maximum intensity projection. If you implement the classification process, you have to load these files.

```matlab
load('PixDataTrain.mat')
load('PixDataTrest.mat')
```

### Classification

To classify the training data, run `classificationLearner` app in the Statistics and Machine Learning Toolbox on MATLAB. If you want to open this app, you can click the app icon on the Apps tab under Machine Learning or you can write classificationLearner on MATLAB command prompt.

```matlab
classificationLearner
```

After open the app, you can click the new session for selecting the training data.

Table 1. Classification Methods
Support Vector Machines	k- Nearest Neighbors 	Ensemble	Decision Trees
Linear SVM	Fine k-NN	Boasted Trees 	Fine Tree
Quadratic SVM	Medium k-NN	Bagged Trees 	Medium Tree
Cubic SVM	Coarse k-NN	Subspace Discriminant	Coarse Tree
Fine Gaussian SVM	Cosine k-NN	Subspace k-NN	
Medium Gaussian SVM	Cubic k-NN	RUSBoosted Trees	
Coarse Gaussian SVM	Weighted k-NN		



## Any problems?

If you have any trouble using this code, report any bugs, or want to request a feature please use the [GitHub issues](https://github.com/gizemdursun/automated-analysis-of-biomedical-signals-obtained-from-calcium-imaging/issues).

## Finally

This repository is an example implementation of our paper. In our work, we use totally 33 (21 ALS & 12 CTRL) calcium imaging videos. All results are submitted. This repository 
