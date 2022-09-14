<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<%@ include file="../include/top.jsp"%> <!-- 상단(HEADER) -->

<script type="text/javascript">
$(document).ready(function() {	
	listUser(1);
	
	listCom(2);  	// 회사 : company.js
	getSipList(); 	// sip  : sip.js
	userMqtt(); 	// mqtt : mqtt.js
	getListPosi();	// 직급 가져오기
	//getViewUser(); 	// 부서정보 가져오기
	
	$("#btnJoin").click(function() { confirm('등록하시겠습니까?') ? regJoin() : (false, form_reset()) });	
	$("#btnUpdate").click(function() { confirm('수정하시겠습니까?') ? modUser() : (false, form_reset()) });
	$("#btnDelete").click(function() { confirm('삭제하시겠습니까?') ? delUser() : (false, form_reset()) });	
	$("#pwReset").click(function() { confirm('비밀번호 초기화를 하시겠습니까?') ? pwReset()  : false; });	
	
	$('#dpartChangeView').hide();
	
	
	// 비밀번호 수정 엔터키
/* 	$("pwChangeForm").keypress(function (e) {
        if (e.keyCode === 13) {
        	login();
        }
    }); */
});

// 회사 번호로 상위 부서 데이터 가져오기
function getUpDpName(num) {	
	// dpart.js의 listUpDpart()
	// (1)부서등록_회사리트스클릭, (2), 사용자등록_리스트 (3)사용자수정_리스트
 	if(num == 2){
		let co_num = $('#co_num').val();		// 1. 회사 코드
		listUpDpart(num, co_num);		// 1. 상위 부서 가져오기
	} else if(num == 3) {
		let co_num = $('#view_co_num').val();
		listUpDpart(num, co_num);	
	} 
}

// 회사번호 + 상위부서 번호로 하위 부서 데이터 가져오기
function getDownDpName(num) {
	// dpart.js의 listDownDpart()
	// (1)부서등록_회사리트스클릭, (2), 사용자등록_리스트 (3)사용자수정_리스트
 	if(num == 2){	
		let co_num = $('#co_num').val();
		let dpart_index = $('#dpart_index').val();
		listDownDpart(num, dpart_index, co_num)
		
	} else if(num == 3) {
		let co_num = $('#view_co_num').val();
		let dpart_index = $('#view_dpart_index').val();
		listDownDpart(num, dpart_index, co_num)
	} 
}

function excelCheck(){
	let file = $("#excelFile").val();
	
	if (file == "" || file == null) {
		alert("파일을 선택해주세요.");
		return false;
	} else if (!checkFileType(file)) {
		alert("엑셀 파일만 업로드 가능합니다.");
		return false;
	}
	
	if (confirm("업로드 하시겠습니까?")) {
		let excelUp = new FormData(document.getElementById('excelUploadForm'));
		$.ajax({
			url: "${path}/user/insertExcel",
			data: excelUp,
			processData: false,
			contentType: false,
			type: "POST",
			success: function(data){
				console.log(data);
				document.getElementById('result').innerHTML = JSON.stringify(data);
			}
		});
	}
}
function checkFileType(filePath) {
    let fileFormat = filePath.split(".");

    if (fileFormat.indexOf("xls") > -1 || fileFormat.indexOf("xlsx") > -1) { 
    	return true;
    } else {
    	return false;
	}
}


/* function getViewUser(callback, error) {
	const URL = '/dpart/getListDpart';

	
	$.get(URL, function(data){
		$.each(data, function(i, item) {
			//console.log('dpart list  ' + JSON.stringify(data));
			dpartDate = data;
		
		});
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
	
} */

function dpartChange() {
	$('#dpartChangeView').show(); // user 상세 정보
	$('#dpChBtn_Before').hide();  // user 변경할 부서 정보
}

