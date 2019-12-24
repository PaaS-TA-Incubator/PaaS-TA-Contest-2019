# -*- coding: utf-8 -*-
import folium
import pandas as pd

import urllib2

import time
import json
import webbrowser
import re
import os
import sys

import datetime

from math import sin,acos,cos,radians

def get_request_url(url):
    req = urllib2.Request(url)
    app_id = "naver API"
    app_secret = "naver API"
    req.add_header("X-NCP-APIGW-API-KEY-ID", app_id)
    req.add_header("X-NCP-APIGW-API-KEY", app_secret)
    
    try:
        response = urllib2.urlopen(req)

        if response.getcode() == 200:
            return response.read().decode('utf-8')
    except Exception as e:
        print(e)
        return None
     
def getGeoData(address):
    base = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode"
    
    parameters = ""
    
    parameters = "?query=%s" % urllib2.quote(address)

    url = base + parameters
    
    retData = get_request_url(url)
    if retData == None:
        return None

    jsonAddress = json.loads(retData)

    print(jsonAddress['addresses'])
    if 'addresses' in jsonAddress.keys():
        if jsonAddress['addresses']:
            latitude = jsonAddress['addresses'][0]['y']
            longitude = jsonAddress['addresses'][0]['x']
        else:
            return None
    else:
        return None

    return [latitude, longitude]

def calc_distance(my_location,target_location):
    return 6371 * acos(cos(radians(my_location[0])) * cos(radians(target_location[0])) * cos(radians(target_location[1]) - radians(my_location[1])) + sin(radians(my_location[0])) * sin(radians(target_location[0])))

def draw_marker(date,now,schedule,pop_up,row,csv):
    if date <= 4:
        h = re.findall(r"\d+",str(csv[pop_up]))
        if h!=[]:
            start = h[0]+""+h[1]
            end =  h[2]+""+h[3]
            if now >= int(start) and now <= int(end) :
                return "의원명 : " + row["의원명"] + "<br>대표전화 : " + row["대표전화"] + "<br>" + pop_up + ":"+ row[pop_up]
            return
        return
    return

def to_date(date,flag):
    if flag==1:
        return date
    if date <= 4:
        return 0
    elif date == 5:
        return 1
    elif date == 6:
        return 2
    else:
        return 3
    
def to_time(current_time,target_time):
    h = re.findall(r"\d+",str(target_time))
    if h!=[]:
        start = h[0]+""+h[1]
        end =  h[2]+""+h[3]
        if current_time >= int(start) and current_time <= int(end):
            return True
    else:
        return False
    
def makemap_main(address = "서울시", radius = 1.0):
    
    # 현재 요일
    date = time.localtime()
    date = date.tm_wday
    
    # 현재 시각
    now = datetime.datetime.now()
    now = int(now.hour) * 100 + int(now.minute)
    
    # 반경 값

    
    # 현재 위치
    #address = "서울시"
    #address = address.decode('cp949').encode('utf-8')
   
    current_location = getGeoData(address)
    current_location[0] = float(current_location[0])
    current_location[1] = float(current_location[1])
    
    #print address.decode('cp949').encode('utf-8')

    
    # 지도 데이터
    map = folium.Map(location=current_location, zoom_start=15)
    colormap = ["red","blue","yellow","black","green","pink"]

    # csv file 경로 얻기
    
    
    #csv_list = os.listdir("./")
    #csv_list = [idx for idx in csv_list if 'csv' in idx]
    
    
    #csv dataframe 으로 불러오기
    hospital = pd.DataFrame.from_csv('hospital.csv', encoding='CP949', index_col=0, header=0)
    hospital_type = list(hospital[u"업무구분"].unique())
    hospital_date = [u"평일 진료",u"토요일 진료",u"일요일 진료",u"공휴일 진료"]
    
    pharmacy = pd.DataFrame.from_csv('pharmacy.csv', encoding='CP949', index_col=0, header=0)
    pharmacy_date = [u"월요일 운영",u"화요일 운영",u"수요일 운영",u"목요일 운영",u"금요일 운영",u"토요일 운영",u"일요일 운영",u"공휴일 운영",]
    
    
    
    for index , row in hospital.iterrows():
        geoData = []
        geoData.append(row[u"위도"])
        geoData.append(row[u"경도"])
        
        distance = calc_distance(current_location,geoData)
        print(distance)
        if geoData != None and distance < radius:
            pop_up = u"의원명 : " + row[u'의원명'] + u"<br>대표전화 : " + row[u'대표전화']
            if to_time(now,row[hospital_date[to_date(date,0)]])==True:
                pop_up = pop_up + "<br>" +  hospital_date[to_date(date,0)] + row[hospital_date[to_date(date,0)]]
                pop_up = pop_up + '<br><form action="#"><input type="submit" value="submit"></form>'
                for i in hospital_type:
                    if i==row[u"업무구분"]:
                        folium.Marker(geoData,popup=pop_up,icon=folium.Icon(icon="plus", color=colormap[hospital_type.index(i)])).add_to(map)
    
    for index , row in pharmacy.iterrows():
        geoData = []
        geoData.append(row[u"위도"])
        geoData.append(row[u"경도"])

        distance = calc_distance(current_location,geoData)
        
        if geoData != None and distance < radius:
            pop_up = u"약국명 : " + row[u'약국명'] + u"<br>대표전화 : " + row[u'대표전화']
            if to_time(now,row[pharmacy_date[to_date(date,1)]])==True:
                pop_up = pop_up + "<br>" +  pharmacy_date[to_date(date,1)] + row[pharmacy_date[to_date(date,1)]]
                pop_up = pop_up + '<br><form action="#"><input type="submit" value="submit"></form>'
                folium.Marker(geoData,popup=pop_up,icon=folium.Icon(icon="minus",color=colormap[5])).add_to(map)
    #http:///home/vcap/app/
    #"/home/vcap/app/total.html"
    
    
    svFilename = '/home/vcap/app/static/templates/total.html'
    map.save(svFilename)
    
    return os.getcwd()

