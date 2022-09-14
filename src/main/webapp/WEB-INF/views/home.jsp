<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp"%><!-- 헤더(HEADER) -->
<script type="text/javascript">

<!-- 로그인 버튼 -->
$(document).ready(function() {

	// 뒤로가기 막기
	//noBack();
	
	
	// 로그인 관련 메세지
	/*
	let loginMsg = '<c:out value="${LOGIN}" />';
	 let msg = '';
	if(loginMsg != ''){
		if(loginMsg == 'LOGOUT') {
			msg = '로그아웃되었습니다.';
			alert(msg);
		} else if(loginMsg == 'FAIL') {
			msg = '아이디 또는 비밀번호를 확인해 주세요.';
			alert(msg);
		} else if(loginMsg == 'USING_USER') {
			msg = '이미 아이디가 접속 중입니다. 확인을 누르면 로그아웃됩니다.';
			false;
		}  else {
			msg = '로그인 오류';
			alert(msg);
		}
		
	} */
	
	// 로그인 전송 엔터키
	$("#loginForm").keypress(function (e) {  if (e.keyCode === 13) { login();  } });
	
/* 	let loginMsg = '<c:out value="${LOGIN}" />';
	if( loginMsg == 'USING_USER' ){

		if(confirm('이미 아이디가 접속 중입니다. 확인을 누르면 로그아웃됩니다.')){
			//let user_id = $('#user_id').val();
			
			//console.log(user_id);
			logOut();
			
		} else {
			console.log('y');
			false;
		}
	} */
	
	$('#btnLogin').click(function() {
		
	
		
		let regExpID = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; // 아이디는 문자로 시작
		let regExpPW = /^[A-Za-z0-9]{4,12}$/; // 영문, 숫자, 언더스코어(_), 하이픈(-)이 포함된 6~18 문자

		let form = document.loginForm;
		let id = form.user_id.value;
		let pw = form.user_pwd.value;
		
		

		if (!id) {
			alert('아이디를 입력해 주세요');
			$('#user_id').focus();
		} else if (!regExpID.test(id)) {
			alert('아이디는 문자로 시작해 주세요.');
			$('#user_id').val('');
			id.select();
			return;
		} else if (!pw) {
			alert('비밀번호를 입력해 주세요');
			$('#user_pwd').focus();
		} else if (!regExpPW.test(pw)) {
			alert('비밀번호를 확인해 주세요.');
			$('#user_pwd').val('');
			pw.focus();
			return;
		} 
		else {
			login();
		}
		
		

	});
});

	
function login() {
	let id = $('#user_id').val();
	let pw = $('#user_pwd').val();
	
	let oParam = 
 	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"login",
	    "contents":{
	            "user_id"	: id,
	            "user_pwd"	: pw,
	            "eqp_num"	: "CDFJRUJLP1"
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/user',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success) {
	    		// 로그인 성공 시, listUser으로 이동
	    		if(data.data.result_code = '200'){
	    			//window.location.href = '${pageContext.request.contextPath}/user/login.do';
	    			document.getElementById('loginForm').submit();
	    			susLogin();
	    		} 
	    	} else{
	    		if (data.result_code = '401'){
	    			alert('아이디와 비밀번호를 확인해 주세요');
	    		} else if (data.result_code = '400') {
	    			alert('아이디 또는 비밀번호를 입력해 주세요');
	    		} 
	    	}
	    	

	    	//form_reset();
	    },
	    error: function (){
	    	
	    }
	});
}

function susLogin(){
	let form = document.getElementById('loginForm');
	form.action = '${pageContext.request.contextPath}/user/login.do';
	form.method = 'POST';
	form.submit();
}


</script>
<body>
<div class="container">
	
	<c:choose>
		<c:when test="${sessionId.user_lvl eq 'a' or 'A'}"> <a class="collapse-item" href="<c:url value="/dashBoard" />">홈으로 이동</a> </c:when>
		<c:when test="${sessionId.user_lvl eq 'u' or 'U' }"> <a class="collapse-item" href="<c:url value="/dashBoardGuest" />">홈으로 이동</a> </c:when>
		<c:when test="${empty sessionId}"> <a class="collapse-item" href="<c:url value="/" />">홈으로 이동</a> </c:when> 
		<c:otherwise> <a class="collapse-item" href="<c:url value="/dashBoardGuest" />">홈으로 이동</a> </c:otherwise>
	</c:choose>
	
	<!-- Outer Row -->	
	<div class="row justify-content-center">

		<div class="col-xl-10 col-lg-12 col-md-9">

			<div class="card o-hidden border-0 shadow-lg my-5">
				<div class="card-body p-0">
					<!-- Nested Row within Card Body -->
					<div class="row">
						<div class="col-lg-6 d-none d-lg-block "><img src="${path}/resources/img/PTT.png" alt="pttLogo" width="100%"></div>
						<div class="col-lg-6">
							<div class="p-5"><br><br>
								<div class="text-center"> 
									<h1 class="h4 text-gray-900 mb-4">관리자 로그인</h1>
								</div>
								<form name="loginForm" id="loginForm"<%--  method="POST" action="${path}/user/login.do"  --%>onSubmit="return false;">
									<div class="form-group">
										<input type="text" class="form-control form-control-user" name="user_id" id="user_id" placeholder="아이디 입력">
									</div>
									<div class="form-group">
										<input type="password" class="form-control form-control-user" name="user_pwd" id="user_pwd" placeholder="비밀번호 입력" autocomplete="off">
									</div>
									<div>
										<!-- Controller의 mav.addObject("msg", "FAIL") -->
										<c:if test="${LOGIN == 'FAIL'}"> <div style="color: red">아이디 또는 비밀번호를 확인해 주세요</div> </c:if>
										<c:if test="${LOGIN == 'LOGOUT'}"> <div style="color: red">로그아웃</div> </c:if>
										<c:if test="${LOGIN == 'USING_USER'}"> <div style="color: red">이미 아이디가 접속중입니다.</div> </c:if>
										<%-- <c:if test="${msg == 'USER'}"> <div style="color: red">로그인권한없음</div> </c:if> --%>							
									</div><hr>
									<button type="button" id="btnLogin" class="btn btn-primary btn-user btn-block">로그인</button>
								</form>
								
								<!-- <div class="text-center"> <a class="small" href="forgot-password.html">비밀번호 찾기</a> </div> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="./include/footer.jsp"%>
<!-- 하단(FOOTER) -->
</body>

</html>