<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<title>Test</title>

<div class="containter">
	<div class="gnb">
		<ul>
			<li>HOME</li>
			<li></li>
			<li></li>
			<li>게시판</li>
		</ul>
		<div class="login_box">
			<% if (session.getAttribute("id") != null) { %>
				<div><%=session.getAttribute("id")%>님 환영합니다</div>
				<div onclick="location.href='logout.jsp'">로그아웃</div>
			<% } else { %>
				<span class="login" onclick="location.href='login.jsp'">로그인</span>
			<% } %>
		</div>
		<div class="clear"></div>
	</div>
</div>
<jsp:include page="bbs.jsp" flush="false" />
<jsp:include page="footer.jsp" flush="false" />