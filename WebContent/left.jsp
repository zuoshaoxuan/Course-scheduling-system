<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.vo.*, com.dbconn.DBAccess"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title></head>
<style type="text/css">
	body{
	text-align: center;
	}
	img{
	width: 150px;
	height:150px;
	}
	a{
		text-decoration: none;
	}
	details{
		color: blue;
	}
	.font{
	 background:#77ccff;
	}
</style>
<body bgcolor="#C0F6CE" vlink="#627DDF" alink="red">
<div style="width: 200px;height: 20px;"></div>
	<div>
		教师名:
	<font class="font">
	<%
	request.setCharacterEncoding("utf-8");
	Teacher teacher = (Teacher)session.getAttribute("teacher");
	if (teacher.getIsAdmin() == 1) {
		out.print(teacher.getTeacherName() + "管理员老师！");
	}
	else {
		out.print(teacher.getTeacherName() + "老师！");
	}
	
%></font><br>
		教工号:
<font>
	<%
		out.print(teacher.getTeacherId());
	
%></font>
	</div>
	<a href="myinfo.jsp" target="main">我的信息</a><br/>
	<a href="index2.jsp" target="main">我的课表</a><br/>
</body>
</html>