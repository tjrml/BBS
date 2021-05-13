<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="gnb">
		<ul>
			<li onclick="location.href='index.jsp'">HOME</li>
			<li></li>
			<li></li>
			<li onclick="location.href='bbs.jsp'">게시판</li>
		</ul>
		<div class="login_box">
			<% if (session.getAttribute("id") != null) { %>
				<div class="logout "><%=session.getAttribute("id")%>님 환영합니다</div>
				<div class="logout icon" onclick="location.href='logout.jsp'"><i class="fas fa-sign-out-alt"></i><span>로그아웃</span></div>
			<% } else { %>
				<span class="login" onclick="location.href='login.jsp'"><i class="fas fa-user"></i></span>
			<% } %>
		</div>
		<div class="clear"></div>
	</div>
<jsp:include page="footer.jsp" flush="false" />