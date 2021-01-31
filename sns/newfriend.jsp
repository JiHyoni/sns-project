<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New User</title>
</head>
<body>
<H2>친구추가</H2>
<HR>
<form method="post" action="user_control.jsp?action=newfriend">
아이디   <input type="text" name="uid" size="10" required>
<input type="submit" value="친구추가">
</form>
</body>
</html> 
