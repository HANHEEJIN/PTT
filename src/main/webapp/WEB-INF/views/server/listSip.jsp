<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function() {
	//getSipList();	// 리스트
	listSip(1);
	$("#btnInsert").click(function() { addSip(); });	// SIP 등록 버튼
	$('#btnUpdate').click(function() { 		
		/* if(!$('#svr_type > option:selected').val()) {
		    alert("아나 선택 좀..");
		} */
		confirm('수정하시겠습니까?') ? modSip() : false;
	
	}); // SIP 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delSip() : false; }); // SIP 삭제 버튼
  $("input:checkbox[name=svr_type]:checked").each(function() {
		    var checkVal = $(this).val(); // 체크된 값의 value값 가져오기
		    console.log(checkVal);
		});
	

});


// type 체크박스 단일 선택
function checkOnlyOne(element) {
	//console.log($('input:checkbox[name="svr_type"]').val());

	let insertCheck = document.getElementsByName("svr_type");
	insertCheck.forEach((cb) => { cb.checked = false; })
	element.checked = true;

 	$('input:checkbox[name=svr_type]').each(function (index) {
		if($(this).is(":checked")==true){
			type = $(this).val()
	    	//console.log(type);
	    }
	});
 	
}

function checkView(element) {
	let viewCheck = document.getElementsByName("view_type");
	viewCheck.forEach((cb) => { cb.checked = false; })
	element.checked = true;
}


