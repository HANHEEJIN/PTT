<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function() {
	listEqp(1);
	$('#btnInsert').click(function() { confirm('등록하시겠습니까?') ? addEqp() : false; }); // 장비 수정 버튼
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modEqp() : false; }); // 장비 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delEqp() : false; }); // 장비 삭제 버튼
});




</script>
<%@ include file="../include/top.jsp"%> <!-- 상단(HEADER) -->
<!-- Page Wrapper -->
<div id="wrapper">
<%@ include file="../include/nav.jsp"%> <!-- 메뉴(NAV) -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
		<!-- Main Content -->
		<div id="content"> <br><br>
		<!-- start container -->
	    <div class="container-fluid">

		 <div class="row gutters"> <!-- start roe gutters -->
			<div class="col-lg-4">
				<div class="card h-100">
					<div class="card-body">
					<!--  추가 BEGIN -->
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">장비 정보 등록</h6></div>
					</div>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="id">ID</label>
								<input type="text" class="form-control" name="eqp_id" id="eqp_id" > 
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="name">이름</label>
								<input type="text" class="form-control" name="eqp_nm" id="eqp_nm">
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="type">유형</label>
								<input type="text" class="form-control" name="eqp_typ" id="eqp_typ">
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="company">회사코드</label>
								<input type="text" class="form-control" name="co_num" id="co_num">
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">관리자</label>
								<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="text-right">
								<button type="button" id="btnInsert" class="btn btn-outline-primary">추가</button>
							</div>
						</div>
					</div>
					<!--  추가 END -->
					</div>
				</div>
			</div>
		 	<!-- Start col -->
			<div class="col-lg-8">
				<div class="card h-100">
					<div class="card-body">
						<!-- EQP 추가 BEGIN -->
						<%--  <%@ include file="../search/uSearch.jsp" %>  --%>
						<div class="col-lg-12 mt-4 mt-lg-0">
						<div class="row gutters">
						<div class="col-md-12">
						<div class="user-dashboard-info-box table-responsive mb-0 bg-white p-4 bg-white">
						<!-- Begin Page Content --> <!-- <div class="container-fluid">  <h1 class="h3 mb-4 text-gray-800">장비 목록</h1> </div> -->
						
						<!-- <nav class="navbar navbar-expand-sm bg-primary navbar-light"></nav> -->
						<!-- Begin 사용자 검색 -->
						<div class="row no-gutters">
							<!-- <div class="col-10"><h1>사용자 목록</h1></div> -->
							<div class="col-lg-2 col-md-2 col-sm-12 p-0"></div>
							<div class="col-lg-2 col-md-2 col-sm-12 p-0">
								<select name="searchType" id="searchType" class="form-control" >
									<option value="all" selected>선택</option>					 
									<option value="equip_num">번호</option>
									<option value="eqp_id">ID</option>
									<option value="eqp_nm">이름</option>
									 <option value="co_num">회사</option>
								</select>
															
							 </div>
							<div class="col-lg-5 col-md-5 col-sm-12 p-0">
								<div class="input-group">
									<input type="text" class="form-control small" name="keyword" id="keyword" placeholder="검색어"/>
									<div class="input-group-append">
										<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
										<button type="button" id="searchBtn" onclick="searchCheckEqp(1);"class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button>
									</div>
								</div>
							</div>
						
							<div class="col-lg-3 col-md-3 col-sm-12 p-0 text-right"> <a href="<c:url value='/equip/downloadExel' />" class="btn btn btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
						</div> <br>
						<!-- END 검색 -->
						
						<table class="table  mb-0  text-center" >
						<thead class="thead-light">
							<tr class="table-active"> <th>번호</th> <th>장비번호</th> <th>ID</th> <th>이름</th> <th>타입</th> <th>회사</th> </tr>
						</thead>
						<tbody id="tbody">
						
						</tbody>	
						</table>
						
						<input type='hidden' id='page' name='page' value='1' /><br>
						<!-- 페이징 --> <div id="pageing"></div>
						
						<!-- 페이징(paging) -->
						</div>
						</div>
						</div>
						</div>
						<!-- EQP 추가 END -->
					</div>
				</div>
			</div> <!--  End col -->
			
			
			<!-- Begin Modal -->
			<div class="modal" id="eqpInfo">
				<div class="modal-dialog modal-dialog-centered" >
					<div class="modal-content">
					      
					    <!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title text-primary">장비 상세 정보</h5>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>
						        
						<!-- Modal body -->
						<div class="modal-body" >

							<!-- <div class="row gutters">
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">장비 상세 정보</h6></div>
							</div> -->
							<div class="row gutters">
								<div class="col-xl-3 col-lg-3 col-md-3 col-sm-12 col-12">
									<div class="form-group">
										<label for="num">번호</label>
										<input type="text" class="form-control" name="view_num" id="view_num" > 
									</div>
								</div>
								<div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="id">ID</label>
										<input type="text" class="form-control" name="view_id" id="view_id" > 
									</div>
								</div>
							</div>
							<div class="row gutters">
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="name">이름</label>
										<input type="text" class="form-control" name="view_nm" id="view_nm">
									</div>
								</div>
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="type">유형</label>
										<input type="text" class="form-control" name="view_type" id="view_type">
									</div>
								</div>
							</div>
							<div class="row gutters">
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="editor">회사코드</label>
										<input type="text" class="form-control" name="co_num" id="co_num">
									</div>
								</div>
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="id">관리자</label>
										<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly>
									</div>
								</div>
							</div>
						</div>
							
			        
						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" id="btnUpdate" class="btn btn-outline-primary">수정</button>
							<button type="button" id="btnDelete" class="btn btn-outline-danger">삭제</button>
							<button type="reset" class="btn btn-outline-secondary" data-dismiss="modal">취소</button>
						</div>
					        
					</div>
				</div>
			</div>
			<!-- End Modal -->
						
	
            <br><br>
			
		</div><!-- end roe gutters -->
		
		</div> <!-- container-fluid -->
		
		</div> <!-- End Main content -->
		<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->		
    </div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>