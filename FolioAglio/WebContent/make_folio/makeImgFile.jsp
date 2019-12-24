<%@page import="javax.imageio.ImageIO"%>

<%@page import="java.awt.image.BufferedImage"%>

<%@page import="java.io.File"%>

<%@page import="file.MakeImgFile"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<%

   request.setCharacterEncoding("utf-8");

   String imgUrl = request.getParameter("imgUrl");
   
   String directory = application.getRealPath("IMG");
    File f = new File(directory);
     if(!f.isFile()){
        if(!f.isDirectory()){
           f.mkdir();
        }
     }
   File currentDir = new File("");
   File saveFilePath =currentDir.getAbsoluteFile();
   String savename = request.getParameter("name");
   
   new MakeImgFile().makePngFile(imgUrl, f, savename);
%>