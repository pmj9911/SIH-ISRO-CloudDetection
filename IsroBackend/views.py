from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser,JSONParser
from django.core.serializers.json import DjangoJSONEncoder
import json
import traceback

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
        try:
            jsonresp = {
                "posx":  120,
                "posy":  240,
                "tir1Count": 581.00,
                "cloudy": True,
                "type":  "cumulonimbus",
                "topTemp": '320 K',
                "height":  "120 metres",
            }
            return Response(jsonresp, content_type='application/json')
        except Exception as e:
                traceback.print_exc()
                print(e)
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
        print(posx,"\t",posy,"################")
        jsonresp = {
            'status' : 'Success',
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
            jsonresp = {
                'time_slot' : '07-11-19 00:30 - 01:00',
                'direction' : 'North East',
                'speed' : '50 kpmh',
            }
            return Response(jsonresp, content_type='application/json')
        except Exception as e:
                traceback.print_exc()
                print(e)
                return HttpResponse(status=403)
    def post(self,request):
        return HttpResponse(status=403)
