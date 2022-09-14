<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">
$(document).ready(function() {
	// 리스트
	listMqtt(1);
	// MQTT 등록 이벤트
	$("#btnInsert").click(function() { addMqtt(); });	// SIP 등록 버튼
	$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modMqtt() : false; }); // SIP 수정 버튼
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delMqtt() : false; }); // SIP 삭제 버튼
	
	
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
	<!-- 시작 -->
	<div class="container-fluid">
	<div class="row gutters">
	<div class="col-lg-4">
		<div class="card h-100">
			<div class="card-body">
				<!-- MQTT 추가 BEGIN -->
				<form name="frmMqtt" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">MQTT 정보 추가</h6></div>
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="id">IP</label>
								<input type="text" class="form-control" size="15" name="mqtt_svr_ip" id="mqtt_svr_ip" value="211.119.132.244">
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">ID</label>
								<input type="text" class="form-control" size="5"  name="mqtt_svr_id" id="mqtt_svr_id" value="mqtt02" maxlength='8'>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">관리자</label>
								<input type="text" class="form-control" size="5" name="editor" id="editor" value="${sessionId.user_id}" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">PORT</label>
								<input type="text" class="form-control" size="5" name="mqtt_svr_port" id="mqtt_svr_port" value="1883" readonly>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group text-right"> <label for="btn"> &nbsp;</label>
								<button type="button" id="btnInsert" class="btn btn-outline-primary">추가</button>
								<button type="reset" class="btn btn-outline-secondary">취소</button>
							</div>
						</div>
					</div>
				</form>
				<!-- MQTT 추가 END -->
			</div>
		</div>
	</div>
	<div class="col-lg-8">
		<div class="card h-100">
			<div class="card-body">
					
			<!-- Bigin MQTT -->
			<div class="table-responsive">
			<!-- Begin  검색 -->
			<div class="row no-gutters">
				<div class="col-lg-2 col-md-2 col-sm-12 p-0"></div>
				<div class="col-lg-2 col-md-2 col-sm-12 p-0">
					<select name="searchType" id="searchType" class="form-control" >
						<option value="all" selected>선택</option>					 
						<option value="mqtt_svr_id">ID</option>
						<option value="mqtt_svr_ip">IP</option>
						<option value="mqtt_svr_port">PORT</option>
					</select>
												
				 </div>
				<div class="col-lg-5 col-md-5 col-sm-12 p-0">
					<div class="input-group">
						<input type="text" class="form-control small" name="keyword" id="keyword" placeholder="검색어"/>
						<div class="input-group-append">
							<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
							<button type="button" id="searchBtn" onclick="searchCheckMqtt(1);"class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button>
						</div>
					</div>
				</div>
			
				<div class="col-lg-3 col-md-3 col-sm-12 p-0 text-right"> <a href="<c:url value='/server/mqtt/downloadExel' />" class="btn btn-sm btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
			</div> <br>
			<!-- END 검색 -->
			<table class="table  text-center">
				<thead class="thead-light"> <tr class="table-active"> <th>번호</th> <th>MQTT번호</th> <th>ID</th> <th>IP</th> <th>PORT</th> <!-- <th>DELETE</th> --> </tr> </thead>
				<tbody id="tbody"></tbody>	
			</table>
			
			<input type='hidden' id='page' name='page' value='1' /><br>
			<!-- 페이징 --> <div id="pageing"></div>
			</div>
			<!-- End SIP -->
			</div>
		</div>
	</div>
	
	<!-- Begin Modal -->
	<div class="modal" id="mqttInfo">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
			      
			    <!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title text-primary">MQTT 상세 정보</h5>
					<button type="button" class="close" data-dismiss="modal">×</button>
				</div>
				        
				<!-- Modal body -->
				<div class="modal-body" >
					<!-- SIP 추가 BEGIN -->
					<div class="row gutters">
						<!-- <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">MQTT 상세정보</h6></div> -->
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="id">IP</label>
								<input type="text" class="form-control" size="15" name="view_ip" id="view_ip">
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">NO</label>
								<input type="text" class="form-control" size="5"  name="view_num" id="view_num" readonly>
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
								<label for="editor">ID</label>
								<input type="text" class="form-control" size="5"  name="view_id" id="view_id" maxlength='8'>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
							<div class="form-group">
								<label for="editor">PORT</label>
								<input type="text" class="form-control" size="5" name="view_port" id="view_port" readonly>
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
	</div> </div> </div>	<!-- End of Main Content -->
	<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->		
    </div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>