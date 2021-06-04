<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="user.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="head.jsp" flush="false" />
<title>회원가입</title>
<div id="join_container" style="position:relative">
	<div class="join_title">
		<h1>회원가입</h1>
	</div>
	<div class="formbox">
		<form action="Join" method="post">
			<p>아이디</p>
			<input type="text" name="id" required>
			<p>비밀번호</p>
			<input type="password" name="password" id="password" required>
			<p>비밀번호 확인 <span id="pw_confirm"></span></p>
			<input type="password" name="pwconfirm" id="pwconfirm" required>
			<p>이름</p>
			<input type="text" name="name" required>
			<p>나이</p>
			<input type="number" name="age" required>
			<p>주소</p>
			<input type="text" name="address" id="address" required/>
			<div id="search" style="display:none">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>
			<input type="button" onclick="sample2_execDaumPostcode()" class="postSearch" value="우편번호 찾기">
			<p>상세주소</p>
			<input type="hidden" id="address_post" name="" placeholder="우편번호">
			<input type="hidden" id="extraAddress" name="" placeholder="참고항목">
			<input type="text" name="detailed_Address" id="detailed_Address" required>
			<input type="submit" value="가입" class="joinbtn">
			<input type="button" value="취소" class="joinbtn" onclick="location.href='login.jsp'">
		</form>
	</div>
</div>
<script type="text/javascript">
//카카오 주소
// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('search');
	
	function closeDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_layer.style.display = 'none';
	}
	function sample2_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
	
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
	
				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("extraAddress").value = extraAddr;
	
				} else {
					document.getElementById("extraAddress").value = '';
				}
	
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('address_post').value = data.zonecode;
				document.getElementById("address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("detailed_Address").focus();
	
				// iframe을 넣은 element를 안보이게 한다.
				// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
				element_layer.style.display = 'none';
			},
			width : '100%',
			height : '100%',
			maxSuggestItems : 5
		}).embed(element_layer);
	
		// iframe을 넣은 element를 보이게 한다.
		element_layer.style.display = 'block';
	
		// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		initLayerPosition();
	}
	
	function initLayerPosition() {
		var width = 400; //우편번호서비스가 들어갈 element의 width
		var height = 466; //우편번호서비스가 들어갈 element의 height
		var borderWidth = 3; //샘플에서 사용하는 border의 두께
	
		// 위에서 선언한 값들을 실제 element에 넣는다.
		element_layer.style.width = width + 'px';
		element_layer.style.height = height + 'px';
		element_layer.style.border = borderWidth + 'px solid';
		// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
				+ '-200px';
		element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
				+ '-348px';
	}
</script>
<jsp:include page="footer.jsp" flush="false" />


