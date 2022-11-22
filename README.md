# automated-analysis-of-biomedical-signals-obtained-from-calcium-imaging

## Combined segmentation and classification-based approach to automated analysis of biomedical signals obtained from calcium imaging 
#### Gizem Dursun, Dunja Bijelić, Nese Aysit, Burcu Kurt Vatandaslar, Lidija Radenović, Abdulkerim Çapar, Bilal Ersen Kerman, Pavle R. Andjus, Andrej Korenić, Ufuk Özkaya, 2022.

This repository contains MATLAB code to implement a segmentation and classification-based approach for assembling an automated screening system for the analysis of calcium imaging. 

Procedure steps of the proposed approach are shown in below. The entire Ca2+ time-lapse imaging recordings were projected into a single image using different projection 
methods. Segmentation was performed by using a multi-level thresholding, and obtained binary mask was compared to the ground truths. Finally, a new matrix called feature
image was generated from extracted traces and used for assessing classification accuracy of various classifiers.

![image](https://user-images.githubusercontent.com/21240038/203317080-5d839193-fc02-49dc-b5d9-18ba8c68255d.png)

# Setup

- [Prerequisites](#Prerequisites)
- [Getting started](#getting-started)
    - [Installation](#installation)
    - [Projection](#projection)
    - [Multi-level Thresholding](#Multi-level-thresholding)
- [Any problems?](#any-problems)
- [Finally](#finally)
	
## Prerequisites

Make sure you have the following requirements:

- MATLAB R2022a
- Statistics and Machine Learning Toolbox

## Getting Started

### Installation

