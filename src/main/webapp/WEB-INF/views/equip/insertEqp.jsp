<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->

<script type="text/javascript">
$(document).ready(function(){
	$('#btnInsert').click(function() {
		if(confirm('등록하시겠습니까?')){
			addEqp();
		} else {
			return false;
		}
	});
});

function addEqp() {
	let id = $('#eqp_id').val();
	let nm = $('#eqp_nm').val();
	let typ = $('#eqp_typ').val();
	let code = $('#co_num').val();
	let editor = $("#editor").val();
	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"dvc_regist",
	    "contents":{
	            "eqp_id"    : id,
	            "eqp_nm"    : nm,
	            "eqp_typ"   : typ,
	            "co_num"	: code,
	            "editor"    : editor
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('장비 등록 성공');
		    	window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do'; 		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 등록 실패');
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
            <h1 class="h3 mb-4 text-gray-800">장비 등록</h1>
        </div>
        <!-- /.container-fluid -->
        
        <form name="frmEqp" method="POST"  onsubmit='return false'>
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
						<span class="input-group-text" >장비ID</span>
					</div>
					<input type="text" class="form-control" name="eqp_id" id="eqp_id" value="33:34:AB:BB:CB:21" > 
					
				</div>
			</td>
			
			<td> 
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text" >이름</span>
					</div>
					<input type="text" class="form-control" name="eqp_nm" id="eqp_nm">
				</div>
			</td>
		</tr>
		<tr>
			<td> 
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text" >유형</span>
					</div>
					<input type="text" class="form-control" name="eqp_typ" id="eqp_typ">
				</div>
			</td>
		
			<td>
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text">회사코드</span>
					</div>
					<input type="text" class="form-control" name="co_num" id="co_num">
				</div>

			</td>
		</tr>		
		<tr>
			<td>
				<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/equip/listEqp.do'">목록</button>
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