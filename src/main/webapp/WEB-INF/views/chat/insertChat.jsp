<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">


function addChat() {
	//debugger;
	let nm = $('#chat_room_nm').val();
	let conn = $('#chat_room_conn_num').val();
	let pw = $('#chat_room_pwd').val();
	let typ = $('#chat_room_typ').val();
	let editor = $("#editor").val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"2021-01-01 22:14:16",
	    "snd_type":"request",
	    "command":"room_create",
	    "contents":{
	            "user_num"		 : 155,
	            "chat_room_nm"	 : nm,
	            "chat_room_pwd"	 : pw,
	            "chat_room_type" : typ,
	            "editor"		 : "ggg"
	    }
	}
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/room',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('대화방 등록 성공');
		    	window.location.href = '${pageContext.request.contextPath}/chat/listChat.do'; 		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('대화방 등록 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	debugger;
	    }
	});
}
</script>

<%@ include file="../include/top.jsp"%> <!-- 상단(HEADER) -->
<!-- Page Wrapper -->
<div id="wrapper">

<%@ include file="../include/nav.jsp"%> <!-- 메뉴(NAV) -->

<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

    <!-- Main Content -->
    <div id="content">
        <!-- Begin Page Content -->
        <div class="container-fluid">
            <!-- Page Heading -->
            <h1 class="h3 mb-4 text-gray-800">대화방 개설</h1>
        </div>
        <!-- /.container-fluid -->
		<form name="frmChat" method="POST"  onsubmit='return false'>
		<table class="table mb-0" style="width:60%; float: none; margin: 10 auto;">
			<tr>
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >관리자</span>
						</div>
						<input type="text" class="form-control" name="editor" id="editor" value="${sessionId}" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >방이름</span>
						</div>
						<input type="text" class="form-control" name="chat_room_nm" id="chat_room_nm"> 
						
					</div>
				</td>
				
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >방접속번호</span>
						</div>
						<input type="text" class="form-control" name="chat_room_conn_num" id="chat_room_conn_num">
					</div>
				</td>
			</tr>
			<tr>
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >방비밀번호</span>
						</div>
						<input type="text" class="form-control" name="chat_room_pwd" id="chat_room_pwd">
					</div>
				</td>
			
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text">방코드</span>
						</div>
						<input type="text" class="form-control" name="chat_room_typ" id="chat_room_typ">
					</div>
	
				</td>
			</tr>		
			<tr>
				<td>
					<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/chat/listChat.do'">목록</button>
					<button type="button" id="btnInsert" class="btn btn-primary">등록</button>
					<button type="reset" class="btn btn-primary">취소</button>
				</td>
			</tr>
		</table>
		</form>
	
    </div>
    <!-- End of Main Content -->   
<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
	
</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

</body>

</html>