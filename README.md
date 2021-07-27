# Demosaicing with Linear Regression #


## Setup Instructions for MATLAB

1.  The project was completed in MATLAB, Please download MATLAB from the following link https://www.mathworks.com/downloads/ 

2.  The Image Processing Toolbox was used inorder to reshape the image into columns (to reduce multiplication cost), please install this as well

3.  Clone this repository 


## Repository Structure Breakdown

This section is a breakdown of the Repository for a new user of the program to understand and navigate through it. The next section will discuss how to run the actual program. The Project 2  `src` Folder will have the structure as shown in the picture below.

![image](https://user-images.githubusercontent.com/40211117/127084882-3d892feb-43cf-4686-aa59-eaa64c875d3d.png)

Below is a quick breakdown of what is inside the `src` folder.
  - `coefficent_generation.m`
    - This is the training component of the MATLAB program. The coefficent matrices generation are generated after training on a seperate image. 
  - `linear_regression.m`
    - This is the training component of the MATLAB program. The coefficent matrices generation are generated after training on a seperate image. 
    
  - `ground.jpeg`
    - This is the input image for the Coefficent Matrices Generation.
  
  - `trees.jpeg`
    - This is another input image for the Coefficent Matrices Generation.
   
  - `lighthouse.png`
    - This is the input image for the linear regression demosaicing program.

Below are the images produced after running the `linear_regression.m` file

  - `CompleteImage.png`
    - This is the resulting image from the linear regression demosaic program. 

  - `DemosaicMatlab.png`
    - This is the resulting image from MATLAB's demosaic function. 


## How to Run the Program

All the user needs to do is specify the input images, and first run `coefficent_generation.m` then `linear_regression.m`. Simple instructions on how to do this are given below:

1.	By default, the program assumes that the input images are called `ground.jpeg` and `lighthouse.jpeg` . The input images can be changed in two easy ways:

      1. Re-name the images you want to input to the names specified above. 

      2. Or, open `coefficent_generation.m` and `linear_regression.m`  and edit `line 5` and `line 4` respectively. Then simply just change the name to whatever the image is called in the string.
 
2.	To run the program now, first run `coefficent_generation.m` then `linear_regression.m` in MATLAB.
    When the program finishes executing you will see the MSE calculated to compare our result to Matlab's native implementation of the demosaicking algorithm
    
3.	The resulting demosaiced images will be written and located in the `src` folder. Refer back to the Repository Break Down Section if more detail is needed on how the Program works. 

4.	Repeat from Step 1 with a new Input Image. Enjoy!
