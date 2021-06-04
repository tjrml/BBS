<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	/* session값이 없을때 로그인 페이지로 이동 */
	if (session.getAttribute("id") == null) {
		out.println("<script>");
		out.println("alert('로그인 해주세요.')");
		out.println("location.href = 'login.jsp';");
		out.println("</script>");
	}
%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="border_box writing_box">
		<form action="/Writing" method="post">
			<div class="title_box">
				<input type="text" name="title" placeholder="제목">
			</div>
			<div class="content_box">
				<textarea rows="" cols="" name="contents" placeholder="내용"></textarea>
			</div>
			<input type="submit" value="작성" class="btn" style="right:12%">
		</form>
		<div class="btn" onclick="location.href='/BBS'">취소</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />

