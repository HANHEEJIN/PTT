<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<style> span { display:inline-block; width:100px; font-size:small; text-align:center;} </style>
<script type="text/javascript">
$(document).ready(function() {
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modDpart() : false; }); // 부서 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delDpart() : false; }); // 부서 삭제 버튼
});

// 부서 수정
function modDpart(){
	//debugger;
	//var num = $('#user_num').val();
	let dpart_num = $('#dpart_num').val();
	let nm = $('#dpart_nm').val();
	let typ = $('#dpart_typ').val();
	let up_dpart = $('#uppr_dpart_num').val();
	let editor = $('#editor').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"2021-01-01 22:14:16",
	    "snd_type":"request",
	    "command":"dpart_update",
	    "contents":{
	        "user_num"		: 152,
	        "dpart_num"		: dpart_num,
	        "dpart_nm"		: nm,
	        "dpart_typ"		: typ,
	        "up_dpart_num"	: up_dpart,
	        "editor"		: "bibi"
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/dpart',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('부서 정보 수정 성공');
		    	window.location.href = '${pageContext.request.contextPath}/dpart/listDpart.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('부서 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


// 부서 삭제
function delDpart(){
	let dpart_num = $('#dpart_num').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"2021-01-01 22:14:16",
	    "snd_type":"request",
	    "command":"dpart_delete",
	    "contents":{
	        "dpart_num" : dpart_num
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/dpart',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('부서 정보 삭제 성공');
		    	window.location.href = '${pageContext.request.contextPath}/dpart/listDpart.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('부서 정보 삭제 실패');
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
            <h1 class="h3 mb-4 text-gray-800">부서 상세 정보</h1>
        </div>
        <!-- /.container-fluid -->
		<form name="frmDpart" 	method="POST"  onsubmit='return false'>
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
						<span class="input-group-text" >번호</span>
					</div>
					<input type="text" class="form-control" name="dpart_num" id="dpart_num" value="${VDPART.dpart_num}" readonly>
				</div>
			</td>
			<td>
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text">부서명</span>
					</div>
					<input type="text" class="form-control" name="dpart_nm" id="dpart_nm" value="${VDPART.dpart_nm}" >
				</div>

			</td>
			

		</tr>
		<tr>
			<td> 
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text">부서유형</span>
					</div>
					<input type="text" class="form-control" name="dpart_typ" id="dpart_typ"  value="${VDPART.dpart_typ}"></input>
				</div>
			</td>
						<td> 
				<div class="input-group mb-3 input-group-sm">
					<div class="input-group-prepend">
						<span class="input-group-text" >상위부서번호</span>
					</div>
					<input type="text" class="form-control" name="uppr_dpart_num" id="uppr_dpart_num" value="${VDPART.uppr_dpart_num}">
				</div>
			</td>
		</tr>		
		<tr>
			<td>
				<button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/dpart/listDpart.do'">목록</button>
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