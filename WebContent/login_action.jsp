<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.vo.Teacher, com.dbconn.DBAccess"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>login_action.jsp</title>
</head>
<body>
<%
	//验证登录
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	DBAccess db = new DBAccess();
	boolean isValid = false;
	Teacher teacher = new Teacher();
	if (db.createConn() == true) {
		String sql = "select * from teacher_info where username='" + username + "'" + "and password='" + password + "'";
		db.query(sql);
		if (db.next()) {
			try {				
				isValid = true;
				teacher.setTeacherId(db.getRs().getInt(1));
				teacher.setTeacherName(db.getRs().getString(2));
				teacher.setUsername(db.getRs().getString(3));
				teacher.setPassword(db.getRs().getString(4));
				teacher.setIsAdmin(db.getRs().getInt(5));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				db.closeRs();
				db.closeStm();
				db.closeConn();
			}
		}
	}
	if(isValid){
		session.setAttribute("teacher", teacher);
		response.setHeader("refresh", "0;URL=teacher_index.jsp");
	}else{
		out.println("您输入的用户名或者密码有误，请重新登录！");
		response.setHeader("refresh", "5;URL=login.jsp");
	}
	
%>
</body>
</html>