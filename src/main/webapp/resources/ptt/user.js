function logOut() {
	
	//console.log(user_id);
	
	//let user_id = $('#sessionId').val();
	let user_id = $('#user_id').val();
	console.log(user_id);
	let oParam = 
 	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"logout",
	    "contents":{
	            "user_id"	: user_id,
	            "eqp_num"	: "CDFJRUJLP1"
	    }
	};
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/user',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success) {
	    		if(data.data.result_code = '200'){
	    			//window.location.href = '/user/logOut';
					//console.log(data.data.contents.user_id);
					user_id = data.data.contents.user_id;
					susLogOut(user_id);
					//location.href = '/';
	    		} else {
					alert('로그아웃실패');
	    			//window.location.href = '${pageContext.request.contextPath}/user/login.do';
	    		}
	    	}
	    },
	    error: function (){
	    	
	    }
	});
}


// 로그아웃 세션 종료 controller /user/logout 
function susLogOut(user_id) {
	// form 동적 생성
	let form = document.createElement('form');
	
	// form 설정
	form.name = 'form';
	form.method = 'POST';
	form.action = '/user/logOut';
	//form.target = '_blank';
	
	// input 설정
	let input = document.createElement('input');
	input.setAttribute('type', 'hidden');
	input.setAttribute('name', 'user_id');
	input.setAttribute('value', user_id);
	
	form.appendChild(input);			// form 밑에 input 요소 추가
    document.body.appendChild(form);	// body 밑에 form 요소 추가

	form.submit();	// form 전송

}

$(document).ready(function(){
	
	$(".btn-user-type").on("click", function () {
/*		$('#radio').click(function (e) {
                    if (chk) {
                        chk = false;
                        $("input:radio[id='radio']").prop("checked", false);
                    }
                    else {
                        chk = true;
                        $("input:radio[id='radio']").prop("checked", true);
                    }
                });
*/

		// 버튼 전체 배경색 흰색으로 초기화
		$(".btn-user-type").css("background-color", 'white');
		
		if ($(this).attr('name') == 'user_lvl_u')
		{
			$(this).css("background-color", 'skyblue').css('color', 'black');
		}
		else if ($(this).attr('name') == 'user_lvl_a')
		{
			$(this).css("background-color", 'pink').css('color', 'black');
		}
		else if ($(this).attr('name') == 'view_user_lvl_u')
		{
			$(this).css("background-color", 'skyblue').css('color', 'black');
		}
		else if ($(this).attr('name') == 'view_user_lvl_a')
		{
			$(this).css("background-color", 'pink').css('color', 'black');
		}
	});
	
	
});

function regJoin(){
// 정규식
		let regExpID = /^[a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]{2,20}/;	// 아이디	  : 문자로 시작
		let regExpPW = /^[A-Za-z0-9]{4,12}$/; 		// 비번	  : A~Z, a~z, 0~9로 시작하는 4~12자리 
		let regExpPWCHECK = /^[A-Za-z0-9]{4,12}$/; 	// 비번확인 : A~Z, a~z, 0~9로 시작하는 4~12자리 
		let regExpNM = /^[가-힣]{2,20}$/;				// 이름    : 가~힣, 한글로 이뤄진 2~20자리
				
		// form 담아서 보내는 내용
		let form = document.frmUser;				// fome name="joinForm" => document.joinform
		let nm = form.user_nm.value;				// 이름
		let id = form.user_id.value;				// 아이디
		let pw = form.user_pwd.value;				// 비밀번호
		let pw_check = form.user_pwd_check.value;	// 비밀번호 체크

		let idCheck = $("#btnIdCheck").val();		// 아이디 중복 확인
		let co_num = form.co_num;					// 회사 체크
		let dpart_index = form.dpart_index;			// 상위부서 체크
		let dpart_num = form.dpart_num;				// 하위부서 체크
		let user_pst = form.user_pst;				// 직급 체크
		
		
		if(!regExpNM.test(nm)) {
			alert("이름은 한글로만 입력해 주세요.(2자 이상)");
			$("#user_nm").val("");
			nm.focus();
			return;
		} else if(!regExpID.test(id)) {
			alert("아이디는 문자로 시작해 주세요.(2자 이상)");
			$("#user_id").val("");
			 $("#btnIdCheck").attr('value', "N");
			id.select();
			return;
		} else if (!regExpPW.test(pw)) {
			alert("비밀번호를 영문 대소문자로 4~12 문자로 입력해 주세요.");
			$("#user_pwd").val("");
			pw.focus();
			return;
		} else if (pw != pw_check) {
			alert("비밀번호가 맞지 않으니, 확인 바랍니다.");
			$("#user_pwd_check").val("");
			pw_check.focus();
			return;
		} else if(co_num.selectedIndex == '0') {
   			alert("회사를 선택해 주세요.");
			co_num.focus();
			return;
		} else if(dpart_index.selectedIndex == '0') {
   			alert("상위부서를 선택해 주세요.");
			dpart_index.focus();
			return;
		} else if(dpart_num.selectedIndex == '0') {
   			alert("하위부서를 선택해 주세요.");
			dpart_num.focus();
			return;
		}else if(user_pst.selectedIndex == '0') {
   			alert("직급을 선택해 주세요.");
			user_pst.focus();
			return;
		}

		
		else if (idCheck == "N") {
			alert("아이디 중복확인해 주세요.");
			idCheck.focus(); return;
		} else if (idCheck == "Y") {
			//form.submit();
			addUser();
		}
}

// 사용자 등록
function addUser() {
	let nm = $('#user_nm').val();		// 이름
	let id = $('#user_id').val();		// 아이디
	let pw = $('#user_pwd').val();		// 비밀번호
	let com = $('#co_num').val();		// 회사번호
	let pst = $('#user_pst').val();		// 직급
 	let lvl = $(this).attr('name') == 'user_lvl_u' ? 'u' : 'a';
	let dpart = $("select[name=dpart_num]").val();
	let sip = $('#svr_id').val();		// SIP
	let mqtt = $('#mqtt_id').val();		// MQTT
	let editor = $('#editor').val();	// 작성자

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"user_create",
	    "contents":{
	            "user_nm"		: nm,
	            "user_id"		: id,
	            "user_pwd"		: pw,
	            "co_num"		: com,
	            "user_pst"		: pst,
	            "user_lvl"		: lvl,
	            "dpart_num"		: dpart,
	            "sip_svr_id"	: sip,
	            "mqtt_svr_id"	: mqtt,
	            "editor"		: editor
	    }
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/user",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){

			//window.location.href = '${pageContext.request.contextPath}/user/listUser.do'; 
	    	data.is_success ? (alert('사용자 등록 성공'),window.location.href = '/user/listUser.do') : alert('사용자 등록 실패');;

	    },
	    error: function (){
	    	debugger;
	    }
	});
}

