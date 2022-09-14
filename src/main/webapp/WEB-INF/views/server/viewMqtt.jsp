<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<style>
	span { display:inline-block; width:100px; font-size:small; text-align:center;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$('#btnDelete').click(function() {		
		if(confirm('삭제하시겠습니까?')){
			delMqtt();			
		} else{
			return false;
		}
	});
});


$(document).ready(function(){
	$('#btnUpdate').click(function() {
		if(confirm('수정하시겠습니까?')){
			modMqtt();
		} else {
			return false;
		}
	});
});

// MQTT 수정
function modMqtt(){
	//debugger;
	let id = $('#mqtt_svr_id').val();
	let ip = $('#mqtt_svr_ip').val();
	let port = $('#mqtt_svr_port').val();
	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"mqsvr_update",
	    "contents":{
	            "mqtt_svr_id"	: id,
	            "mqtt_svr_ip"	: ip,
	            "mqtt_svr_port" : port
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/svr',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('MQTT 정보 수정 성공');
		    	window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('MQTT 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


// MQTT 삭제
function delMqtt(){
	//debugger;
	let id = $('#mqtt_svr_id').val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"mqsvr_delete",
	    "contents":{
	            "mqtt_svr_id" : id
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/svr',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('MQTT 정보 삭제 성공');
		    	window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('MQTT 정보 삭제 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
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
            <h1 class="h3 mb-4 text-gray-800">SIP 추가</h1>
        </div>
        <!-- /.container-fluid -->
		<form name="frmMqtt" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
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
								<span class="input-group-text" >ID</span>
							</div>
							<input type="text" class="form-control" name="mqtt_svr_id" id="mqtt_svr_id" value="${QVIEW.mqtt_svr_id}">
	 					</div>
	 				</td>
					<td> 
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">IP</span>
							</div>
							<input type="text" class="form-control" name="mqtt_svr_ip" id="mqtt_svr_ip" value="${QVIEW.mqtt_svr_ip}">
	 					</div>
	 				</td>
	 				
					<td> 
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">PORT</span>
							</div>
							<input type="text" class="form-control" name="mqtt_svr_port" id="mqtt_svr_port" value="${QVIEW.mqtt_svr_port}" readonly>
	 					</div>
	 				</td>
				</tr>
				
				<tr>
					<td>
						<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/server/listMqtt.do'">목록</button>
						<button type="button" id="btnUpdate" class="btn btn-success">수정</button>
						<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
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