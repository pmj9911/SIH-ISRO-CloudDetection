from BackgroundJobs.Step1Mask.step1 import step1
from IsroBackend.models import ImageFileName, ImageMaskDetails

def loadImage():
	step1Directory = "BackgroundJobs/Step1Mask/"
	# ------------------------------------------------------------------
	# loading the next file
	f = open(step1Directory + "currentImage.txt","r")
	i = f.read()
	fileName = "satellite" + i + ".jpg"
	step1MaskImageName =step1Directory + "step1ImageInput/"+ fileName
	i = (int(i) +1)%45 + 1
	# print(i,str(i))
	f.close()
	# increasing the filename by 1 to get the next file in the next iteration
	f = open(step1Directory + "currentImage.txt","w")
	f.write(str(i))
	f.close()
	# ------------------------------------------------------------------
	# create an entry of the file if it does not exist

	# which algorithm is used?
	algorithm = ["K-Means", "Mask RCNN"]
	currentAlgorithm = algorithm[1]
	
	currentImage, created = ImageFileName.objects.get_or_create(name=fileName)
	print(created)
	# created = True#for testing only
	# ------------------------------------------------------------------
	if created:
		step1(step1MaskImageName,currentAlgorithm)
		# --------------------------------------------------------------
		f = open(step1Directory + "step1MaskOutputs.txt","r")
		lines = f.readlines()
		for line in lines:
			k,com_x,com_y = line.split(" ")
			print(k,com_y,com_x,"-------------")
			currentMask, maskCreated = ImageMaskDetails.objects.get_or_create(name=currentImage,maskNumber=k,algorithm=currentAlgorithm,com_x=com_x,com_y=com_y)

			print("created",k) if maskCreated else print("already done")
		# --------------------------------------------------------------
		# print(resultStep1)
		print("Mask of ",fileName," has been generated")
	else:
		print("Image ",fileName," is already processed")

def updateDetails():
	loadImage()
	print("details will be updated here")