function listUser(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	

	const URL = '/user/listUser.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	
	console.log('URL... ' + URL);
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listUserCallback(data) : alert('user 목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listUserCallback(data){	
	let _list = data.data.list;
	let list_output = [];
	let _page = data.data.pageMaker;
	let curPage = _page.cri.page; // 현재 페이지
	

	if (_list.length == 0) {
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>조회 정보가 일치하지 않습니다.</td>");
		list_output.push("</tr>");
	} 	

	for(let i in _list) {
		let row = _list[i];
		
		let num = row.rnum;
		let user_num = row.user_num;
		let user_nm = row.user_nm;
		let user_id = row.user_id;
		let e164 = row.e164_no;
		let co_num = row.co_num;
		let dpart_num = row.dpart_num;
		let user_pst = row.user_pst;
		let sip = row.sip_svr_id;
		let mqtt = row.mqtt_svr_id;



		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td>' + user_num + '</td>');
		list_output.push('<td>' + user_nm + '</td>');
		list_output.push('<td> <a href="#" data-toggle="modal" data-target="#userInfo"');
		list_output.push('onclick="javascript:getViewUser(' + user_num + '); getListViewPosi(\'' + user_pst + '\');');
		list_output.push('listCom('+ 3 +'); listUpDpart(' + 3 + ',\'' + co_num + '\'); ">' +  user_id + '</a></td>');
		list_output.push('<td>' + e164 + '</td>');
		list_output.push('<td>' + co_num + '</td>');
		list_output.push('<td>' + dpart_num + '</td>');
		list_output.push('<td>' + user_pst + '</td>');
		list_output.push('<td>' + sip + '</td>');
		list_output.push('<td>' + mqtt + '</td>');
 		list_output.push("</tr>");
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let max = _page.tempEndPage; // 총 페이지
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음
	
	
	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (!_page.prev && _list.length > 0) { page_output.push('<li class="page-item"><a href="javascript:listUser(' + prev + ')"; class="page-link"><</a></li>'); } 
	for(let i = start; i <= end; i++) { 
		//page_output.push('<li class="page-item"><a href="javascript:listUser(' + i + ')"; class="page-link">' + i + '</a></li>'); 
		
		//페이지 버튼 활성화 파란색 표현
		//$('#page'+thisPage).addClass('active');
		
		if (i == curPage) {
			page_output.push('<li class="page-item active"><a class="page-link">' + i + '</a></li>');
		} else {
			page_output.push('<li class="page-item"><a href="javascript:listUser(' + i + ')"; class="page-link">' + i + '</a></li>'); 
		}
			
	}
	if (curPage < max) { page_output.push('<li class="page-item"><a href="javascript:listUser(' + next + ')"; class="page-link">></a></li>'); }
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}

//User 상세 정보 json 데이터 가져오시
function getViewUser(user_num, callback, error) {
	
	console.log('dddddddddddddddd');
	const URL = '/user/getViewUser/' + user_num + '.json';
	
	$.get(URL, function(data){

		
		console.log(data);
		$('input[name=view_user_num]').attr('value', data.data.user_num);
		$('input[name=view_user_nm]').attr('value', data.data.user_nm);
		$('input[name=view_user_id]').attr('value', data.data.user_id);		
		$('input[name=view_user_pwd]').attr('value', data.data.user_pwd);
		data.data.user_lvl == 'a' ? $('input[name=view_user_lvl]').attr('value', data.data.user_lvl) : $('input[name=view_user_lvl]').attr('value', data.data.user_lvl);
		
		console.log('lvl ' + data.data.user_lvl);
		
		/*$('input[name=view_co_num]').attr('value', data.data.co_num);
		$('input[name=view_dpart_index]').attr('value', data.data.dpart_index);
		$('input[name=view_dpart_num]').attr('value', data.data.dpart_num);
		$('input[name=view_user_pst]').attr('value', data.data.user_pst);	*/
		
		//$("#view_co_num").val(data.data.co_num).attr("selected", "selected");
		//$("#view_dpart_index").val(data.data.dpart_index).attr("selected", "selected");
		//$("#view_dpart_num").val(data.data.dpart_num).attr("selected", "selected");
		//$("#view_user_pst").val(data.data.user_pst).attr("selected", "selected");
		
		$('input[name=view_input_co_num]').attr('value', data.data.co_num);
		$('input[name=view_input_dpart_num]').attr('value', data.data.dpart_num);
		$('input[name=view_input_user_pst]').attr('value', data.data.user_pst);
		
	
		$("#before_dpart_num").val(data.data.dpart_num).attr("selected", "selected");
	

		switch (data.data.sip_svr_id) {
			case 'SIP01' : 
		   		$("#view_svr_id").val('SIP01').prop("selected", true);
			    break;
			case 'SIP02' : 
			    $("#view_svr_id").val('SIP02').prop("selected", true);
			    break; 
			case 'SIP03' :
				 $("#view_svr_id").val('SIP03').prop("selected", true);
			 	break; 
			case 'SIP04' :
				 $("#view_svr_id").val('SIP04').prop("selected", true);
				 break; 
			case 'SIP05' :
				 $("#view_svr_id").val('SIP05').prop("selected", true);
			/*default :  
				$("#view_svr_id").text("선택해주세요").prop("selected", true);*/
		}
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

// 사용자 수정
function modUser(){
	let num = $('#view_user_num').val();
	let nm = $('#view_user_nm').val();
	let id = $('#view_user_id').val();
	let pw = $('#view_user_pwd').val();
	let pst = $('#view_user_pst').val();
	let dpart = $('#view_dpart_num').val();
	let sip = $('#view_svr_id').val();
	let mqtt = $('#view_mqtt_id').val();
	let editor = $("#editor").val();
	
	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":sendTime(),
		"snd_type":"request",
		"command":"user_update",
		"contents":{
				"user_num"		: num,
	            "user_nm"		: nm,
	            "user_id"		: id,
	            "user_pwd"		: pw,
	            "user_pst"		: pst,
	            "dpart_num"		: dpart,
	            "sip_svr_id"	: sip,
	            "mqtt_svr_id" 	: mqtt,
	            "editor"		: editor
		}
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/user',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('사용자 정보 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/user/listUser.do'; 
				window.location.href = '/user/listUser.do';		
	    	}
	    	if( ! data.is_success ) {
				// 500 : 사용자번호와 아이디 오류
	    		// 사용자 비밀번호 체크
	    		if(data.data.result_code == '401'){
	    			alert('비밀번호를 확인해 주세요');
	    		} else if(data.data.result_code == '400') {
	    			
	    			alert('비어 있는 항목이 있습니다. 입력값을 확인해 주세요.');
	    		} else {
	    			alert('사용자 정보 수정 실패');
	    		}
	    	}
	    },
	    error: function (){
	    }
	});
}

// 사용자 삭제
function delUser(){
	let num = $('#view_user_num').val();
	let id = $('#view_user_id').val();
	let pw = $('#view_user_pwd').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"user_delete",
	    "contents":{
	            "user_num" : num,
	            "user_id"  : id,
	            "user_pwd" : pw
	    }
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/user",
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('사용자 정보 삭제 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/user/listUser.do'; 
				window.location.href = '/user/listUser.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    
	    		 if(data.data.result_code == '400') {
	    			alert('비어 있는 항목이 있습니다. 입력값을 확인해 주세요.');
	    		} else if(data.data.result_code == '409'){
	    			alert('조회된 사용자가 없거나 비밀번호가 틀립니다. 관리자에게 문의하세요.');
	    		}	else {
	    			alert('사용자 정보 삭제 실패');
	    		}
	    	}	
	    },
	    error: function (){
	    	debugger;
	    }
	});
}
// 아이디 체크
function idCheck() {
	let idCheck = $('#user_id').val();
	let data = { 'user_id' : idCheck };
	let form = document.viewUser;
	let id = form.user_id.value;
	
	if(id == '' || id < 0) {
		alert('아이디를 입력해 주세요.');
		id.focus();
		return false;
	} else {
		$.ajax({
			url : '/user/insertIdCheck',
		    type: 'POST',
		    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
		    data : JSON.stringify(data),
		    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
		    success: function(data){
		         if(data == 0){
			         //console.log("아이디 없음");
			         alert('사용 가능한 아이디입니다.');
			         $('#btnIdCheck').attr('value', 'Y');	// ID 확인 체크 (기본값 : N, 체크확인 : Y)
		         }else if(data == 1){
		         	//console.log('아이디 있음');
		         	alert('중복된 아이디가 존재합니다.');
		         } /* else if(data == null || data == undefined) {
		        	 alert("아이디는 문자로 시작해 주세요.");
		        	 $("#btnIdCheck").attr('value', "N");
		         } */
		    },
		    error: function (){        
		                      
		    }
		});
	}
}

