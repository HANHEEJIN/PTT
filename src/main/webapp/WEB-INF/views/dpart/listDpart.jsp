<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function() { 	
	listDpart(); 
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modDpart() : false; }); // 부서 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delDpart() : false; }); // 부서 삭제 버튼
	
	listCom(); 		 // 회사 목록
});

</script>




<%@ include file="../include/top.jsp"%> <!-- 상단(HEADER) -->
<!-- Page Wrapper -->
<div id="wrapper">
	<%@ include file="../include/nav.jsp"%> <!-- 메뉴(NAV) -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
    <div id="content"> <br><br>
    
    <div class="container-fluid">
		<div class="row gutters">
			<div class="col-lg-8">
				<div class="card h-100">
					<div class="card-body">
						<!--  추가 BEGIN --> 
						<!-- <h2>부서</h2><br> -->
						
						<div class="row">
							<div class="col-xl-10 col-lg-10 col-md-10 col-sm-10 col-10">
								<div class="form-group">
							 		<div class="input-group">
										<input type="text" class="form-control" id="input-search" placeholder="검색어를 입력해 주세요.">
										<div class="input-group-append"><button type="button" id="btn-search" class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button></div>
									</div>
								</div>
						 		
						 		<!-- <div class="col-1"><button type="button" class="btn btn-sm" id="btn-clear-search">취소</button></div> -->
						 	</div>
						 	<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-2 text-right"><a href="<c:url value='/dpart/downloadExel' />" class="btn btn-sm btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
			            </div>
            			
      					<div id="treeview1" class="treeview"> </div>

					</div>
				</div>
			</div>
			
			<div class="col-lg-4">
				<div class="card h-100">
					<div class ="card-body">
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">상세 정보</h6></div>
					</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-12">
							<div class="form-group">
								<label for="company">회사</label>
								<input type="text" class="form-control" name="list_view_co_num" id="list_view_co_num" >
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="com_id">번호</label>
								<input type="text" class="form-control" name="list_view_co_num" id="list_view_co_num" placeholder="회사번호" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-12">
							<div class="form-group">
								<label for="up_dpart">상위부서</label>
								<input type="text" class="form-control" name="list_view_upDp" id="list_view_upDp" readonly>
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="up_id">상위번호</label>
								<input type="text" class="form-control" name="list_view_upId" id="list_view_upId" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-8 col-sm-8 col-12">
							<div class="form-group">
								<label for="down_dpart">하위부서</label>
								<input type="text" class="form-control" name="lsit_view_change_nm" id="lsit_view_change_nm">
								<input type="hidden" name="list_view_downDp" id="list_view_downDp">
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="down_id">하위번호</label>
								<input type="text" class="form-control" name="list_view_downId" id="list_view_downId" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="type">타입</label>
								<input type="text" class="form-control" name="list_view_type" id="list_view_type" readonly>
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="level">레벨</label>
								<input type="text" class="form-control" name="list_view_level" id="list_view_level" readonly>
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12">
							<div class="form-group">
								<label for="editor">작성자</label>
								<input type="text" class="form-control" name="list_view_editor" id="list_view_editor" value="${sessionId.user_id}" readonly>
							</div>
						</div>
					</div>
		
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="text-right">
								<button type="button" id="btnUpdate" onclick='modDpart(3);' class="btn btn-outline-primary">수정</button>
								<button type="button" id="btnDelete"  onclick='delDpart(3);' class="btn btn-outline-danger">삭제</button>
								<button type="reset" class="btn btn-outline-secondary">취소</button>
							</div>
						</div>
					</div>
					</div>
				
				</div>
			</div>
			<!-- END 부서 상세 보기  -->
		</div>
		
		</div>
       </div>
       

       
		<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
		
    </div>
    <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

</body>

</html>