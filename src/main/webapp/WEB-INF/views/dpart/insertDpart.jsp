<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function(){
	// 회사 
	listCom(1);
	$('#btnComInsert').click(function() { confirm('등록하시겠습니까?') ? addCom() : false; }); // 회사 추가 버튼
	$('#btnComUpdate').click(function() { confirm('수정하시겠습니까?') ? modCom() : false; }); // 회사 수정 버튼
	$('#btnComDelete').click(function() { confirm('삭제하시겠습니까?') ? delCom() : false; }); // 회사 삭제 버튼
	
	// 상위 부서
	//listDpart();
	$('#btnInsert').click(function() { confirm('등록하시겠습니까?') ? addDpart() : false; }); // 부서 추가 버튼
	$('#btnDownInsert').click(function() { confirm('등록하시겠습니까?') ? addDown() : false; }); // 하위부서 추가 버튼
});
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
            <div class="container-fluid"><br><br>

				<div class="row gutters">
					<div class="col-4">
						<div class="card h-100">
							<div class="card-body">
								<!-- 회사코드 추가 BEGIN -->
								<div class="row gutters">
									<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">회사 정보 등록</h6></div>
									<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
										<div class="form-group">
											<label for="name">이름</label>
											<input type="text" class="form-control" name="co_name" id="co_name" placeholder="회사명">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
										<div class="form-group">
											<label for="code">코드</label>
											<input type="text" class="form-control" name="co_num" id="co_num" placeholder="회사코드명">
										</div>
									</div>
									<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
										<div class="form-group">
											<label for="editor">관리자</label>
											<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly>
										</div>
									</div>
								</div>

								
								<div class="row gutters">
										<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<%-- <label for="editor">관리자 ${sessionId}</label> --%>
												<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
											</div>
										</div>						
										<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
											<div class="text-right">
												<button type="button" id="btnComInsert" class="btn btn-outline-primary">추가</button>
											</div>
										</div>
									</div>
								<!-- 회사코드 추가 END -->
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card h-100">
							<div class="card-body">
								<!--  상위 부서 추가 BEGIN -->
								<div class="row gutters">
										<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">상위 부서 등록</h6></div>
										<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<label for="code">회사코드</label>
												<input type="text" class="form-control" name="up_co_num" id="up_co_num"  value="GHS"  readonly>
											</div>
										</div>
										<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<label for="name">이름</label>
												<input type="text" class="form-control" name="up_dpart_nm" id="up_dpart_nm" placeholder="부서이름">
											</div>
										</div>
										<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<label for="type">타입</label>
												<input type="text" class="form-control" name="up_dpart_typ" id="up_dpart_typ" value="Y">
											</div>
										</div>
										<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<label for="level">레벨</label>
												<input type="text" class="form-control" name="up_dpart_num" id="up_dpart_num" value="1" readonly>
											</div>
										</div>
										
										
									</div>
									<div class="row gutters">
										<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
											<div class="form-group">
												<%-- <label for="editor">관리자 ${sessionId}</label> --%>
												<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
											</div>
										</div>						
										<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
											<div class="text-right">
												<button type="button" id="btnInsert" class="btn btn-outline-primary">추가</button>
											</div>
										</div>
									</div>
								<!-- 상위 부서 추가 END -->
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="card h-100">
							<div class="card-body">
							<!-- 하위부서 추가 BEGIN -->
							<div class="row gutters">
							
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">하위 부서 등록</h6></div>
								<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="code">회사코드</label>
										<input type="text" class="form-control" name="down_co_num" id="down_co_num"  value="GHS"  readonly>
										<%-- <input type="hidden" class="form-control" name="editor" id="editor"  value="${sessionId.user_id}" readonly> --%>
									</div>
								</div>
								<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="parent">상위번호</label>
										<input type="text" class="form-control" name="parent_id" id="parent_id" placeholder="부모번호" readonly >
									</div>
								</div>
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="name">이름</label>
										<input type="text" class="form-control" name="down_dpart_nm" id="down_dpart_nm" placeholder="하위부서이름" >
									</div>
								</div>
								<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="type">타입</label>
										<input type="text" class="form-control" name="down_dpart_typ" id="down_dpart_typ" value="Y">
									</div>
								</div>
								<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="level">레벨</label>
										<input type="text" class="form-control" name="down_uppr_dpart_num" id="down_uppr_dpart_num" value="2" readonly>
									</div>
								</div>
							</div>
							<div class="row gutters">
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<%-- <label for="editor">관리자 ${sessionId}</label> --%>
										<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
									</div>
								</div>
								<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
									<div class="text-right">
										<button type="button" id="btnDownInsert" class="btn btn-outline-primary">추가</button>
									</div>
								</div>
							</div>
							<!-- 하위부서 추가 END -->
							</div> <!-- End card-body -->
						</div> <!-- End card -->
					</div> <!-- End col -->
										
					<!-- Begin 회사 목록 -->
					<div class="col-4"> <br>
						<div class="card h-100">
							<div class="card-body">							
								<!--  목록 BEGIN -->
								<div  class="table-responsive">
								<table class="table manage-candidates-top mb-0  text-center w-outo">
									<thead class="thead-light"> <tr> <th>코드</th> <th>회사명</th> <th>번호</th> <!--<th>EDITOR</th> <th>DELETE</th> --> </tr> </thead>
									<tbody id="tbodyCom"></tbody>	
								</table>
								</div>
								<!--  목록 END -->
							</div> <!-- End card-body -->
						</div> <!-- End card -->
					</div> <!-- End col -->
					<!-- End 회사 목록 -->
					
					<!--  Begin 상위 부서 목록 -->
					<div class="col-4"> <br>
						<div class="card h-100">
							<div class="card-body">
								<!--  목록 BEGIN -->
								<div  class="table-responsive">
								<table class="table manage-candidates-top mb-0  text-center w-outo">
									<thead class="thead-light"> <tr> <th>부서</th> <th>이름</th> <th>코드</th> <!-- <th>DELETE</th> --> </tr> </thead>
									<tbody id="tbodyDpart"></tbody>	
								</table>
								</div>
								<!--  목록 END -->
							</div> <!-- End card-body -->
						</div> <!-- End card -->
					</div> <!-- End col -->
					<!-- End 상위 부서 목록 -->
					
					<!--  Begin 하위 부서 목록 -->
					<div class="col-4"> <br>
						<div class="card h-100">
							<div class="card-body">
								<!--  목록 BEGIN -->
								<div  class="table-responsive">
								<table class="table manage-candidates-top mb-0  text-center w-outo">
									<thead class="thead-light"> <tr> <th>부서</th> <th>이름</th> <th>코드</th> <!-- <th>DELETE</th> --> </tr> </thead>
									<tbody id="tbodyDown"></tbody>	
								</table>
								</div>
								<!--  목록 END -->
							</div> <!-- End card-body -->
						</div> <!-- End card -->
					</div> <!-- End col -->
					<!-- End 하위 부서 목록 -->
					
					<!-- Begin 회사 상세보기 -->
					<div class="col-4"> <br><br>
					<div class="card h-100">
						<div class ="card-body">
							<div class="row gutters">
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">회사 상세 정보</h6></div>
							</div>
							<div class="row gutters">
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="company">번호</label>
										<input type="text" class="form-control" name="view_co_index" id="view_co_index" readonly >
									</div>
								</div>
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="com_id">이름</label>
										<input type="text" class="form-control" name="view_co_name" id="view_co_name" placeholder="회사이름" >
									</div>
								</div>
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="com_id">코드</label>
										<input type="text" class="form-control" name="view_co_num" id="view_co_num" placeholder="회사코드">
									</div>
								</div>
							</div>
							<div class="row gutters">
								<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<%-- <label for="editor">관리자 ${sessionId}</label> --%>
										<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
									</div>
								</div>
								<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
									<div class="form-group text-right"> <label for="btn"> &nbsp;</label>
										<button type="button" id="btnComUpdate" class="btn btn-outline-primary">수정</button>
										<button type="button" id="btnComDelete" class="btn btn-outline-danger">삭제</button>
										<!-- <button type="reset" class="btn btn-secondary">취소</button> -->
									</div>
								</div>
							</div>
						</div> <!-- End card-body -->
					</div> <!-- End card -->
				</div> <!-- End col -->
				<!-- END 회사 상세 보기  -->
				
				
				<!-- Begin 상위 부서 상세보기 -->
					<div class="col-4"> <br><br>
					<div class="card h-100">
						<div class ="card-body">
							<div class="row gutters">
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">상위 부서 상세 정보</h6></div>
							</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="company">회사</label>
								<input type="text" class="form-control" name="view_co_name" id="view_co_name" readonly>
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="com_id">코드</label>
								<input type="text" class="form-control" name="view_co_num" id="view_co_num" placeholder="회사코드" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="up_dpart">상위부서</label>
								<input type="text" class="form-control" name="view_ch_up_name" id="view_ch_up_name" >
								<input type="hidden" name="view_up_name" id="view_up_name">
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="up_id">상위번호</label>
								<input type="text" class="form-control" name="view_up_index" id="view_up_index" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<%-- <label for="editor">관리자 ${sessionId}</label> --%>
									<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
							</div>
						</div>
						<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
							<div class="form-group text-right"> <label for="btn"> &nbsp;</label>
								<button type="button" id="btnUpdate" onclick='modDpart(1);' class="btn btn-outline-primary">수정</button>
								<button type="button" id="btnDelete" onclick='delDpart(1);' class="btn btn-outline-danger">삭제</button>
							</div>
						</div>
					</div>
						</div> <!-- End card-body -->
					</div> <!-- End card -->
				</div> <!-- End col -->
				<!-- END 상위 부서 상세 보기  -->
				
				
				<!-- Begin 하위 부서 상세보기 -->
					<div class="col-4"> <br><br>
					<div class="card h-100">
						<div class ="card-body">
							<div class="row gutters">
								<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">하위 부서 상세 정보</h6></div>
							</div>
					<div class="row gutters">
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="company">회사</label>
								<input type="text" class="form-control" name="view_co_name" id="view_co_name" readonly>
							</div>
						</div>
						<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="com_id">코드</label>
								<input type="text" class="form-control" name="view_co_num" id="view_co_num" placeholder="회사코드" readonly>
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="up_dpart">상위부서</label>
								<input type="text" class="form-control" name="view_up_name" id="view_up_name" readonly>
							</div>
						</div>
						<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="up_id">상위번호</label>
								<input type="text" class="form-control" name="view_up_index" id="view_up_index" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="down_dpart">하위부서</label>
								<input type="text" class="form-control" name="view_ch_down_name" id="view_ch_down_name">
								<input type="hidden" name="view_down_name" id="view_down_name">
							</div>
						</div>
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="down_id">하위번호</label>
								<input type="text" class="form-control" name="view_downId" id="view_downId" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<%-- <label for="editor">관리자 ${sessionId}</label> --%>
								<%-- <input type="text" class="form-control" name="editor" id="editor"  value="${sessionId}" readonly> --%>
							</div>
						</div>
						<div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12">
							<div class="form-group text-right"> <label for="btn"> &nbsp;</label>
								<button type="button" id="btnUpdate" onclick='modDpart(2);' class="btn btn-outline-primary">수정</button>
								<button type="button" id="btnDelete" onclick='delDpart(2);' class="btn btn-outline-danger">삭제</button>
							</div>
						</div>
					</div>
						</div> <!-- End card-body -->
					</div> <!-- End card -->
				</div> <!-- End col -->
				<!-- END 하위 부서 상세 보기  -->	
			</div><!-- End row gutters -->
		</div> 
	</div>	<!-- End of Main Content -->
	<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
	</div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>