//비밀번호 변경
function pwChange(){
	debugger;
	let id = $('#view_user_id').val();
	let pw = $('#pre_pwd').val(); 				// 현재 비밀번호
	let newPw = $('#change_user_pwd').val();			// 변경될 비밀번호
	let nPwCheck = $('#change_user_pwd_check').val();	// 변경될 비번확인
	let regExpPW = /^[A-Za-z0-9]{4,12}$/; 		// 비번	  : A~Z, a~z, 0~9로 시작하는 4~12자리 
	
	// 현재 비밀번호 맞는지 확인
	
	// 정규식
	if(!regExpPW.test(newPw)) {
		alert('영문 대소문자로 4~12 문자로 입력해 주세요.');
		$('#newPw').val('');
		newPw.focus();
		return;
	} 
	 
	// 비밀번호 확인
	if(newPw != nPwCheck) {
		alert('비밀번호가 맞지 않으니, 확인 바랍니다.');
		// 비우기
		$('#user_pwd').val('');
		$('#user_pwd_check').val('');
		user_pwd.focus();
		return;
	}

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"change_pw",
	    "contents":{
	        "user_id"  : id,
	        "pre_pwd"  : pw,
	        "user_pwd" : newPw 
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/user',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			//window.location.href = '${pageContext.request.contextPath}/user/listUser.do')
			 data.is_success ? (alert('비밀번호 변경 성공'), window.location.href = '/user/listUser.do') : alert('비밀번호 변경 실패');
			// 비밀번호 변경
			$('#pre_pwd').val('');
			$('#change_user_pwd').val('');
			$('#change_user_pwd_check').val('');
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

function pwReset() {
	let id = $('#view_user_id').val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"pwd_reset",
	    "contents":{ "user_id" : id } 
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/user',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			 data.is_success ? (alert('비밀번호 초기화 성공'), window.location.href = '/user/listUser.do') : alert('비밀번호 초기화 실패');
	    },
	    error: function (){
	    	debugger;
	    }
	});
}


function idCheck() {
	let idCheck = $('#user_id').val();
	let data = { 'user_id' : idCheck };
	let form = document.frmUser;
	let id = form.user_id.value;
	
	if(id == '' || id < 0) {
		alert('아이디를 입력해 주세요.');
		id.focus();
		return false;
	} else {
		$.ajax({
			url : '/user/insertIdCheck',
		    type: 'POST',
		    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
		    data : JSON.stringify(data),
		    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
		    success: function(data){
		         if(data == 0){
		         //console.log("아이디 없음");
		         alert('사용 가능한 아이디입니다.');
		         $('#btnIdCheck').attr('value', 'Y');	// ID 확인 체크 (기본값 : N, 체크확인 : Y)
		         }else if(data == 1){	        
		         	alert('중복된 아이디가 존재합니다.');
		         } /* else if(data == null || data == undefined) {
		        	 alert("아이디는 문자로 시작해 주세요.");
		        	 $("#btnIdCheck").attr('value', "N");
		         } */
		    },
		    error: function (){        
		                      
		    }
		});
	} // else if(정규식)
}

// **********  ********** [INSERT] insertUser.jsp company 목록  **********  **********
// company.js listCom()
function userComCallback(data){	
	
	let _list = data.data.contents;
	let list_output = [];

	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>회사가 존재하지 않습니다.</h6>");
		return;
	}

	// getUpDpName() -> listUser.jsp
	list_output.push('<select name="co_num" id="co_num" class="form-control" onclick="getUpDpName(' + 2 + ')" >');
	list_output.push('<option value="선택">선택</option>');
	for(let i in _list) {
		let row = _list[i];
		let co_name = row.co_name;
		let co_num = row.co_num;
		
		list_output.push('<option value="' + co_num + '">' + co_name + '</option>');
	}
	
	list_output.push('</select>');

	$('#userInsertCom').html(list_output.join(''));
}

// **********  ********** [VIEW] insertUser.jsp company 목록  **********  **********
// company.js listCom()
function userViewComCallback(data){	
	let _list = data.data.contents;

	let view_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>회사가 존재하지 않습니다.</h6>");
		return;
	}

	//$("#view_co_num").change(function(){ console.log('2'); })
	
	view_output.push('<select name="view_co_num" id="view_co_num" class="form-control" onclick="getUpDpName(' + 3 + ')" >');
	for(let i in _list) {
		let row = _list[i];
		let co_name = row.co_name;
		let co_num = row.co_num;
		view_output.push('<option value="' + co_num + '">' + co_name + '</option>');
	}
	
	view_output.push('</select>');

	$('#userViewCom').html(view_output.join(''));
}

