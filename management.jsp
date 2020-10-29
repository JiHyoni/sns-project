<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" 
import="mysns.sns.*,mysns.member.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Management</title>
</head>
<body>
<H2>관리자 - 회원목록 </H2>
<HR>
<style>
  table {border: 2px double pink; width:500px}
  td,th{border:1px pink solid ; text-align: center; padding:5px}
</style>
<table border="1">
<th>아이디</th><th>이름</th><th>이메일</th><th>생년월일</th>
<% 	ArrayList<Member> manage = new MemberDAO().getManage(); 
	for(Member m : manage){%>
		<tr>
		<td><%=m.getUid()%></td>
		<td><%=m.getName()%></td>
		<td><%=m.getEmail() %></td>
		<td><%=m.getYear() %></td>
		</tr>
	<% }
%>
</table>
</body>
</html> 
