<%@page import="board.Paging"%>
<%@page import="user.MemberDAO"%>
<%@page import="java.util.List"%>
<%@page import="board.Board"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 페이징 처리
	BoardDAO dao = new BoardDAO();
	int totalCount = dao.totalCount();
	int paramPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
	
	Paging paging = new Paging(); //get방식의 parameter값으로 반은 page변수, 현재 페이지 번호
	paging.setPageNo(paramPage); // 한페이지에 불러낼 게시물의 개수 지정
	paging.setPageSize(10);
	paging.setTotalCount(totalCount);
	
	int numPerPage = (paramPage - 1) * 10; // (1 -> 0) (2 -> 10) (3 -> 20) 페이지당 불러낼 게시물 수
	List<Board> list = dao.boardPrint(numPerPage, paging.getPageSize());
	int startPage = paging.getStartPageNo();
	int endPage = paging.getEndPageNo();
	int prevPage = paging.getPrevPageNo();
	int nextPage = paging.getNextPageNo();
	int totalPage = (int)Math.ceil((double)totalCount / paging.getPageSize());
%>
<jsp:include page="head.jsp" flush="false" />
<title>자유게시판</title>
<jsp:include page="gnb.jsp" flush="false"/>
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
				for (Board board : list) {
			%>
			<tr>
				<td><%= board.getIdx()%></td>
				<!-- 수정 삭제할때 쓸 idx, writer를 get으로 넘겨준다 -->
				<td	onclick="location.href='view.jsp?idx=<%= board.getIdx()%>&write=<%= board.getWriter() %>'"><%= board.getTitle() %></td>
				<td><%= board.getWriter()%></td>
				<!-- timestamp 패턴포맷 -->
				<td><%= board.getDate()%></td>
				<td></td>
			</tr>
			<%
				}
			%>
		</table>
		<div class="page_box">
			<% 
				if (startPage > 10) { 
			%>
			<div class=page onclick="location.href='bbs.jsp?page=<%= startPage - 10 %>'">이전</div> 
			<% } else {	%>
			<div class=page style="cursor:default;">이전</div>
			<%		
				}
			
				for (; startPage <= endPage; startPage++) {
					if (startPage <= endPage) {
						if (paramPage == startPage ) { 
			%>
			<div class=page onclick="location.href='bbs.jsp?page=<%= startPage %>'" style="color:red">[<%= startPage %>]</div>
			<% } else { %>
			<div class=page onclick="location.href='bbs.jsp?page=<%= startPage %>'">[<%= startPage %>]</div>
			<%	
							}
						}
					}
			%>
			<% if (endPage < totalPage) { %>
			<div class=page onclick="location.href='bbs.jsp?page=<%= endPage + 1 %>'">다음</div>
			<% } else { %>
			<div class=page style="cursor:default;">다음</div>
			<% } %>
		</div>
		<div class="btn" onclick="location.href='writing.jsp'">글쓰기</div>
		<div class="clear"></div>
	</div>
</div>

<jsp:include page="footer.jsp" flush="false" />