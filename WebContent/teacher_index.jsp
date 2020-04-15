<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.vo.*, com.dbconn.DBAccess"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>欢迎来到排课系统</title>
</head>
<%
 request.setCharacterEncoding("utf-8");
 Teacher teacher = (Teacher)session.getAttribute("teacher");
%>
<frameset border="2" framespacing="1" bordercolor="#66ccff" frameborder="yes">
 <frameset rows="80,*" >
 	<frameset>
 		<frame name="header" src="header.jsp" scrolling="no" marginheight="0px" frameborder="0"/>
 	</frameset>
	<frameset cols="220,*">
		<frame name="left" src="left.jsp" scrolling="auto" target="main" frameborder="1" />
		<frame name="main" src="index2.jsp"scrolling="auto" noresize frameborder="1" />
	</frameset>
</frameset>
	<noframes>
		<body>
			<p>你的浏览器不支持frame标签！！</p>
		</body>
	</noframes>
</frameset>
</html>