from django.db import models

class ImageFileName(models.Model):
    name = models.CharField(max_length=100,default=None)

class ImageMaskDetails(models.Model):
	name = models.ForeignKey(ImageFileName,default=None,on_delete=models.PROTECT)
	maskNumber = models.FloatField(null=True)
	algorithm = models.CharField(null=True,max_length=100,default=None,)
	com_x = models.FloatField(null = True)
	com_y =   models.FloatField(null = True)
	timeTakenCPU = models.FloatField(null=True)
	timeTakenHuman = models.FloatField(null=True)

	def __str__(self):
			return str(self.name) +"\t" + str(self.algorithm)

class ImageMaskPreds(models.Model):
	maskKey = models.ForeignKey(ImageMaskDetails,default=None,on_delete=models.PROTECT)
	maskNumber = models.FloatField(null=True)
	lat = models.FloatField(null = True)
	lon = models.FloatField(null = True)
	top_temp = models.FloatField(null = True)
	top_height = models.FloatField(null = True)
	cloud_type = models.TextField(max_length = 100, default = None , null = True)
