<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false"/>
<title>로그인</title>
<jsp:include page="gnb.jsp" flush="false" />
<% 
	if(session.getAttribute("id") != null) {
		response.sendRedirect("index.jsp");
	}
%>
<div id="wrap">
	<div class="login_title">
		<h1>LOGIN</h1>
	</div>
	<div class="formbox loginbox">
		<form action="Login" method="post">
			<p>아이디</p>
			<input type="text" name="id" size="30"><br>
			<p>비밀번호</p>
			<input type="password" name="password" size="30"><br>
			<!-- <span onclick="location.href='/join.jsp'">회원가입</span> -->
			<div class="clear"></div>
			<input class="loginbtn" type="submit" value="로그인">
		</form>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false"/>