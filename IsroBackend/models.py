from django.db import models

class ImageFileName(models.Model):
    name = models.CharField(max_length=100,default=None)

class ImageMaskDetails(models.Model):
	name = models.ForeignKey(ImageFileName,default=None,on_delete=models.PROTECT)
	label = models.IntegerField(null=True)
	avg_x = models.FloatField(null = True)
	avg_y = models.FloatField(null = True)
	mass = models.IntegerField(null=True)
	major_minor = models.FloatField(null = True)
	com_x = models.FloatField(null = True)
	com_y =   models.FloatField(null = True)

	def __str__(self):
			return str(self.label) +"\t" + str(self.avg_x) + "\t" + str(self.avg_y)

class ImagePreds(models.Model):
	# pix_x = models.FloatField(null = True)
	pix_y = models.FloatField(null = True)
	lat = models.FloatField(null = True)
	lon = models.FloatField(null = True)
	top_temp = models.FloatField(null = True)
	top_height = models.FloatField(null = True)
	cloud_type = models.TextField(max_length = 100, default = None , null = True)
