<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp"%>  <!-- 헤더(HEADER) -->
<%@ include file="./include/top.jsp"%> <!-- 상단(HEADER) -->

<script src="${path}/resources/js/posInfo.js"></script>
<script src="${path}/resources/js/mqtt.js"></script>

 <!-- Page Wrapper -->
<div id="wrapper">
	<%@ include file="./include/nav.jsp"%> <!-- 메뉴(NAV) -->
	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
		<!-- Main Content -->
		<div id="content">
			<div class="container-fluid">
	            <!-- Page Heading --><br><br>
	            <button type="button" id="btnEncrypt" class="btn btn-primary">암호화</button>
	            <button type="button" id="btnDecrypt" class="btn btn-primary">복호화</button>
	            <button type="button" id="btnGet" class="btn btn-primary">조회</button>
	            <br>
	            <input type="text" class="form-control" id="textDec" name="textDec" size="20">            
	            <br>

	            <div id="encrypt"></div>
	            <div id="decrypt"></div>   
	            <div id="getDecrypt"></div>       
	        </div>
			
		</div> <!-- End of Main Content -->
		<%@ include file="./include/footer.jsp"%>  <!-- 하단(FOOTER) -->
	</div> <!-- End of Content Wrapper -->
	
</div> <!-- End of Page Wrapper -->
</body>

<script type="text/javascript">
$(document).ready(function() { 
	$('#btnEncrypt').click(function() { confirm('암호화 하시겠습니까?') ? encrypt() : false; }); 
	$('#btnDecrypt').click(function() { confirm('복호화 하시겠습니까?') ? decrypt() : false; }); 
	$('#btnGet').click(function() { confirm('복호화 하시겠습니까?') ? getAes(5) : false; }); 
	
});


// ********** ********** ********** 암호화 ********** ********** **********
function encrypt() {
	let id = "ADMIN";
	let pw = "1234";
	let oParam = 
	{
	    "user_no" : 2,
	    "user_id" : id,
	    "user_pw" : pw,
	};

	$.ajax({
		url : '/aes/encrypt',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json; charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
	    	console.log(data.data.user_pw);
			if( data.statusCode == 201 ) {	
	    		alert('암호화 성공');
	    		
	    		let list_output = [];
	    		list_output.push('<br><h5> [ 암호화 ]  ' + data.data.user_pw + '</h5>');
	    		$('#encrypt').html(list_output.join(''));
	    	} else {	    		
	    		alert('암호화 실패');
	    		//return;
	    	}
	    },
	    error: function(request, status, error) {
			alert('암호화 실패');
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:"
					+ error);
		}
	});
}

//********** ********** ********** 복호화 ********** ********** **********
function decrypt() {
	debugger;
	let textDec = $("#textDec").val();
	
	let oParam = 
	{
	    "textDec" : textDec
	};

	$.ajax({
		url : "/aes/decrypt/" + textDec,
	    type: 'GET',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json; charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	console.log(data);
			if( data.statusCode == 201 ) {	
	    		alert('복호화 성공');
	    		
	    		let list_output = [];
	    		
	    		
	    		list_output.push('<br><h5> [ 복호화 ] ' + data.data + '</h5>');
	    		$('#decrypt').html(list_output.join(''));
	    	} else {	    		
	    		alert('복호화 실패');
	    		//return;
	    	} 
	    },
	    error: function(request, status, error) {
			alert('복호화 실패');
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:"
					+ error);
		}
	});
}


//********** ********** ********** 복호화 ********** ********** **********
//getAes 상세 정보 json 데이터 가져오시
function getAes(user_no, callback, error) {

	const URL = '/aes/getAes/' + user_no + '.json';
	
	$.get(URL, function(data){
		
		console.log(data);
		let list_output = [];
		list_output.push('<br><h5> [ 복호화 ] ... ' + data.user_no + '</h5>');
		list_output.push('<br><h5> [ 복호화 ] ... ' + data.user_id + '</h5>');
		list_output.push('<br><h5> [ 복호화 ] ... ' + data.user_pw + '</h5>');
		
		$('#getDecrypt').html(list_output.join(''));
		
		
		/* 
		let view_output = [];
		view_output.push('<input type="text" class="form-control" name="view_ip" id="view_ip" value="' + data.svr_num + '" >');
		view_output.push('<input type="text" class="form-control" name="view_num" id="view_num" value="' + data.svr_id + '" >');
		view_output.push('<input type="text" class="form-control" name="view_id" id="view_id" value="' + data.svr_ip + '" >');
		view_output.push('<input type="text" class="form-control" name="view_port" id="view_port" value="' + data.svr_port + '" readonly>');
		view_output.push('<input type="text" class="form-control" name="view_type" id="view_type" value="' + data.svr_type + '"  readonly>');
		$('#getSip').html(view_output.join(''));
		 */	
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}



</script>
</html>