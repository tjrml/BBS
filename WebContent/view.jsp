<%@page import="java.util.List"%>
<%@page import="border.Border"%>
<%@page import="border.BorderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int idx = Integer.valueOf(request.getParameter("idx"));
	String writer = request.getParameter("writer");
%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="view_box">
		
		<div class="view_content"></div>
		
		
		<div class=clear></div>
	</div>
	<div class="btn_box">
		<input type="button" class="btn view_btn" value="목록" onclick="location.href='index.jsp'" />
		<input type="button" class="btn view_btn" value="수정" />
		<input type="button" class="btn view_btn" value="삭제" onclick="location.href='deleteAction.jsp?idx=<%= idx %>&writer=<%= writer %>'" />	
	</div>
	
</div>
<jsp:include page="footer.jsp" flush="false" />