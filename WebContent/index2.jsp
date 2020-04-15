<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.vo.*, com.dbconn.DBAccess"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>首页</title>

<script type="text/javascript">
    function base64 (content) {
       return window.btoa(unescape(encodeURIComponent(content)));         
    }
    /*
    *@tableId: table的Id
    *@fileName: 要生成excel文件的名字（不包括后缀，可随意填写）
    */
    function tableToExcel(tableID,fileName){
        var table = document.getElementById(tableID);
      var excelContent = table.innerHTML;
      var excelFile = "<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:x='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40'>";
      excelFile += "<head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head>";
      excelFile += "<body><table>";
      excelFile += excelContent;
      excelFile += "</table></body>";
      excelFile += "</html>";
      var link = "data:application/vnd.ms-excel;base64," + base64(excelFile);
      var a = document.createElement("a");
      a.download = fileName+".xls";
      a.href = link;
      a.click();
    }
</script>
</head>
<body style="text-align: center;">
	<font size="+3">欢迎您!</font>
<%
	request.setCharacterEncoding("utf-8");
	Teacher teacher = (Teacher)session.getAttribute("teacher");
	if (teacher.getIsAdmin() == 1) {
		out.print(teacher.getTeacherName() + "管理员老师！");
	}
	else {
		out.print(teacher.getTeacherName() + "老师！");
	}
	
%>
<form action="switch_class.jsp" method="post">
	<select name="classId">
<%
	String classId = (String)session.getAttribute("classId");

	DBAccess db = new DBAccess();
	if (db.createConn() == true) {
		String sql = "select classId, className from class_info";
		db.query(sql);
		while (db.next()) {
			try {
				if (db.getRs().getString(1).equals(classId)) {
					out.print("<option value =\"" + db.getRs().getString(1) + "\" selected >" + db.getRs().getString(2) + "</option>");
				}
				else {
					out.print("<option value =\"" + db.getRs().getString(1) + "\">" + db.getRs().getString(2) + "</option>");	
				}
				
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		db.closeRs();
		db.closeStm();
		db.closeConn();
	}
%>

	</select>
	<input type="submit" value="切换">
</form>
<%
	

	ClassTable ct[][] = new ClassTable[5][5];
	for (int i = 0; i < 5; i++) {
		for (int j = 0; j < 5; j++) {
			ct[i][j] = new ClassTable();
		}
	}
	
	
	
	int c = 0;
	int r = 0;
	
	if (db.createConn() == true) {
		String sql = 
			"select className, `weekday`, classTime, courseName, classRoomName, teacherName, buildingRoomName from class_info, class_table, classroom_info, course, teacher_info where class_table.classId = class_info.classId and class_table.courseId = course.courseId and class_table.classRoomId = classroom_info.classRoomId and class_table.teacherId = teacher_info.teacherId and class_table.classId = " + classId;
		db.query(sql);
		while (db.next()) {
			try {
				//out.print("<br>"+ db.getRs().getString(4) +"<br>");
				c = db.getRs().getInt(2);//星期 列 = i - 1
				r = db.getRs().getInt(3);//第几节课 行 = (j - 1)/2
				//out.print("<br>" + "行r = " + (r-1)/2 + ", 列c = " + (c-1) + "<br>");
				int rr = (r - 1)/2;
				int cc = c - 1;
				ct[rr][cc].setClassName(db.getRs().getString(1));
				ct[rr][cc].setWeekday(db.getRs().getString(2));
				ct[rr][cc].setClassTime(db.getRs().getString(3));
				ct[rr][cc].setCourseName(db.getRs().getString(4));
				ct[rr][cc].setClassRoomName(db.getRs().getString(5));
				ct[rr][cc].setTeacherName(db.getRs().getString(6));
				ct[rr][cc].setBuildingRoomName(db.getRs().getString(7));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();			
			}
		}
		db.closeRs();
		db.closeStm();
		db.closeConn();
	}
%>
<table border="1" id="item" style="text-align: center; width:800px; margin-left: 18%;">
	<tr>
		<td colspan="2">节次</td>
		<td style="width:150px;">星期一</td>
		<td style="width:150px;">星期二</td>
		<td style="width:150px;">星期三</td>
		<td style="width:150px;">星期四</td>
		<td style="width:150px;">星期五</td>
	</tr>
	<tr>
		<td rowspan="4">上午</td>
		<td>第一节</td>
		<%
			for (int i = 0; i < 5; i++) {
				if(ct[0][i].getClassName() != null) {
					out.print("<td rowspan=\"2\">"+ ct[0][i].getCourseName() + ", " + ct[0][i].getBuildingRoomName() + ct[0][i].getClassRoomName() + ", " + ct[0][i].getClassName() + ", 教师：" + ct[0][i].getTeacherName() +"</td>");
				}
				else {
					out.print("<td rowspan=\"2\"></td>");
				}
			}
		%>
	</tr>
	<tr>	
		<td>第二节</td>
	</tr>
	<tr>	
		<td>第三节</td>
		<%
			for (int i = 0; i < 5; i++) {
				if(ct[1][i].getClassName() != null) {
					out.print("<td rowspan=\"2\">"+ ct[1][i].getCourseName() + ", " + ct[1][i].getBuildingRoomName() + ct[1][i].getClassRoomName() + ", " + ct[1][i].getClassName() + ", 教师：" + ct[1][i].getTeacherName() +"</td>");
				}
				else {
					out.print("<td rowspan=\"2\"></td>");
				}
			}
		%>
	</tr>
	<tr>	
		<td>第四节</td>
	</tr>
	<tr>
		<td rowspan="4">下午</td>
		<td>第五节</td>
		<%
			for (int i = 0; i < 5; i++) {
				if(ct[2][i].getClassName() != null) {
					out.print("<td rowspan=\"2\">"+ ct[2][i].getCourseName() + ", " + ct[2][i].getBuildingRoomName() + ct[2][i].getClassRoomName() + ", " + ct[2][i].getClassName() + ", 教师：" + ct[2][i].getTeacherName() +"</td>");
				}
				else {
					out.print("<td rowspan=\"2\"></td>");
				}
			}
		%>
	</tr>
	<tr>
		<td>第六节</td>
	</tr>
	<tr>		
		<td>第七节</td>
		<%
			for (int i = 0; i < 5; i++) {
				if(ct[3][i].getClassName() != null) {
					out.print("<td rowspan=\"2\">"+ ct[3][i].getCourseName() + ", " + ct[3][i].getBuildingRoomName() + ct[3][i].getClassRoomName() + ", " + ct[3][i].getClassName() + ", 教师：" + ct[3][i].getTeacherName() +"</td>");
				}
				else {
					out.print("<td rowspan=\"2\"></td>");
				}
			}
		%>
	</tr>
	<tr>		
		<td>第八节</td>
	</tr>
	<tr>
		<td rowspan="2">晚上</td>
		<td>第九节</td>
		<%
			for (int i = 0; i < 5; i++) {
				if(ct[4][i].getClassName() != null) {
					out.print("<td rowspan=\"2\">"+ ct[4][i].getCourseName() + ", " + ct[4][i].getBuildingRoomName() + ct[4][i].getClassRoomName() + ", " + ct[4][i].getClassName() + ", 教师：" + ct[4][i].getTeacherName() +"</td>");
				}
				else {
					out.print("<td rowspan=\"2\"></td>");
				}
			}
		%>
	</tr>
	<tr>
		<td>第十节</td>
	</tr>
</table>
<br>
<form action="insert_course.jsp" method="post">
	课程名：<input type="text" name="courseName" required="required"> 
	星期：<select name="weekday">
			<option value = "1">星期一</option>
			<option value = "2">星期二</option>
			<option value = "3">星期三</option>
			<option value = "4">星期四</option>
			<option value = "5">星期五</option>
		</select>
	节次：<select name="classTime">
			<option value = "1">一二节</option>
			<option value = "3">三四节</option>
			<option value = "5">五六节</option>
			<option value = "7">七八节</option>
			<option value = "9">九十节</option>
		</select>
	教室：<select name="classroom">
<%
		if (db.createConn() == true) {
			String sql = "select classroomid, classroomname, buildingroomname from classroom_info where isComputerRoom = 1";
			db.query(sql);
			while (db.next()) {
				try {
					out.print("<option value =\"" + db.getRs().getString(1) + "\">" + db.getRs().getString(3) + db.getRs().getString(2) + "</option>");
				}
				catch (Exception e) {
					e.printStackTrace();
				}
			}
			db.closeRs();
			db.closeStm();
			db.closeConn();
		}
%>
		</select>
	<input type="submit" value="提交选课">
</form>

<%
	if (teacher.getIsAdmin() == 1) {
%>

<button type="button" onclick="tableToExcel('item','data')">导出</button>

<%
	}
%>

</body>
</html>