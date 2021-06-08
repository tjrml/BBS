<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="head.jsp" flush="false" />
<title>자유게시판</title>
<jsp:include page="gnb.jsp" flush="false" />
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
			<c:forEach items="${ list }" var="board">
				<tr>
					<td>${ board.idx }</td>
					<!-- 수정 삭제할때 쓸 idx, writer를 get으로 넘겨준다 -->
					<td	onclick="location.href='View?idx=${ board.idx }&write=${ board.writer }&hit=${ board.hit }'">${ board.title }</td>
					<td>${ board.writer }</td>
					<!-- timestamp 패턴포맷 -->
					<td>${ board.date }</td>
					<td>${ board.hit }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="page_box">
			<c:choose>
				<c:when test="${ startPage > 10 }">
					<div class=page	onclick="location.href='BBS?page=${ startPage - 10}'">이전</div>
				</c:when>
				<c:otherwise>
					<div class=page style="cursor:default;">이전</div>
				</c:otherwise>
			</c:choose>
			<c:forEach var="page" begin="${ startPage }" end="${ endPage }">
				<c:choose>
					<c:when test="${ paramPage == page }">
						<div class=page
							onclick="location.href='BBS?page=${ page }'"
							style="color: red">[${ page }]</div>
					</c:when>
					<c:otherwise>
						<div class=page
							onclick="location.href='BBS?page=${ page }'">[${ page }]</div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${ endPage < totalPage }">
					<div class=page
						onclick="location.href='BBS?page=${ endPage + 1 }'">다음</div>
				</c:when>
				<c:otherwise>
					<div class=page style="cursor: default;">다음</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="btn" onclick="location.href='writing.jsp'">글쓰기</div>
		<div class="clear"></div>
		<div class="searchbox">
			<form action="/BBS" method="get">
				<select name="selectbox">
					<option value="title" <c:if test="${ selectbox eq 'title'}"></c:if>>제목</option>
					<option value="writer" <c:if test="${ selectbox eq 'writer'}"></c:if>>작성자</option>
				</select>
				<input type="text" name="search_content" value="${ value }" class="search_content" required/>
				<input type="submit" value="검색" class="bbs_search" />
			</form>
		</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />