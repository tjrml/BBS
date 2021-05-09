<%@page import="java.util.List"%>
<%@page import="border.Border"%>
<%@page import="border.BorderDAO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<title>자유게시판</title>
<div class="border_container">
	<div class="border_box">
		<div class="border_title">자유게시판</div>
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
				<!-- 수정 삭제할때 쓸 idx, writer를 get으로 넘겨준다 -->
				<td	onclick="location.href='view.jsp?idx=<%=i.getIdx()%>&write=<%=i.getWriter()%>'"><%=i.getTitle()%></td>
				<td><%=i.getWriter()%></td>
				<!-- timestamp 패턴포맷 -->
				<td><%=i.getDate()%></td>
			</tr>
			<%
				}
			%>
		</table>
		<div class="btn border_btn" onclick="location.href='writing.jsp'">글쓰기</div>
		<div class="clear"></div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />