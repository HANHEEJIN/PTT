<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<style> span { display:inline-block; width:70px; font-size:small; text-align:center;} </style>
<script type="text/javascript">
$(document).ready(function() {
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modEqp() : false; }); // 장비 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delEqp() : false; }); // 장비 삭제 버튼
});


// 장비 수정
function modEqp(){
	//debugger;
	let num = $('#equip_num').val();
	let id = $('#eqp_id').val();
	let nm = $('#eqp_nm').val();
	let typ = $('#eqp_typ').val();
	let editor = $('#editor').val();

	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":"2021-01-01 22:14:16",
		"snd_type":"request",
		"command":"dvc_update",
	    "contents":{
	    		"equip_num" : num,
	            "eqp_id"	: id,
	            "eqp_nm"	: nm,
	            "eqp_typ"	: typ,
	            "editor"	: editor
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('장비 정보 수정 성공');
		    	window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


// 장비 삭제
function delEqp(){
	let num = $('#equip_num').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"2021-01-01 22:14:16",
	    "snd_type":"request",
	    "command":"dvc_delete",
	    "contents":{ "equip_num" : num }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('장비 정보 삭제 성공');
		    	window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 정보 삭제 실패');
	    		return;
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
                <h1 class="h3 mb-4 text-gray-800">장비 정보 수정</h1>
            </div>
            <!-- /.container-fluid -->
			<form name="frmEqp" method="POST"  onsubmit='return false'>
			<table class="table mb-0" style="width:60%; float: none; margin: 10 auto;">
			<tr>
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >장비번호</span>
						</div>
						<input type="text" class="form-control" name="equip_num" id="equip_num" value="${EVIWE.equip_num}" > 
						
					</div>
				</td>
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
						<input type="text" class="form-control" name="eqp_id" id="eqp_id" value="${EVIWE.eqp_id}" > 
						
					</div>
				</td>
				
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >이름</span>
						</div>
						<input type="text" class="form-control" name="eqp_nm" id="eqp_nm" value="${EVIWE.eqp_nm}">
					</div>
				</td>
			</tr>
			<tr>
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >유형</span>
						</div>
						<input type="text" class="form-control" name="eqp_typ" id="eqp_typ" value="${EVIWE.eqp_typ}">
					</div>
				</td>
			
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text">회사코드</span>
						</div>
						<input type="text" class="form-control" name="co_num" id="co_num" value="${EVIWE.co_num}">
					</div>

				</td>
			</tr>		
			<tr>
				<td>
					<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/equip/listEqp.do'">목록</button>
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