</script>
<%@ include file="../include/top.jsp"%> <!-- 상단(HEADER) -->
<!-- Page Wrapper -->
<div id="wrapper">
	<%@ include file="../include/nav.jsp"%> <!-- 메뉴(NAV) -->
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
	<div id="content"> <br><br>
	<!-- 시작 -->
	<div class="container-fluid">
	<!-- <div class="container"> -->
	<div class="row gutters">
	<div class="col-lg-4">
		<div class="card h-100">
			<div class="card-body">
				<!-- SIP 추가 BEGIN -->
				<form name="frmSip" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">SIP 정보 등록</h6></div>
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="id">IP</label>
								<input type="text" class="form-control" name="svr_ip" id="svr_ip" value="211.119.132.243">
								<input type="hidden" class="form-control" name="svr_num" id="svr_num">
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">ID</label>
								<input type="text" class="form-control" name="svr_id" id="svr_id" value="sip00" maxlength='8'>
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
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">PORT</label>
								<input type="text" class="form-control" name="svr_port" id="svr_port"  value="5060" >
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
						
							<div class="form-group">
								<label for="editor">TYPE</label>
								<select class="form-control" name="svr_type" id="svr_type">
								<option value="SIP">SIP</option>
									<option value="MQTT">MQTT</option>
									<option value="MDS">MDS</option>
								</select>							
								</div>
								
								
						<!-- 	<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkOnlyOne(this)' class="form-check-input" id="svr_type" name="svr_type" value="SIP">SIP</label></div>
							<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkOnlyOne(this)' class="form-check-input" id="svr_type" name="svr_type" value="MQTT">MQTT</label></div>
							<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkOnlyOne(this)' class="form-check-input" id="svr_type" name="svr_type" value="MDS">MDS</label></div>
						 -->
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">RPT PORT</label>
								<input type="text" class="form-control" name="svr_rpt_start_port" id="svr_rpt_start_port" value="20000">
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">RPT PORT COUNT</label>
								<input type="text" class="form-control" name="svr_rpt_count_port" id="svr_rpt_count_port" >
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="text-right">
								<button type="button" id="btnInsert" class="btn btn-outline-primary" >추가</button>
								<!-- <button type="reset" class="btn btn-secondary">취소</button> -->
							</div>
						</div>
					</div>
				</form>
				<!-- SIP 추가 END -->
			</div>
		</div>
	</div>
	<div class="col-lg-8">
		<div class="card h-100">
			<div class="card-body">
			<div class="table-responsive">
			
			<!-- Begin  검색 -->
			<div class="row no-gutters">
				<div class="col-lg-2 col-md-2 col-sm-12 p-0"></div>
				<div class="col-lg-2 col-md-2 col-sm-12 p-0">
					<select name="searchType" id="searchType" class="form-control" >
						<option value="all" selected>선택</option>					 
						<option value="svr_id">ID</option>
						<option value="svr_ip">IP</option>
						<option value="svr_type">TYPE</option>
					</select>
												
				 </div>
				<div class="col-lg-5 col-md-5 col-sm-12 p-0">
					<div class="input-group">
						<input type="text" class="form-control small" name="keyword" id="keyword" placeholder="검색어"/>
						<div class="input-group-append">
							<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
							<button type="button" id="searchBtn" onclick="searchCheckSip(1);"class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button>
						</div>
					</div>
				</div>
			
				<div class="col-lg-3 col-md-3 col-sm-12 p-0 text-right"> <a href="<c:url value='/server/sip/downloadExel' />" class="btn btn-sm btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
			</div>
			<!-- END 검색 -->
				
				
				
			<br>
			<table class="table text-center">
				<thead class="thead-light"> <tr class="table-active"> <th>NO</th> <th>ID</th> <th>IP</th> <th>PORT</th> <th>TYPE</th> <th>RPT_PORT</th> </tr> </thead>
				<tbody id="tbody" class="table-hover"></tbody>	
			</table>
			<input type='hidden' id='page' name='page' value='1' /><br>
			<!-- 페이징 --> <div id="pageing"></div>
			</div>
			</div>
		</div>
	</div>
	
	<!-- Begin Modal -->
	<div class="modal" id="sipInfo">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			      
			    <!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title text-primary">SIP 상세 정보</h5>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				        
				<!-- Modal body -->
				<div class="modal-body" >
					<!-- SIP 추가 BEGIN -->
					<!-- <div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">SIP 상세정보</h6></div>
					</div> -->
					<div class="row gutters">
						<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-12">
							<div class="form-group">
								<label for="id">IP</label>
								<input type="text" class="form-control" name="view_ip" id="view_ip" >
							</div>
						</div>
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12">
							<div class="form-group">
								<label for="id">NO</label>
								<input type="text" class="form-control" name="view_num" id="view_num">
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">ID</label>
								<input type="text" class="form-control" name="view_id" id="view_id" maxlength='8'>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">관리자</label>
								<input type="text" class="form-control" name="view_editor" id="view_editor" value="${sessionId.user_id}" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">PORT</label>
								<input type="text" class="form-control" name="view_port" id="view_port"  value="5060" >
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12"> 
								
							<div class="form-group">
									<label for="editor">TYPE</label>
								<select class="form-control" name="view_type" id="view_type">
								<option value="SIP">SIP</option>
									<option value="MQTT">MQTT</option>
									<option value="MDS">MDS</option>
								</select>							
								</div>
							
							<!-- 
							<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkView(this)' class="form-check-input" name="view_type" value="SIP" checked>SIP</label></div>
							<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkView(this)' class="form-check-input" name="view_type" value="MQTT">MQTT</label></div>
							<div class="form-check-inline"><label class="form-check-label"> <input type="checkbox" onclick='checkView(this)' class="form-check-input" name="view_type" value="MDS">MDS</label></div>
 							Q-->
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">RPT PORT</label>
								<input type="text" class="form-control" name="view_rpt" id="view_rpt" >
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">RPT PORT COUNT</label>
								<input type="text" class="form-control" name="view_rpt_count" id="view_rpt_count" >
							</div>
						</div>
					</div>

				</div>
					 <!-- onClick="history.go(0)" -->
	        
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" id="btnUpdate" class="btn btn-outline-primary">수정</button>
					<button type="button" id="btnDelete" class="btn btn-outline-danger" >삭제</button>
					<button type="button" class="btn  btn-outline-secondary" data-dismiss="modal" >취소</button>
				</div>
			        
			</div>
		</div>
	</div>
	<!-- End Modal -->
	
</div> </div> </div> 
	<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
    </div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>