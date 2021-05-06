<%@page import="java.util.List"%>
<%@page import="border.Border"%>
<%@page import="border.BorderDAO"%>
<%@page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<%
	session.getAttribute("id");
%>
<title>자유게시판</title>
<div onclick="location.href='logout.jsp'">로그아웃</div>
<div class="border_container">
	<div class="border_title">자유게시판</div>
	<div class="border">
		<table class="border_head">
			<colgroup>
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="25%">
			</colgroup>
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성시간</th>
			</tr>
		</table>
		<table class="border_main">
			<colgroup>
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="25%">
			</colgroup>
			<%
				BorderDAO dao = new BorderDAO();
				List<Border> list = dao.borderPrint();
				for (Border i : list) {
			%>
			<tr>
				<td><%=i.getIdx()%></td>
				<td onclick="location.href='view.jsp'"><%=i.getTitle()%></td>
				<td><%=i.getWriter()%></td>
				<td><%=i.getTime().toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
	<div class="btn" onclick="location.href='writing.jsp'">글쓰기</div>
	<div class="clear"></div>
</div>
<jsp:include page="footer.jsp" flush="false" />