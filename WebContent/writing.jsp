<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="writing_box">
		<form action="writingAction.jsp" method="post">
			<div class="title_box">
				<input type="text" name="title" placeholder="제목">
			</div>
			<div class="content_box">
				<textarea rows="" cols="" name="contents"></textarea>
			</div>
			<input type="submit" value="작성" class="btn">
		</form>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />

