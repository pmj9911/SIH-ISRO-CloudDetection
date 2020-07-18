from django.contrib import admin
from .models import ImageFileName , ImageMaskDetails,ImageMaskPreds
admin.site.register(ImageMaskPreds)
admin.site.register(ImageFileName)
admin.site.register(ImageMaskDetails)