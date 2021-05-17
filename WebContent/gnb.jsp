<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="gnb">
		<div class="loginbox">
			<span class="login_singup" onclick="location.href='login.jsp'">로그인</span>
			<span>|</span>
			<span class="login_singup" onclick="location.href='join.jsp'">회원가입</span>
			<div style="padding:0 2.5px">E-mail : <span class="login_singup">ws880521@naver.com</span></div>
		</div>
		<ul>
			<li class="menu" onclick="location.href='index.jsp'">HOME</li>
			<li class="menu">ABOUT ME</li>
			<li class="menu">RESUME</li>
			<li class="menu">PORTFOLIO</li>
			<li class="menu" onclick="location.href='bbs.jsp'">BOARD</li>
		</ul>
		<div class="clear"></div>
<%-- 		<div class="login_box">
			<% if (session.getAttribute("id") != null) { %>
				<div class="logout "><%=session.getAttribute("id")%>님 환영합니다</div>
				<div class="logout icon" onclick="location.href='logout.jsp'"><i class="fas fa-sign-out-alt"></i><span>로그아웃</span></div>
			<% } else { %>
				<span class="login" onclick="location.href='login.jsp'">login</span>
			<% } %>
		</div> --%>
	</div>
<script>
	/* 메뉴 hover */
	$(".menu").hover(function(){
		$(this).addClass(".menu");
	}, function(){
		$(this).removeClass(".menu");
	});
	/*  로그인 회원가입 hover */
	$(".login_singup").hover(function(){
		$(this).addClass(".login_singup");
	}, function(){
		$(this).removeClass(".login_singup");
	});
</script>
<jsp:include page="footer.jsp" flush="false" />