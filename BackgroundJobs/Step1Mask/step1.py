import os
def step1(step1MaskImageName,algorithm):
	# Original file name: 3DIMG_07NOV2019_0000_L1C_SGP.tif
	# Converted file name: satellite0.jpg
	print("Step 1: finding Mask!" , algorithm)
	step1MaskFolder = "BackgroundJobs/Step1Mask/"
	# Running the mask RCNN model
	# python3 mask_rcnn_predict.py --weights mask_rcnn_cloud_0009.h5 --labels labels.txt --image satellite2.jpg
	if algorithm == "Mask RCNN":
		step1MaskFileName = step1MaskFolder + "mask_rcnn_predict.py"
		step1WeightsFileName = step1MaskFolder+"mask_rcnn_cloud_0009.h5"
		step1LabelsFileName = step1MaskFolder+ "labels.txt"
		os.system("python3 " + step1MaskFileName + " --weights " + step1WeightsFileName + " --labels "+ step1LabelsFileName + " --image " + step1MaskImageName)
		# saves the output image to the step1ImageOutput folder
		print("MASkRCNN")
	elif algorithm == "K-Means":
		print("Kmeans")
	print("Step1 Finished")