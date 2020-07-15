import os
def step1():
	# Original file name: 3DIMG_07NOV2019_0000_L1C_SGP.tif
	# Converted file name: satellite0.jpg

	step1MaskFolder = "BackgroundJobs/Step1Mask/"
	# getting the next file name
	f = open(step1MaskFolder + "currentImage.txt","r")
	i = f.read()
	step1MaskImageName =step1MaskFolder + "step1ImageInput/satellite" + i + ".jpg"
	i = (int(i) +1)
	print(i,str(i))
	f.close()
	# increasing the filename by 1 to get the next file in the next iteration
	f = open(step1MaskFolder + "currentImage.txt","w")
	f.write(str(i))
	f.close()

	# Running the mask RCNN model
	# python3 mask_rcnn_predict.py --weights mask_rcnn_cloud_0009.h5 --labels labels.txt --image satellite2.jpg
	step1MaskFileName = step1MaskFolder + "mask_rcnn_predict.py"
	step1WeightsFileName = step1MaskFolder+"mask_rcnn_cloud_0009.h5"
	step1LabelsFileName = step1MaskFolder+ "labels.txt"
	os.system("python3 " + step1MaskFileName + " --weights " + step1WeightsFileName + " --labels "+ step1LabelsFileName + " --image " + step1MaskImageName)
	# saves the output image to the step1ImageOutput folder

def loadImage():
	step1()
	print("Mask of the new image has been generated")



def updateDetails():
	loadImage()
	print("details will be updated here")