<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="head.jsp" flush="false" />
<title>회원가입</title>
<div>
	<div class="join_title">
		<h1>회원가입</h1>
	</div>
	<div class="formbox">
		<form action="/action/joinAction.jsp" method="post">
			<p>아이디</p>
			<input type="text" name="id" required>
			<p>비밀번호</p>
			<input type="password" name="password" id="password" required>
			<p>
				비밀번호 확인 <span id="pw_confirm"></span>
			</p>
			<input type="password" name="pwconfirm" id="pwconfirm" required>
			<p>이름</p>
			<input type="text" name="name" required>
			<p>나이</p>
			<input type="number" name="age" required> <input
				type="submit" value="가입" class="joinbtn"> <input
				type="button" value="취소" class="joinbtn"
				onclick="location.href='login.jsp'">
		</form>
	</div>
</div>
<script type="text/javascript">
	// 비밀번호 확인
	$(function(){
	    $("#pwconfirm").keyup(function(){
	    	if ($("#password").val().length == 0 || $("#pwconfirm").val().length == 0) {
	    		$("#pw_confirm").html('');
	    	} else if ($("#password").val() != $("#pwconfirm").val()){
	          $("#pw_confirm").html('비밀번호가 틀립니다. 다시 입력해주세요.');
	          $("#pw_confirm").css('color', 'red');
	        } else {
	          $("#pw_confirm").html('비밀번호가 일치합니다.');
	          $("#pw_confirm").css('color', 'blue');
	        }
	    });
	});
</script>
<jsp:include page="footer.jsp" flush="false" />


