# -*- coding: utf-8 -*-
from django.views.generic.base import TemplateView
from django.core.cache import cache
from django.shortcuts import redirect,render
from .makeMap import *

class ResultMap(TemplateView):
    
    template_name = "result.html"
    def dispatch(self, request, *args, **kwargs):
        return super(ResultMap,self).dispatch(request, *args, **kwargs)

    
class TempMap(TemplateView):

    template_name = "/home/vcap/app/static/templates/total.html"
    def dispatch(self, request, *args, **kwargs):
        return super(TempMap,self).dispatch(request, *args, **kwargs)
    
    
class NewMap(TemplateView):
    
    template_name = "result.html"
    def dispatch(self, request, *args, **kwargs):
        #쿠키를 확인하여 로그인되어 있으면 매니지 화면으로 리다이렉트한다.
        mapname = request.POST.get('location')
        mapname = mapname.encode("utf-8")
        map_path = makemap_main(mapname)
        return redirect('/result#services')
        
        
class LoginView(TemplateView):
    def dispatch(self, request, *args, **kwargs):
        #쿠키를 확인하여 로그인되어 있으면 매니지 화면으로 리다이렉트한다.
        if request.method =="POST":
            mapname = request.POST.get('location')
            radius = request.POST.get('radius')
            mapname = mapname.encode("utf-8")
            map_path = makemap_main(mapname,float(radius))
            return render(request,"result.html")
        else:
            return render(request,"index.html")
        return super(LoginView, self).dispatch(request, *args, **kwargs)

        
class openMap(TemplateView):
    
    template_name = "/result"
    
    
        
        
class ManageView(TemplateView):
    
    template_name = "index.html"
    def dispatch(self, request, *args, **kwargs):
        #쿠키를 확인하여 로그인되어 있지 않으면 로그인 화면으로 리다이렉트한다.
        login_cookie = request.COOKIES.get('login_cookie')
        if cache.get(login_cookie)=='admin':
            return super(ManageView, self).dispatch(request, *args, **kwargs)
        else:
            return redirect('/')

class MainView(TemplateView):

    template_name = "index.html"
    def get_context_data(self, **kwargs):
        context = super(MainView, self).get_context_data(**kwargs)
        return context