<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>switch_class.jsp</title>
</head>
<body>
<%
	String classId = request.getParameter("classId");
	session.setAttribute("classId", classId);
%>
<jsp:forward page="index2.jsp"/>
</body>
</html>