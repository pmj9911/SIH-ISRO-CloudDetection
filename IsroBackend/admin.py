from django.contrib import admin
from .models import ImageFileName , ImageMaskDetails,ImagePreds
admin.site.register(ImagePreds)
admin.site.register(ImageFileName)
admin.site.register(ImageMaskDetails)