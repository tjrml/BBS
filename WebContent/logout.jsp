<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		session.invalidate();
	%>
	<p>로그아웃 되었습니다.</p>
	<a href="login.jsp">처음으로</a>
</body>
</html>