// dpart.js 의 listUpDp
// **********  ********** [INSERT] 상위 부서 SELECT  목록 가져오기 **********  **********
function userUpDpCallback(data) {
	let _list = data.data.contents.list;
	let list_output = [];
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	// onClick : 상위 부서 목록 띄우기 listUpDpart()	onclick="userDpartCallback('+dpart_nm+')" 
	list_output.push('<select name="dpart_index" id="dpart_index" class="form-control" onclick="getDownDpName(' + 2 + ')">');

	list_output.push('<option value="선택">선택</option>');
	for(let i in _list) {
		let row = _list[i];
		let dpart_nm = row.dpart_nm;
		let dpart_index	= row.dpart_index;
		//$("#upDpart").prepend('<option value="' + dpart_index + '">' + dpart_nm + '</option>');
		list_output.push('<option value="' + dpart_index + '">' + dpart_nm + '</option>');	
		}
	list_output.push('</select>');
	
	$('#userInsertUpDp').html(list_output.join(''));
	$("#u_dpart").show();
}

// dpart.js 의 listUpDp
// **********  ********** [VIEW] 상위 부서 SELECT  목록 가져오기 **********  **********
function userViewUpDpCallback(data) {
	
	let _list = data.data.contents.list;
	let view_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	
	// onClick : 상위 부서 목록 띄우기 listUpDpart()	onclick="userDpartCallback('+dpart_nm+')" 
	view_output.push('<select name="view_dpart_index" id="view_dpart_index" class="form-control" onclick="getDownDpName(' + 3 + ')">');
	for(let i in _list) {
		let row = _list[i];
		let dpart_nm = row.dpart_nm;
		let dpart_index	= row.dpart_index;
		//$("#upDpart").prepend('<option value="' + dpart_index + '">' + dpart_nm + '</option>');
			view_output.push('<option value="' + dpart_index + '">' + dpart_nm + '</option>');
	}
	view_output.push('</select>');
	$('#userViewUpDp').html(view_output.join(''));
}

// dpart.js 의 listDownDpart
// **********  ********** [INSERT] 하위 부서 SELECT  목록 가져오기 **********  **********
function userDownDpCallback(data) {
	
	let _list = data.data.contents.list;
	let list_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	// onClick : 상위 부서 목록 띄우기 listUpDpart()	onclick="userDpartCallback('+dpart_nm+')" onclick="getDownDpName()"
	list_output.push('<select name="dpart_num" id="dpart_num" class="form-control" >');
	list_output.push('<option value="선택">선택</option>');
	//view_output.push('<select name="view_dpart_num" id="view_dpart_num" class="custom-select" >');
	for(let i in _list) {
		let row = _list[i];
		let dpart_num = row.dpart_num;
		
		//$("#downDpart").prepend('<option value="' + dpart_num + '">' + dpart_num + '</option>');
		list_output.push('<option value="' + dpart_num + '">' + dpart_num + '</option>');

	}
	list_output.push('</select>');

	$('#userInsertDownDp').html(list_output.join(''));
	$("#d_dpart").show();
}

