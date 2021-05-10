<%@page import="user.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="border.Border"%>
<%@page import="border.BorderDAO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 	
	// 페이징 처리
	BorderDAO dao = new BorderDAO();
	int total = dao.totalCount(); // DB 전체 게시물 개수
	// 19 / 10 -> 1.9 -> ceil(1.9)올림 -> 2.0  
	int lastPage = (int)Math.ceil((double)total / 10); // 전체페이지 수 구하기
	String pageStr = request.getParameter("page");
	int pageNum = 1;
	if (pageStr != null) {
		pageNum = Integer.parseInt(pageStr);
	}
	int index = (pageNum - 1) * 10; // (1 -> 0) (2 -> 10) (3 -> 20) 1페이지일때 보여지는 인덱스
	
%>
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
				<col width="15%">
				<col width="10%">
			</colgroup>
			<tr>
				<th>No</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성시간</th>
				<th>조회수</th>
			</tr>
		</table>
		<table class="border_main">
			<colgroup>
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="15%">
				<col width="10%">
			</colgroup>
			<%
				List<Border> list = dao.borderPrint(index);
				for (Border i : list) {
			%>
			<tr>
				<td><%=i.getIdx()%></td>
				<!-- 수정 삭제할때 쓸 idx, writer를 get으로 넘겨준다 -->
				<td	onclick="location.href='view.jsp?idx=<%=i.getIdx()%>&write=<%=i.getWriter()%>'"><%=i.getTitle()%></td>
				<td><%=i.getWriter()%></td>
				<!-- timestamp 패턴포맷 -->
				<td><%=i.getDate()%></td>
				<td></td>
			</tr>
			<%
				}
			%>
		</table>
		<div class="page_box">
			<div class=page onclick="location.href='bbs.jsp?page='">이전</div>
			<% 
				for(int pageNumber = 1; pageNumber <= lastPage; pageNumber++) {
					if (pageNumber <= 10) {
			%>
			<div class=page onclick="location.href='bbs.jsp?page=<%= pageNumber %>'">[<%= pageNumber %>]</div>
			<% 
					}
				}
			%>
			<div class=page onclick="location.href='bbs.jsp?page='">다음</div>
			
		</div>
		<div class="btn" onclick="location.href='writing.jsp'">글쓰기</div>
		<div class="clear"></div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />