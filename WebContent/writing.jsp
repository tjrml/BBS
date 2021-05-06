<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	if (session.getAttribute("id") == null) {
		out.println("<script>");
		out.println("alert('로그인 해주세요.')");
		out.println("location.href = 'login.jsp';");
		out.println("</script>");
	}
%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="writing_box">
		<form action="BorderServlet" method="post">
			<div class="title_box">
				<input type="text" name="title" placeholder="제목">
			</div>
			<div class="content_box">
				<textarea rows="" cols="" name="contents"></textarea>
			</div>
			<input type="submit" value="작성" class="btn">
		</form>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />

