<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<style> span { display:inline-block; width:100px; font-size:small; text-align:center;}</style>
<script type="text/javascript">
$(document).ready(function() {
	$('#btnUpdate').click(function() {
		let pw = document.viewUser.user_pwd.value;

		// 비밀번호 입력 확인
		if (!pw) {
			alert('비밀번호를 입력해 주세요');
			pw.focus();
			return;
		} else {
			confirm('수정하시겠습니까?') ? modUser() : false; 
		}  
		
		
	
	}); // 사용자 수정 버튼
	
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delUser() : false; }); // 사용자 삭제 버튼
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
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-4 text-gray-800">사용자 정보 수정</h1>
                </div>
                <!-- /.container-fluid -->
				<form name="viewUser" <%--method="POST"  action="${path}/user/insertUser" --%> onsubmit='return false'>
				<table class="table mb-0" style="width:60%; float: none; margin: 10 auto;">
					<tr>
						<td>
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">번호</span>
								</div>
								<input type="text" name="user_num"  id="user_num" class="form-control" value="${VUSER.user_num}"></input>
 							</div>
						</td>
 						<td>
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text" >구분</span>
								</div>
									<div class="btn-group btn-group-toggle" data-toggle="buttons">
										<label for="user_lvl_u" class="btn btn-outline-primary">
											<input type="radio" name="user_lvl" id="user_lvl_u" value="u" checked="checked"> 사용자
										</label>
										<label for="user_lvl_a" class="btn btn-outline-danger">
											<input type="radio" name="user_lvl" id="user_lvl_a" value="a"> 관리자
										</label>
									</div>
					
 							</div>
 							<!-- <input type="checkbox" name="user_lvl" value="u" checked data-toggle="toggle"
										data-on="사용자" data-off="관리자" data-onstyle="outline-primary" data-offstyle="outline-danger" data-size="sm"> -->
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
									<span class="input-group-text" >이름</span>
								</div>
								<input type="text" class="form-control" name="user_nm" id="user_nm" value="${VUSER.user_nm}">
 							</div>
 						</td>
						<td>
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">아이디</span>
								</div>
								<input type="text" class="form-control" name="user_id" id="user_id" value="${VUSER.user_id}">
								<div class="input-group-prepend">
									<button class="btn btn-outline-primary " type="button" id="btnIdCheck" value="N"  onclick="idCheck();">중복</button>
								</div>
 							</div>

 						</td>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">비밀번호</span>
								</div>
								<input type="text" name="user_pwd" id="user_pwd"  placeholder='비밀번호' class="form-control"></input>
								<div class="input-group-prepend">
									<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#pwModal" >비밀번호변경</button>
									<!-- The Modal -->
									<div class="modal fade" id="pwModal">
										<div class="modal-dialog modal-dialog-centered">
											<div class="modal-content">
									
												<!-- Modal Header -->
												<div class="modal-header">
													<h4 class="modal-title">비밀번호변경</h4>
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
									         		 <button type="button" onclick="pwChange();"  class="btn btn-success" >변경</button>
													<button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
												</div>
												        
											</div>
										</div>
									</div>
									
								</div>
 							</div>
 						</td>

					</tr>
					<tr>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">부서코드</span>
								</div>
								<input type="text" class="form-control" name="co_num" id="co_num" value="${VUSER.co_num}" disabled>
 							</div>
 						</td>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">부서</span>
								</div>
								<!-- <input type="text" class="form-control" name="dpart_num" value="총무" readonly> -->
								
								<select name="dpart_num" id="dpart_num" class="custom-select">
									<!-- <option selected>부서 선택</option> -->
									<option value="${VUSER.dpart_num}" selected> ${VUSER.dpart_num}</option>
									<option value="총무">총무</option>
									<option value="인사">인사</option>
									<option value="재무">재무</option>
									<option value="경리">경리</option>
									<option value="영업">영업</option>
									<option value="연구">연구</option>
								</select>
 							</div>
 						</td>

						<td>  
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">직급</span>
								</div>
								<!-- <input type="text" class="form-control" name="user_pst" value="사원" readonly > -->
								<select name="user_pst" id="user_pst" class="custom-select">
									<!-- <option selected>직급 선택</option> -->
									<!-- 임원 -->
									<%-- <option value="${position.code}"> ${position.nm}</option> --%>
									<option value="${VUSER.user_pst}" selected> ${VUSER.user_pst}</option>
									<option value="회장">회장</option>
									<option value="부회장">부회장</option> <!-- Vice Chairman -->
									<option value="사장">사장</option>  
									<option value="부사장">부사장</option><!-- Vice President -->
									<option value="전무">전무</option>	<!--  Senior Managing Director -->
									<option value="상무">상무</option> 	<!-- Managing Director -->
									<option value="이사">이사</option>	
									<!-- 사무원 -->
									<option value="부장">부장</option> 	<!-- General Manager -->
									<option value="차장">차장</option> 	<!-- Deputy General Manager -->
									<option value="과장">과장</option>
									<option value="대리">대리</option> 	<!-- Assistant Manager -->
									<option value="주임">주임</option>		<!-- Senior Staff,  Assistant Manager, supervisor -->
									<option value="사원">사원</option>
									<option value="인턴">인턴</option>
								</select>
 							</div>
 							
 						</td>
					</tr>
					<tr>
						<td>  
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">E164</span>
								</div>
								<input type="text" class="form-control" name="e164_no" value="${VUSER.e164_no}" readonly>
 							</div>
 						</td>
						
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">SIP</span>
								</div>
								<input type="text" class="form-control" name="sip_id" id="sip_id" value="${VUSER.sip_svr_id}" readonly>
 							</div>
 						</td>
 						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">MQTT</span>
								</div>
								<input type="text" class="form-control" name="mqtt_id"  id="mqtt_id" value="${VUSER.mqtt_svr_id}" readonly>
 							</div>
 						</td>
						
					</tr>
					
					<tr>
						<td>
							<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/user/listUser.do'">목록</button>
							<button type="button" id="btnUpdate" class="btn btn-primary">수정</button>
							<button type="button" id="btnDelete" class="btn btn-danger">삭제</button>
							<!-- <button type="reset" class="btn btn-primary">취소</button> -->
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