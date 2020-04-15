<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.dbconn.DBAccess, com.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String courseName = (String)request.getParameter("courseName");
	String weekday = (String)request.getParameter("weekday");
	String classTime = (String)request.getParameter("classTime");
	String classroom = (String)request.getParameter("classroom");
	Teacher teacher = (Teacher)session.getAttribute("teacher");
	String teacherId = Integer.toString(teacher.getTeacherId());
	String classId = (String)session.getAttribute("classId");
	String courseId = "";
	
	
	DBAccess db = new DBAccess();
	boolean flag = true;
	if (db.createConn() == true) {
		String sql = "select * from class_table where weekday = "+weekday+" and classtime = "+classTime+" and classroomid = "+classroom;
		db.query(sql);
		if (db.next()) {
			try {
				flag = false;
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		db.closeRs();
		db.closeStm();
		db.closeConn();
	}
	

	
	if (flag == true) {
%>
<script type="text/javascript">
    //直接弹出，无取消按钮    
	alert("选择成功");
</script>
<%
		//out.println("选择成功！");


	//sql
	if (db.createConn() == true) {
		String sql = "insert into course(coursename, coursetype) values(\'"+courseName+"\', \'1\')";
		db.update(sql);
	}
	db.closeRs();
	db.closeStm();
	db.closeConn();
	
	if (db.createConn() == true) {
		String sql = "select courseid from course where coursename = \'"+courseName+"\'";
		db.query(sql);
		if (db.next()) {
			try {
				courseId = db.getRs().getString(1);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	db.closeRs();
	db.closeStm();
	db.closeConn();
		
	if (db.createConn() == true) {
		String sql = "insert into class_table(classid, weekday, classtime, courseid, classroomid, teacherid) values(\'"+classId+"\',\'"+weekday+"\',\'"+classTime+"\',\'"+courseId+"\',\'"+classroom+"\',\'"+teacherId+"\')";
		db.update(sql);
	}
	db.closeRs();
	db.closeStm();
	db.closeConn();

		response.setHeader("refresh", "0;URL=index2.jsp");
	}
	else {
%>
<script type="text/javascript">
	//直接弹出，无取消按钮    
	alert("你选择的时间或者教室有冲突，请重新选择！");
	function go()
    {
        window.history.go(-1);
    }
    setTimeout("go()",0);
</script>
<%
		//out.println("你选择的时间或者教室有冲突，请重新选择！");
		//response.setHeader("refresh", "3;URL=index2.jsp");
	}
%>
</body>
</html>