<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<div class="writing_container">
	<div class="border_box writing_box">
		<form action="/Update" method="post">
			<div class="title_box">
				<input type="hidden" name="idx" value=${ idx } /> 
				<input type="text" name="title" placeholder="제목" value=${ title } />
			</div>
			<div class="content_box">
				<textarea rows="" cols="" name="contents" placeholder="내용">${ content }</textarea>
			</div>
			<input type="submit" value="수정" class="btn" style="right:12%">
		</form>
		<div class="btn" onclick="history.go(-1)">취소</div>
	</div>
</div>
<jsp:include page="footer.jsp" flush="false" />
