<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%	
 	int idx = Integer.valueOf(request.getParameter("idx"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String id = (String) session.getAttribute("id");
 	if (session.getAttribute("id") == null) {
		out.println("<script>");
		out.println("alert('로그인 해주세요.')");
		out.println("location.href = 'login.jsp'");
		out.println("</script>");
	} else if (!id.equals(writer)) {
		out.println("<script>");
		out.println("alert('작성자가 틀립니다.')");
		out.println("history.back()");
		out.println("</script>");
	} 
 %>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="border_box writing_box">
		<form action="/action/updateAction.jsp" method="post">
			<div class="title_box">
				<input type="hidden" name="idx" value=<%= idx %> /> 
				<input type="text" name="title" placeholder="제목" value=<%= title %> />
			</div>
			<div class="content_box">
				<textarea rows="" cols="" name="contents" placeholder="내용"><%= content %></textarea>
			</div>
			<input type="submit" value="수정" class="btn" style="right:12%">
		</form>
		<div class="btn" onclick="history.go(-1)">취소</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />
