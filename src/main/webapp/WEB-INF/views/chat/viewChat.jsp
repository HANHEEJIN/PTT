<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->

<style> span { display:inline-block; width:70px; font-size:small; text-align:center;} </style>
<script type="text/javascript">
$(document).ready(function() {
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modChat() : false; }); // 장비 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delChat() : false; }); // 장비 삭제 버튼
});


// 대화발 수정
function modChat(){ }

// 대화방 삭제
function delChat(){ }
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
            <h1 class="h3 mb-4 text-gray-800"> 대화방 상세 정보</h1>
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
						<input type="text" class="form-control" name="editor" id="editor" value="${sessionScope.LOGIN.user_id}" readonly>
					</div>
				</td>
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >번호</span>
						</div>
						<input type="text" class="form-control" name="chat_room_num" id="chat_room_num" value="${CVIWE.chat_room_num}" readonly> 
						
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >이름</span>
						</div>
						<input type="text" class="form-control" name="chat_room_nm" id="chat_room_nm" value="${CVIWE.chat_room_nm}"> 
						
					</div>
				</td>
				
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >접속번호</span>
						</div>
						<input type="text" class="form-control" name="chat_room_conn_num" id="chat_room_conn_num" value="${CVIWE.chat_room_conn_num}">
					</div>
				</td>
			</tr>
			<tr>
				<td> 
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text" >비밀번호</span>
						</div>
						<input type="password" class="form-control" name="chat_room_pwd" id="chat_room_pwd" >
					</div>
				</td>
			
				<td>
					<div class="input-group mb-3 input-group-sm">
						<div class="input-group-prepend">
							<span class="input-group-text">방코드</span>
						</div>
						<input type="text" class="form-control" name="chat_room_typ" id="chat_room_typ" value="${CVIWE.chat_room_typ}">
					</div>
	
				</td>
			</tr>		
			<tr>
				<td>
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