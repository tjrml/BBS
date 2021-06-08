<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="gnb">
		<div class="loginbox">
			<% if (session.getAttribute("id") != null) {%>
				<span class="login_singup" onclick="location.href='logout.jsp'"><i class="fas fa-sign-out-alt"></i>로그아웃</span>
			<% } else { %>
				<span class="login_singup" onclick="location.href='login.jsp'">로그인</span>
				<span>|</span>
				<span class="login_singup" onclick="location.href='join.jsp'">회원가입</span>
			<% }  %>
			<div style="padding:0 2.5px">E-mail : <span class="login_singup">ws880521@naver.com</span></div>
		</div>
		<ul>
			<li class="menu" onclick="location.href='index.jsp'">HOME</li>
			<li class="menu" onclick="location.href='profile.jsp'">ABOUT ME</li>
			<li class="menu">RESUME</li>
			<li class="menu">PORTFOLIO</li>
			<li class="menu" onclick="location.href='BBS'">BOARD</li>
		</ul>
		<div class="clear"></div>
	</div>
<jsp:include page="footer.jsp" flush="false" />