</script>
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
					
					
					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">사용자 정보 엑셀 등록</h6></div>
					</div>
					<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" onsubmit="return false">
					<div class="flex bg-light b-b p-2">
						<div class="row no-gutters">
							<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
								<div class="custom-file">
								   <input type="file" class="custom-file-input" id="excelFile" name="excelFile" disabled>
									<label class="custom-file-label" for="customFile">하나의 파일을 선택해 주세요</label>
								</div>
							</div>
						</div><br>
					</div>
					<br>
					
						
					<div class="row no-gutters div_excel_btn">
							<!-- <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12"></div> -->
							<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12 div_btn_parent">
							<button type="button" id="excelUp" onclick="excelCheck();"class="btn btn-sm btn-outline-primary btn-block btn_child" disabled>엑셀파일 업로드</button>
							</div>
							<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12 div_btn_parent">
							<button type="button" id="excelUp" onclick="excelCheck();"class="btn btn-sm btn-outline-secondary btn-block btn_child" disabled>양식파일 다운로드</button>
							</div>
						</div>
					</form>
					
					<hr><br>
					<!--  추가 BEGIN -->
					<form name="frmUser" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>

					<div class="row gutters">
						<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">사용자 정보 등록</h6></div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="name">이름</label>
								<input type="text" class="form-control" name="user_nm" id="user_nm">
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="editor">관리자</label> <br>
								<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly> 
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
							<div class="form-group">		
								<label for="id">아이디</label>			
								<div class="input-group">								
									<input type="text" class="form-control" name="user_id" id="user_id">
									<div class="input-group-append">
										<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
										<button type="button" id="btnIdCheck" value="N"  onclick="idCheck();" class="btn btn-outline-secondary"> <i class="fas fa-search fa-sm" ></i> </button>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12 radio_form_parent" ><!-- style="width:100; border:1px solid" -->
							<div class="form-group " > <!-- style="width:100; border:1px solid" -->
								<label for="type">구분</label> <br>
								<div class="btn-group  btn-group-toggle radio_form_child" data-toggle="buttons"  ><!-- style="width:100; border:1px solid" -->
									<label for="user_lvl_u" class="btn btn-sm  btn-outline-primary btn-user-type radio_form_child_u" name="user_lvl_u" >
										<input type="radio" name="user_lvl" id="user_lvl" value="u"/>사용자
									</label>
									<label for="user_lvl_a" class="btn btn-sm  btn-outline-danger btn-user-type radio_form_child_a" name="user_lvl_a">
										<input type="radio" name="user_lvl" id="user_lvl" value="a"/>관리자
									</label>
								</div>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="pw">비밀번호</label>
								<input type="text" name="user_pwd" id="user_pwd" placeholder='비밀번호' class="form-control"></input>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="pwCheck">비밀번호확인</label>
								<input type="text" name="user_pwd_check" placeholder='비밀번호 확인' class="form-control"></input>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="company">회사</label> <div id="userInsertCom"></div>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="position">직급</label> <div id="userInsertPosi"></div>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group" id="u_dpart" style="display:none">
								<label for="upDpart">상위부서</label>
								<div id="userInsertUpDp"></div> 
								<!-- 
								<select name=dpart_index id="dpart_index" class="form-control" onclick="getDownDpName()" >
									<option value="dpart_index"></option>
								</select>
								 -->
								
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group" id="d_dpart"  style="display:none">
								<label for="downDpart" >하위부서</label>
								 <div id="userInsertDownDp"></div>
								
								<!-- 
								<select name="downDpart" id="downDpart" class="form-control" >
									<option value="dpart_index">상위부서를선택해주세요.</option>
									
								</select>
								 -->
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="SIP">SIP</label> <div id="userInsertSip"></div>
							</div>
						</div>
						<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
							<div class="form-group">
								<label for="MQTT">MQTT</label>	<div id="userInsertMqtt"></div>
							</div>
						</div>
					</div>
					<div class="row gutters">
						<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-12"></div>
						<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12">
							<div class="text-right">
								<!-- contextPath 동적 url
								1) el - ${pageContext.request.contextPath}
								2) 제이에스티엘 - c태그 url의 value="주소값" var="변수명" -> <a href="달러기호표시{c태그 url의 var 변수명}">
							 -->
								<button type="button" id="btnJoin" class="btn btn-block btn-outline-primary">등록</button>
							<!-- <button type="reset" class="btn btn-primary">취소</button> -->
							</div>
						</div>
					</div>
					</form>
					<!--  추가 END -->
					</div>
				</div>
			</div>
		 	<!-- Start col -->
			<div class="col-lg-8">
				<div class="card h-100">
					<div class="card-body">
						<!-- lisetUSER 추가 BEGIN -->
						<div class="col-lg-12 mt-4 mt-lg-0">
							<div class="row">
								<!-- <div class="col-md-1"></div> -->
								<div class="col-md-12"> <!-- shadow-sm -->
									<div class="user-dashboard-info-box table-responsive mb-0 bg-white p-4 ">	
										
											
										
											<!-- <nav class="navbar navbar-expand-sm bg-primary navbar-light"></nav> -->
											<!-- Begin 사용자 검색 -->
											<div class="row no-gutters">
												<!-- <div class="col-10"><h1>사용자 목록</h1></div> -->
												<div class="col-xl-2 col-lg-2 col-md-2 col-sm-2 col-12">
													<select name="searchType" id="searchType" class="form-control" >
														<option value="all" selected>선택</option>					 
														<option value="user_num">번호</option>
														<option value="user_nm">이름</option>
														<option value="user_id">ID</option>
														 <option value="co_num">회사</option>
													</select>
																				
												 </div>
												<div class="col-xl-4 col-lg-4 col-md-4 col-sm-4 col-12 p-0">
													<div class="input-group">
														<input type="text" class="form-control small" name="keyword" id="keyword" placeholder="검색어"/>
														<div class="input-group-append">
															<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
															<button type="button" id="searchBtn" onclick="searchCheck(1);"class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button>
														</div>
													</div>
												</div>
											
												<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12 p-0 text-right"> </div>
												<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12 p-0 text-right"> <a href="<c:url value='/user/downloadExel' />" class="btn btn-sm btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
												
											</div>
											<!-- END 검색 -->



											<br>
											<!--추가된부분-->
											<table class="table   text-center ">
												<thead class="thead-light">
													<tr> <th>번호</th> <th>회원번호</th> <th>이름</th> <th>ID</th> <th>E164번호</th>
													<th>회사</th>   <th>부서</th> <th>직급</th>
													<th>SIP</th> <th>MQTT</th> <!--<th>EDITOR</th>  <th>JOIN DATE</th> <th>UPDATE DATE</th> --> <!-- <th>DELETE</th> -->
												</tr>
												</thead>
												<tbody id="tbody" >
												</tbody> 
											</table>
											<input type='hidden' id='page' name='page' value='1' />
											<br>
											<!-- 페이징 --> <div id="pageing"></div>
					
									</div>
								</div>
							<!-- <div class="col-md-1"></div> -->
							</div>
						</div>
						<!-- lisetUSER 추가 END -->
					</div>
				</div>
			</div> <!--  End col -->
			
			<!-- Begin Modal -->
			<div class="modal" id="userInfo">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
					     
					    
					    <!-- Modal Header -->
						<div class="modal-header">
							<h5 class="modal-title text-primary">사용자 상세 정보</h5>
							<button type="button" class="close" data-dismiss="modal">×</button>
						</div>
						
						<form name="viewUser" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
						<!-- Modal body -->
						<div class="modal-body" >
							<div class="row gutters">
								<div class="col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="name">번호</label>
										<input type="text" class="form-control" name="view_user_num" id="view_user_num">
									</div>
								</div>
								<div class="col-xl-5 col-lg-5 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="name">이름</label>
										<input type="text" class="form-control" name="view_user_nm" id="view_user_nm">
									</div>
								</div>
								<div class="col-xl-5 col-lg-5 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="editor">관리자</label> <br>
										<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly> 
									</div>
								</div>
							</div>
							
							
							
													
							<div class="row gutters">
								<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-12">
									<div class="form-group">		
										<label for="id">아이디</label>			
										<div class="input-group">								
											<input type="text" class="form-control" name="view_user_id" id="view_user_id">
											<div class="input-group-append">
												<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
												<button type="button" id="btnIdCheck" value="N"  onclick="idCheck();" class="btn btn-outline-secondary"> <i class="fas fa-search fa-sm" ></i> </button>
											</div>
										</div>
									</div>
								</div>
								<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12 radio_form_parent">
								<div>					
									<div class="form-group ">
										<label for="type">구분</label> <br>
										<div class="btn-group btn-group-toggle radio_form_child" data-toggle="buttons">
											<label for="view_user_lvl_u" class="btn btn-sm btn-outline-primary btn-user-type view_user_lvl_u" name="view_user_lvl_u">
												<input type="radio" name="view_user_lvl" id="view_user_lvl" value="u" /> 사용자
											</label>
											<label for="view_user_lvl_a" class="btn btn-sm btn-outline-danger btn-user-type view_user_lvl_a" name="view_user_lvl_a">
												<input type="radio" name="view_user_lvl" id="view_user_lvl" value="a"/> 관리자
											</label>
										</div>
									</div>
								</div></div>
							</div>
							<div class="row gutters">
								<div class="col-xl-9 col-lg-9 col-md-9 col-sm-9 col-12">
									<div class="form-group">
										<label for="pw">비밀번호</label>
										<input type="text" name="view_user_pwd" id="view_user_pwd" placeholder='비밀번호' class="form-control"></input>
									</div>
								</div>
								<div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col-12">
									<!-- Begin btn-group -->
									<div class="form-group">
										<label for="pwCheck">변경</label><br>
										<div class="btn-group div_pw_parent">
										<button type="button" class="btn btn-outline-secondary btn-block div_pw_child" data-toggle="modal" data-target="#pwModal" >변경</button>
										
										<!-- Begin 비밀번호 변경 Modal -->
										<div class="modal fade" id="pwModal">
											<div class="modal-dialog modal-dialog-centered">
												<div class="modal-content">
										
													<!-- Modal Header -->
													<div class="modal-header">
														<h4 class="modal-title text-primary">비밀번호변경</h4>
														<button type="button" class="close" data-dismiss="modal">&times;</button>
													</div>
													        
													<!-- Modal body -->
													<div class="modal-body">
		
														<div class="form-group">
															<label for="usr">현재 비밀번호:</label>
															<input type="text" class="form-control" id="pre_pwd" autoComplete="off">
														</div>
														<div class="form-group">
															<label for="pwd">변경 비밀번호:</label>
															<input type="text" class="form-control" id="change_user_pwd" autoComplete="off">
														</div>
														<div class="form-group">
															<label for="pwd">변경 비밀번호 확인:</label>
															<input type="text" class="form-control" id="change_user_pwd_check" autoComplete="off">
														</div>										
													</div>	        
													<!-- Modal footer -->
													<div class="modal-footer">
													<button type="button" onclick="pwChange(); form_reset();"  class="btn  btn-outline-primary" >변경</button>
													<button type="button"  onclick="form_reset();"  class="btn  btn-outline-secondary" data-dismiss="modal">취소</button>
													</div>
												</div>	        
											</div>
										</div><!--  End 비밀번호 변경 Modal -->
										<button type="button" class="btn btn-outline-secondary btn-block div_pw_child"  id="pwReset">초기화</button>
									</div><!-- End btn=group -->
									</div>
								</div>
							</div>
							
							<!-- [START] VIEW USER DPART BEFORE -->
							<div id="dpChBtn_Before">
								<div class="row gutters">
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group">
											<label for="company">회사</label> <!-- <div id="userViewCom"></div> -->
											<input type="text" class="form-control" name="view_input_co_num" id="view_input_co_num"> 
										</div>
									</div>
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="d_view_dpart">
											<label for="d_view_dpart">부서</label>
											<input type="text" class="form-control" name="view_input_dpart_num" id="view_input_dpart_num">
											<div id="userViewDownDp"></div>
											
											<!-- <select name="before_dpart_num" id="before_dpart_num" class="form-control">
												<option value="선택">선택</option>
											</select> -->
										</div>
									</div>
									
									
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group">
											<label for="position">직급</label> 
											<!-- <div id="userViewPosi"></div> -->
											<input type="text" class="form-control" name="view_input_user_pst" id="view_input_user_pst">
										</div>
									</div>
									
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="u_view_dpart">
											<label for=u_view_dpart>부서변경</label>
											<button type="button" class="btn btn-outline-secondary btn-block" onclick="dpartChange()">부서변경</button>
										</div>
									</div>
								</div>
							</div>
							<!-- [END] VIEW USER DPART BEFORE -->
							
							<!-- [START] VIEW START USER DPART -->
							<div id="dpartChangeView">
								<div class="row gutters">
								
								
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="u_view_dpart">
											<label for=u_view_dpart>회사</label>
											<!-- <div id="userViewUpDp"></div> -->
											
											<select name="before_dpart_index" id="before_dpart_index" class="form-control">
												<option value="선택">선택</option>
											</select>
										</div>
									</div>
									
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="u_view_dpart">
											<label for=u_view_dpart>상위부서</label>
											<!-- <div id="userViewUpDp"></div> -->
											
											<select name="before_dpart_index" id="before_dpart_index" class="form-control">
												<option value="선택">선택</option>
											</select>
										</div>
									</div>
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="u_view_dpart">
											<label for=u_view_dpart>하위부서</label>
											<!-- <div id="userViewUpDp"></div> -->
											
											<select name="before_dpart_index" id="before_dpart_index" class="form-control">
												<option value="선택">선택</option>
											</select>
										</div>
									</div>
									<div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
										<div class="form-group" id="u_view_dpart">
											<label for=u_view_dpart>직급</label>
											<!-- <div id="userViewUpDp"></div> -->
											
											<select name="before_dpart_index" id="before_dpart_index" class="form-control">
												<option value="선택">선택</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<!-- [END] VIEW USER DPART -->
							
							<!-- 
							<div class="row gutters">
								<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
									<div class="form-group">
										<label for="upDpart">상위부서</label>
										<input type="text" class="form-control" name="co_num" id="co_num">
										<input type="text" class="form-control" name="view_dpart_index" id="view_dpart_index">
										<div id="userViewUpDp"></div>
									</div>
								</div>
								<div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-12">
									<div class="form-group">
										<label for="downDpart">하위부서</label>
										<input type="text" class="form-control" name="dpart_num" id="dpart_num">
										<input type="text" class="form-control" name="view_dpart_num" id="view_dpart_num">
										<div id="userViewDownDp"></div>
									</div>
								</div>
							</div> -->
							<div class="row gutters">
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="SIP">SIP</label> <div id="userViewSip"></div>
									</div>
								</div>
								<div class="col-xl-6 col-lg-6 col-md-12 col-sm-12 col-12">
									<div class="form-group">
										<label for="MQTT">MQTT</label>	<div id="userViewMqtt"></div>
									</div>
								</div>
							</div>
						</div>
							
			        	</form>
						<!-- Modal footer -->
						<div class="modal-footer">
						<!-- contextPath 동적 url
											1) el - ${pageContext.request.contextPath}
											2) 제이에스티엘 - c태그 url의 value="주소값" var="변수명" -> <a href="달러기호표시{c태그 url의 var 변수명}">
										 -->
							<button type="button" id="btnUpdate" class="btn btn-outline-primary">수정</button>
							<button type="button" id="btnDelete" class="btn btn-outline-danger">삭제</button>
							<button type="reset" class="btn btn-outline-secondary" onclick="form_reset();" data-dismiss="modal">취소</button>
						</div>
					   
					</div>
				</div>
			</div>
			<!-- End Modal -->
			
			
	
            <br><br>
			
		</div><!-- end roe gutters -->
		</div> <!-- container-fluid -->          
       </div> <!-- End of Main Content -->
		<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
     </div>
     <!-- End of Content Wrapper -->
 </div>
 <!-- End of Page Wrapper -->
</body>
</html>