<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="border_box view_box">
		<table class="view_table">
				<tr>
					<td colspan="2">제목 : ${ board.title }</td>
				</tr>
				<tr>
					<td>작성자 : ${ board.writer }</td>
					<td>등록일 : ${ board.time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) }</td>
				</tr>
		</table>
		<div class="view_content">${ board.content }</div>
		<div class="view_btnbox">
			<div class="btn view_btn" onclick="location.href='/BBS'">목록</div>
			<div class="btn view_btn"
				onclick="location.href='update.jsp?title=${ board.title }&content=${ board.content }&idx=${ board.idx }&writer=${ board.writer }'">수정</div>
			<div class="btn view_btn"
				onclick="location.href='/action/delete.jsp?idx=${ board.idx }&writer=${ board.writer }'">삭제</div>
			<div class="clear"></div>
		</div>

	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />