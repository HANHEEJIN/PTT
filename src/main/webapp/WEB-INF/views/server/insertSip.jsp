<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function(){
	$("#btnInsert").click(function() {
		
		addSip();
	});
});

function addSip() {
	//debugger;
	let id = $('#sip_id').val();
	let ip = $('#sip_ip').val();
	let port = $('#sip_port').val();
	let type = $('#sip_type').val();

	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"svr_regist",
	    "contents":{
	            "svr_id"	: id,
	            "svr_ip"	: ip,
	            "svr_port"	: port,
	            "svr_type"	: type
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/svr',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('SIP 등록 성공');
		    	window.location.href = '${pageContext.request.contextPath}/server/listSip.do'; 		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('SIP 등록 실패');
	    		//return;
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
		<form name="frmSip" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
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
							<input type="text" class="form-control" name="sip_id" id="sip_id" value="sip02">
	 					</div>
	 				</td>
					<td> 
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">IP</span>
							</div>
							<input type="text" class="form-control" name="sip_ip" id="sip_ip" value="211.119.132.244" >
	 					</div>
	 				</td>
	 				
					<td> 
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">PORT</span>
							</div>
							<input type="text" class="form-control" name="sip_port" id="sip_port"  value="5060" readonly>
	 					</div>
	 				</td>
	 				
	 				<td> 
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">TYPE</span>
							</div>
							<input type="text" class="form-control" name="sip_type" id="sip_type"  value="gk" readonly>
	 					</div>
	 				</td>
	 				
				</tr>
				
				<tr>
					<td colspan="2">
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