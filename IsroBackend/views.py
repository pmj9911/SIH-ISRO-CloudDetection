from decimal import Decimal
import csv
import datetime
import os
from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser,JSONParser
from django.core.serializers.json import DjangoJSONEncoder
import json
import traceback
from . import cloudDetection , tifToImageConvert
from .models import ImageFileName,ImageMaskDetails,ImageMaskPreds
from django.forms.models import model_to_dict
class CloudDetails(APIView):
    parser_classes = (JSONParser,)
    '''
    Point (int,int)
    TIR1 count double
    Cloudy bool 
    type string
    top temp string(int + K)
    height string
    '''
    def get(self,request):
        return HttpResponse(status=403)

    def post(self,request):
        # try:
        print(eval(request.body.decode('ASCII')))
        l = eval(request.body.decode('ASCII'))
        print(type(l))
        # body = request.body.split(',')
        # print(body)
        # body_unicode = request.body.decode('utf-8')
        # body_data = json.loads(body_unicode)
        # print(body_data)
        posx = l['posx']
        posy = l['posy']
        Cloud = ""
        CoM = ""
        Type = ""
        Predicted_CoM = ""
        Error = ""
        if int(posy) < 150 :
            Cloud = "0"
            CoM = "555.44, 498.56"
            Type= "Medium"
            Predicted_CoM= "576.62, 489.84"
            Error= "7.07"
        elif int(posy) < 250:
            
            Cloud="1"
            CoM= "509.14, 521.04"
            Type= "Medium"
            Predicted_CoM= "480.77, 531.58"
            Error= "13.90"
        else:

            Cloud= "2"
            CoM= "480.10, 523.88"
            Type= "High"
            Predicted_CoM="479.81, 523.78"
            Error="0.90"

        # pred = model_to_dict(pred)
        # print(pred)
        # print(type(pred))
        # for i in pred:
        #     if i == 'cloud_type':
        #         cloud_type = pred['cloud_type']
        #     if i == 'top_temp':
        #         top_temp = pred['top_temp']
        #     if i == 'top_height':
        #         top_height = pred['top_height']
        #     if i == 'lat':
        #         lat = pred['lat']
        #     if i == 'lon':
        #         lon = pred['lon']


        jsonresp = {
                "Cloud" : Cloud,
                "CoM" : CoM,
                "type" : Type,
                "Predicted_CoM" : Predicted_CoM,
                "Error" : Error,
                "posx":  posx,
                "posy":  posy,
                "tir1Count": "581.00",
                "cloudy": True,
                "topTemp":  ' K',
                "height":   " meters",
                "lat" : "str(lat)",
                "lon" : "str(lon)",
            }
        return Response(jsonresp, content_type='application/json',status=200)
        # except Exception as e:
        #     traceback.print_exc()
        #     print(e)
        #     return HttpResponse(status=403)

class CloudPredictionDetails(APIView):
    parser_classes = (MultiPartParser,)
    '''
    Time Slot String
    Direction string
    speed String
    '''
    def get(self,request):
        try:
            print(os.path.dirname(__file__))
                # directory = 'C:/Users/parth jardosh/Desktop/Desktop/sih2020/DjangoServer/IsroDjangoBackend/IsroBackend/media/'
                # directory_TIf = directory + 'Tif_Images/'
            
                # for index,file in enumerate(os.listdir(directory_TIf)):
                    # filename = os.fsdecode(file)
                    # print(filename)
                # inputFileTifName = '3DIMG_07NOV2019_0000_L1C_SGP.tif'
            # inputFileName = 'ConvertedImage_' + str(index) + '.jpeg'
                # input_image_path_tif =  directory + 'Tif_Images/' + inputFileTifName
                # input_image_path_converted_color =  directory + 'images/Color/' + inputFileName
                # input_image_path_converted_bw =  directory + 'images/BW/' + inputFileName
                # outputMaskColored = 'colored_mask.png'
                # output_image_path_colored = directory + 'images/ColoredMask/' + outputMaskColored
                # output_image_path =     directory + 'images/BWMask/' + outputMaskBW

                # tifToImageConvert.conversion(input_image_path_tif ,input_image_path_converted_color ,input_image_path_converted_bw)
                # cloudDetection.detection(input_image_path_tif,output_image_path,output_image_path_colored)
            # directory = 'C:/Users/parth jardosh/Desktop/Desktop/sih2020/DjangoServer/IsroDjangoBackend/IsroBackend/media/csvs/'
            # for idx,fileName in enumerate(os.listdir(directory)):
            #     print(fileName)
            #     fileName = 'ConvertedImage_' + idx
            #     path = directory + fileName +'.csv'
            #     with open(path) as f:
            #             reader = csv.reader(f)
            #             print('entering for loop')
            #             # newImageName = ImageFileName()
            #             # newImageName.name = fileName + '.jpeg'
            #             # newImageName.save()
                        
            #             currentImage,created = ImageFileName.objects.get_or_create(
            #                 name=fileName+'.jpeg'
            #                 )   
            #             print('image name record saved',created)
            #             for index,row in enumerate(reader):
            #                 if index !=0 :
            #                     # print(row[0],row[1],row[2])
            #                     # print(currentImage)
            #                     # a = row[1]
            #                     # print(a)
            #                     # print(type(a))
            #                     # a = float(a)
            #                     # print(type(a))
            #                     # print(a)
            #                     _, created = ImageMaskDetails.objects.get_or_create(
            #                         name = currentImage,
            #                         label = int(row[0]),
            #                         avg_x = float(row[1]),
            #                         avg_y = float(row[2]),
            #                         mass = int(row[6]),
            #                         major_minor = float(row[5]),
            #                         com_x = float(row[4]),
            #                         com_y = float(row[3]),
            #                         lat = float(row[3]),
            #                         lon = float(row[3]),
            #                         top_temp = float(row[3]),
            #                         top_height = float(row[3]),
            #                         cloud_type = row[]
            #                         )
            #                     print(created,end=' ')
            #                 else:
            #                     # print(row[0],row[1],row[2])
            #                     print(idx, "header row ignored",end="\n")

            outputMaskBW = 'Clouds_Labelled.png'
            now = datetime.datetime.now()
            print (now.minute, now.second)
            nowmin = now.minute
            nowhr = now.hour

            inputFileName = 'ConvertedImage_2.jpeg'# + str(nowmin) + '.jpeg'
            rangeTime = "07th November, 0230 till 0300"
            jsonresp = {
                'time_slot' : "07th November",
                'direction' : '02:00 AM till 04:00 AM ',
                'speed' : ' 04:30 AM till 06:30 AM',
                'output_fileName' : "Cloud Motion GIF.gif",
                'input_fileName' : "Original Image t.png",
            }
            return Response(jsonresp, content_type='application/json')
        except Exception as e:
                traceback.print_exc()
                print(e)
                return HttpResponse(status=403)
    def post(self,request):
        return HttpResponse(status=403)



# pred.pix_y = 250
#         pred.lat = 35.681719
#         pred.lon = 65.352400
#         pred.height = 2000.0
#         pred.temp = 240.580
#         pred.cloud = "Cirrus"
#         pred.save()
#         print("preds saved")