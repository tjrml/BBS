<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false"/>
<% 
	if(session.getAttribute("id") != null) {
		response.sendRedirect("index.jsp");
	}
%>
<title>로그인</title>
	<div id="wrap">
		<div class="title">
			<h1>LOGIN</h1>
		</div>
		<div class="formbox">
			<form action="Login" method="post">
				<p>아이디</p>
				<input type="text" name="id" size="30"><br>
				<p>비밀번호</p>
				<input type="password" name="password" size="30"><br>
				<span onclick="location.href='/join.jsp'">회원가입</span>
				<div class="clear"></div>
				<input type="submit" value="로그인" id="loginbtn">
			</form>
		</div>
	</div>
<jsp:include page="footer.jsp" flush="false"/>