// dpart.js 의 listDownDpart
// **********  ********** [VIEW] 하위 부서 SELECT  목록 가져오기 **********  **********
function userViewDownDpCallback(data) {
	
	let _list = data.data.contents.list;
	let view_output = [];
	
	if (_list.length == 0) {
		view_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	// onClick : 상위 부서 목록 띄우기 listUpDpart()	onclick="userDpartCallback('+dpart_nm+')" onclick="getDownDpName()"
	view_output.push('<select name="view_dpart_num" id="view_dpart_num" class="form-control" >');
	for(let i in _list) {
		let row = _list[i];
		let dpart_num = row.dpart_num;
		
			view_output.push('<option value="' + dpart_num + '">' + dpart_num + '</option>');	
	}
	view_output.push('</select>');
	$('#userViewDownDp').html(view_output.join(''));;
}

// **********  ********** [INSERT] 직급 목록 가져오기 **********  **********
function getListPosi() {
	posi_num = 1;
	const URL = '/dpart/getPosiList/' + posi_num + '.json';	
	let i_output = [];
	$.getJSON(URL, function(data){

		// 직급 순차적 목록화 하기
		i_output.push('<select name="user_pst" id="user_pst" class="form-control">');
		i_output.push('<option value="선택">선택</option>');
		$.each(data, function(i, item) {
			 i_output.push('<option value="' + item.pst + '">' + item.pst + '</option>'); 
		});
		i_output.push('</select>');
		
		$('#userInsertPosi').html(i_output.join(''));
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

// **********  ********** [VIEW] 직급 목록 가져오기 **********  **********
function getListViewPosi(user_pst) {
	posi_num = 1;
	const URL = '/dpart/getPosiList/' + posi_num + '.json';	
	let i_output = [];
	$.getJSON(URL, function(data){
		
		// 직급 순차적 목록화 하기
		i_output.push('<select name="view_user_pst" id="view_user_pst" class="form-control" >');
		//console.log(data[1].pst);
		$.each(data, function(i, item) { 
			if(item.pst === user_pst){
				console.log(item.pst);
				i_output.push('<option value="' + item.pst + '" selected="selected">' + item.pst + '</option>'); 
			} 
			
			i_output.push('<option value="' + item.pst + '">' + item.pst + '</option>'); 
		});
		i_output.push('</select>');
		
		$('#userViewPosi').html(i_output.join(''));
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}


// **********  ********** [INSERT]  SIP LIST 사용자 등록 가져오기 **********  **********
// sip.js listSip()
function userAddSipCallback(data) {
	let _list = data.data;	// 데이터 배열
	let list_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	
	list_output.push('<select name="svr_id" id="svr_id" class="form-control" >');
	for(let i in _list) {
		let row = _list[i];	
		let svr_type = row.svr_type;
		let svr_id = row.svr_id;
	
		if(svr_type === 'SIP') {
			list_output.push('<option value="' + svr_id + '">' + svr_id + '</option>');
		}
		
	}
	
	list_output.push('</select>');
	
	$("#userInsertSip").html(list_output.join(''));
}

// **********  ********** [VIEW] SIP LIST 사용자 수정 **********  **********
function userModSipCallback(data) {
	let _list = data.data;	// 데이터 배열
	let list_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	
	list_output.push('<select name="view_svr_id" id="view_svr_id" class="form-control" >');
	for(let i in _list) {
		let row = _list[i];	
		let svr_type = row.svr_type;
		let svr_id = row.svr_id;
		
		if(svr_type === 'SIP') {
			list_output.push('<option value="' + svr_id + '">' + svr_id + '</option>');
		}
		
	}
	
	list_output.push('</select>');
	
	$("#userViewSip").html(list_output.join(''));
}


// **********  ********** MQTT 목록 가져오기 **********  **********
// MQTT 목록
function userMqtt(){
	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":sendTime(),
		"snd_type":"request",
		"command":"mqsvr_list",
		"contents":{}
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/svr",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			// insertUser.jsp 의 mqtt
	    	data.is_success ? (userMqttCallback(data), ueerViewMqttCallback(data)) : alert('MQTT 목록 실패');	    	
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

// **********  ********** [INSERT] MMQTT LIST 사용자 등록 **********  **********
function userMqttCallback(data) {
	let _list = data.data.contents.list;	// 데이터 배열
	let list_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 MQTT가 존재하지 않습니다.</h6>");
		return;
	}
	
	// mqtt 순차적 목록화 하기
	list_output.push('<select name="mqtt_id" id="mqtt_id" class="form-control" >');
	for(let i in _list) {
		let row = _list[i];
		//let mqtt_ip = row.mqtt_svr_ip;
		let mqtt_id = row.mqtt_svr_id;
		
		list_output.push('<option value="' + mqtt_id + '">' + mqtt_id + '</option>');	
	}
	list_output.push('</select>');
	$("#userInsertMqtt").html(list_output.join(''));
	
}

// **********  ********** [VIEW]  MMQTT LIST 사용자 수정 **********  **********
function ueerViewMqttCallback(data) {
	let _list = data.data.contents.list;	// 데이터 배열
	let list_output = [];
	
	if (_list.length == 0) {
		list_output.push("<h6 style='color:red;'>등록된 글이 존재하지 않습니다.</h6>");
		return;
	}
	
	// mqtt 순차적 목록화 하기
	list_output.push('<select name="view_mqtt_id" id="view_mqtt_id" class="form-control" >');
	for(let i in _list) {
		let row = _list[i];
		//let mqtt_ip = row.mqtt_svr_ip;
		let mqtt_id = row.mqtt_svr_id;
		
		list_output.push('<option value="' + mqtt_id + '">' + mqtt_id + '</option>');	
	}
	list_output.push('</select>');
	$("#userViewMqtt").html(list_output.join(''));
}