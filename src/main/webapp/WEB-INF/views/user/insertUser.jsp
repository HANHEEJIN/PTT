<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">

$(document).ready(function() {	
	listSip();  // sip  : sip.js
	listMqtt(); // mqtt : mqtt.js
	listCom();  // 회사  : company.js
	//listUpDpart();	 // 상위 부서
	//listDownDpaer(); // 하위 부서
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
                    <h1 class="h3 mb-4 text-gray-800">사용자 등록</h1>
                </div>
                <!-- /.container-fluid -->

				<form name="frmUser" method="POST" <%-- action="${path}/user/insertUser" --%> onsubmit='return false'>
				<table class="table mb-0" style="width:60%; float: none; margin: 10 auto;">
					<tr>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text" >이름</span>
								</div>
								<input type="text" class="form-control" name="user_nm" id="user_nm">
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
								<input type="text" class="form-control" name="editor" id="editor" <%-- value="${sessionScope.LOGIN.user_id}" --%> value="${sessionId}" readonly> 
								
 							</div>
 						</td>
					</tr>
					<tr>
						<td>
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">아이디</span>
								</div>
								<input type="text" class="form-control" name="user_id" id="user_id">
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
								<input type="text" name="user_pwd" id="user_pwd" placeholder='비밀번호' class="form-control"></input>
 							</div>
 						</td>
 						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend">
									<span class="input-group-text">확인</span>
								</div>
								<input type="text" name="user_pwd_check" placeholder='비밀번호 확인' class="form-control"></input>
 							</div>
 						</td>
					</tr>
					<tr>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"> <span class="input-group-text">회사</span> </div>
								<div id="listUserCom"></div>
								<!-- <input type="text" class="form-control" name="co_num" id="co_num" value="GHC-01" readonly> -->
 							</div>
 						</td>
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"> <span class="input-group-text">상위부서</span></div>
								<div id="getUpDpart"></div>	
 							</div>
 							
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"> <span class="input-group-text">하위부서</span></div>
								<div id="getDownDpart"></div>
								
								<c:if test="${!empty map.DLIST}" >
									<select name="dpart_num" id="dpart_num" class="custom-select" >
										<c:forEach var="D" items="${map.DLIST}" varStatus="i">
											<option value="${D.dpart_num}">${D.dpart_num}</option>
										</c:forEach>
									</select>
								</c:if>			
 							</div>
 						</td>
						<td>  
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"><span class="input-group-text">직급</span></div>	
								<div id="getPosiList"></div>
 							</div>				
 						</td>		
					</tr>
					<tr>	
						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"> <span class="input-group-text">SIP</span> </div>
								<div id="getSip"></div>
 							</div>
 						</td>
 						<td> 
							<div class="input-group mb-3 input-group-sm">
								<div class="input-group-prepend"> <span class="input-group-text">MQTT</span> </div>
								<div id="getMqtt"></div>
 							</div>
 						</td>
					</tr>				
					<tr>
						<td colspan="3"> 
							<!-- contextPath 동적 url
								1) el - ${pageContext.request.contextPath}
								2) 제이에스티엘 - c태그 url의 value="주소값" var="변수명" -> <a href="달러기호표시{c태그 url의 var 변수명}">
							 -->
							<button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/user/listUser.do'">목록</button>
							<button type="button" id="btnJoin" class="btn btn-primary">등록</button>
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