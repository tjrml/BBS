<%@page import="java.util.List"%>
<%@page import="border.Border"%>
<%@page import="border.BorderDAO"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int idx = Integer.valueOf(request.getParameter("idx"));
	BorderDAO dao = new BorderDAO();
	List<Border> list = dao.seleteOne(idx);
%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="border_box view_box">
		<table class="view_table">
			<% for (Border border : list) {	%>
			<tr>
				<td colspan="2">제목 : <%= border.getTitle() %></td>
			</tr>
			<tr>
				<td>작성자 : <%= border.getWriter() %> </td>
				<td>등록일 : <%= border.getTime().toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) %></td>
			</tr>
		</table>
		<div class="view_content"><%= border.getContent() %></div>
		<div class="view_btnbox">
			<div class="btn view_btn" onclick="location.href='index.jsp'" >목록</div>
			<div class="btn view_btn" onclick="location.href='update.jsp?title=<%= border.getTitle() %>&content=<%= border.getContent() %>&idx=<%= idx %>&writer=<%= border.getWriter() %>'">수정</div>
			<div class="btn view_btn" onclick="location.href='deleteAction.jsp?idx=<%= idx %>&writer=<%= border.getWriter() %>'">삭제</div>	
			<div class="clear"></div>
		</div>
		<% } %>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />