<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="view_box">
		<div class="view_title"></div>
		<div class="view_content"></div>	
	</div>
	<div class="btn_box">
		<div class="btn view_btn" onclick="location.href='index.jsp'">목록</div>
		<div class="btn view_btn" onclick="location.href='update.jsp'">수정</div>
		<div class="btn view_btn">삭제</div>
		<div class=clear></div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />