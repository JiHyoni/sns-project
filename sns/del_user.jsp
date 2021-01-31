<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete User</title>
</head>
<body>
<H2>회원 탈퇴</H2>
<HR>
정말 탈퇴하시겠습니까? <br>
아이디와 비밀번호를 다시 한 번 입력해주세요! <br><br>
<form method="post" action="user_control.jsp?action=del">
아이디   <input type="text" name="uid" size="10" required><br>
비밀번호   <input type="text" name="passwd" size="10" required>
<input type="submit" value="회원탈퇴">
</form>
</body>
</html> 
