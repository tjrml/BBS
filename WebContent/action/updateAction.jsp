<%@page import="board.BoardDAO"%>
<%@page import="user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int idx = Integer.valueOf(request.getParameter("idx"));
	System.out.println(idx);
	String title = request.getParameter("title");
	String contents = request.getParameter("contents");
	BoardDAO dao = new BoardDAO();
	if (title.length() == 0 || contents.length() == 0) {
		out.println("<script>");
		out.println("alert('제목 또는 내용을 입력해주세요')");
		out.println("history.back()");
		out.println("</script>");
	} else {
		dao.update(title, contents, idx);
%>
<script>
	alert('수정되었습니다.');
	location.href= '/view.jsp?idx=<%= idx %>';
</script>
<% } %>
