	
	/* 메뉴 hover */
	$(".menu").hover(function(){
		$(this).addClass(".menu");
	}, function(){
		$(this).removeClass(".menu");
	});
	
	/*  로그인 회원가입 hover */
	$(".login_singup").hover(function(){
		$(this).addClass(".login_singup");
	}, function(){
		$(this).removeClass(".login_singup");
	});
	
	// 비밀번호 확인
	$(function() {
		$("#pwconfirm").keyup(function() {
			if ($("#password").val().length == 0 || $("#pwconfirm").val().length == 0) {
				$("#pw_confirm").html('');
			} else if ($("#password").val() != $("#pwconfirm").val()) {
				$("#pw_confirm").html('비밀번호가 틀립니다. 다시 입력해주세요.');
				$("#pw_confirm").css('color', 'red');
			} else {
				$("#pw_confirm").html('비밀번호가 일치합니다.');
				$("#pw_confirm").css('color', 'blue');
			}
		});
	});
	
	