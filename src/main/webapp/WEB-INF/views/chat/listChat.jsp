<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<style>
.card { height : 100%;}
.chat-messages { display: flex; flex-direction: column; height : 700px; max-height: 700px; overflow-y: scroll; }
.chat-message-left, .chat-message-right { display: flex; flex-shrink: 0 }
.chat-message-left { margin-right: auto}
.chat-message-right { flex-direction: row-reverse; margin-left: auto; }
.py-3 { padding-top: 1rem!important; padding-bottom: 1rem!important; }
.px-4 { padding-right: 1.5rem!important; padding-left: 1.5rem!important;}
.flex-grow-0 { flex-grow: 0!important; }
.border-top { border-top: 1px solid #dee2e6!important; }
.btnIn { background-color: #FFFFFF; position:sticky; top:0px; }
.btnOut { background-color: #FFFFFF; position:sticky; top:0px; }
</style>

<script type="text/javascript">
$(document).ready(function() {	
	
	listChat(1);  initTmap();
	
	$('#msg').attr('placeholder', '대화방을 클릭해 주세요');
	$('#msg').attr('readonly', true);
	$('#btnMsg').attr('value', 'X');
	$('#btnMsg').attr('disabled', true);
	
	
	//$('#maekerMap').attr('value', 'X');
	$('#makerMap').attr('disabled', true);
	
	// 대화방 등록 버튼
	$('#btnInsert').click(function() { confirm('등록하시겠습니까?') ? addChat() : false; });
	$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delChat() : false; });
	
	fncStartMqtt();
	
	// 공백 감지
	$("#msg").on("propertychange change keyup paste input", function() {

		//let msg = $('#msg').val();	
		let currentVal = $(this).val();
		
		// 첫 문자가 공백이면 막기 
		if(currentVal.charAt(0) === ' ' ){ 
			$('#btnMsg').attr('disabled', true);
			$('#btnMsg_icon').addClass('fa fa-times');
			
			
			// 첫 문자가 공백이고 마지막 문자가 공백이 아니면
			if(currentVal.charAt( currentVal.length - 1) !== ' ' ){
				$('#btnMsg').attr('disabled', false);
				$('#btnMsg_icon').attr('class', 'fa fa-arrow-up');
				//mstEs(currentVal);
			} else {
				// 마지막 문자열 공백 제거하기
			}
		} 
		else {
			$('#btnMsg').attr('disabled', false);
			$('#btnMsg_icon').attr('class', 'fa fa-arrow-up');
			//mstEs(currentVal);
		}
	});

	
	$('#btnMsg').click(function() { 
		let msg = $('#msg').val();	
		let escape = '';
		
		if(msg.includes("'") || msg.includes('"') || msg.includes(";")){ 
			//escape = escapeHtml(msg);
			console.log('msg ' + msg);
			
			//escape != '' ? (sndMsg(msg)): alert('메세지를 입력하세요');
		}
		console.log('cescape' + escape);
		// 입력 null 값 처리
		//
		
		
		msg != '' ? (sndMsg(msg)): alert('메세지를 입력하세요');
		
		$('#msg').val('');
		
		let chat_room_num = $('.chat_room_no').text();	
		let name = $('.chat_room_name').text();
		console.log('asds');
		console.log(chat_room_num);
		console.log(name);
		
		//getMsg(chat_room_num, name);
		
	}); 
	
	// 메세지 전송 엔터키
	$("#msg").keypress(function (e) {
        if (e.keyCode === 13) {
        	$('#btnMsg').click(); 
        }
    });	
});





//2) 방 입장시, sub 토픽 전달 -> 방 입장시
function roomJoinClick (chat_room_num) {
	// 1) 방 입장시, mqtt 연결
	//let mqttState = fncStartMqtt();
	
	//console.log(mqttState);
	
	// 연결(1), 실패(2), 손실(3), 종료(4)
	/* if(mqttState === 1){
		console.log('연결');
		
		
		
	} else if(mqttState === 2) {
		console.log('실패');
		
	} else if(mqttState === 3) {
		console.log('손실');
		
	} else if(mqttState === 4) {
		console.log('종료');
		
	} */
	// 2) sub 토픽 전달 -> 방 입장시
	let subTopic = '/ptt/chat/' + chat_room_num;
	console.log(chat_room_num);
	console.log(subTopic);
	mqttClient.subscribe(subTopic);
	

	// 3) 메세지 받기 : 성공(true), 실패(false)
	/* let msgState = onMessageArrived(message);
	if(msgState){
		console.log('메세지 받기 성공');
		
	} else{
		console.log('메세지 받기 실패');
	} */
	
	// 4) 메세지 전송 시, pub 토픽과 msg 전달
	// 메세지 전송은 api 통해서 mqtt 함께 전달 -> 사용x
	// fncMqttDoSend(pubTopic, msg); 
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
<br><br>
<!-- Begin container-fluid -->
<div class="container-fluid">
	<!-- Begin row  -->
    <div class="row ">
		<div class="col-lg-5">
			<div class="card h-100">
				<div class="card-body"> <br>
					<!-- Nav tabs -->
					<ul class="nav nav-tabs">
						<li class="nav-item"> <a class="nav-link active" data-toggle="tab" href="#tabList">목록</a> </li>
						<li class="nav-item"> <a class="nav-link" data-toggle="tab" href="#tabMap">지도</a> </li>
					</ul>
					
					<!-- Tab panes -->
					<div class="tab-content">
						<div class="tab-pane container active" id="tabList">
							<a class="nav-link" data-toggle="modal" data-target="#addChat" href="#" ><i class="fa fa-comments"></i><span>대화방추가</span></a>
							
							<!-- Begin Modal -->
							<div class="modal" id="addChat">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
									     
									    
									    <!-- Modal Header -->
										<div class="modal-header">
											<h5 class="modal-title text-primary">대화방 추가</h5>
											<button type="button" class="close" data-dismiss="modal">×</button>
										</div>
										        
										<!-- Modal body -->
										<div class="modal-body" >
											<!-- SIP 추가 BEGIN -->
											<!-- <div class="row gutters">
												<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">대화방 추가</h6></div>
											</div> -->
											<div class="row gutters">
												<div class="col-xl-8 col-lg-9 col-md-9 col-sm-9 col-12">
													<div class="form-group">
														<label for="id">관리자</label>
														<input type="text" class="form-control" name="editor" id="editor" value="${sessionId.user_id}" readonly>
													</div>
												</div>
												<div class="col-xl-4 col-lg-9 col-md-9 col-sm-9 col-12">
													<div class="form-group">
														<label for="id">사용자번호</label>
														<input type="text" class="form-control" name="chat_user_num" id="chat_user_num" value = "347" readonly >
													</div>
												</div>
											</div>
											<div class="row gutters">
												<div class="col-xl-12 col-lg-9 col-md-9 col-sm-9 col-12">
													<div class="form-group">
														<label for="id">방이름</label>
														<input type="text" class="form-control" name="chat_room_nm" id="chat_room_nm"> 
													</div>
												</div>
											</div>
											
											<div class="row gutters">
												<div class="col-xl-12 col-lg-9 col-md-9 col-sm-9 col-12">
													<div class="form-group">
														<label for="id">비밀번호</label>
														<input type="text" class="form-control" name="chat_room_pwd" id="chat_room_pwd">
													</div>
												</div>
											</div>
											<div class="row gutters">
												<div class="col-xl-12 col-lg-9 col-md-9 col-sm-9 col-12">
													<div class="form-group">
														<label for="id">공개여부</label>
														<input type="text" class="form-control" name="chat_room_typ" id="chat_room_typ" value="o">
													</div>
												</div>
											</div>
										</div>
							        
										<!-- Modal footer -->
										<div class="modal-footer">
											<button type="button" id="btnInsert" class="btn btn-primary" >추가</button>
											<button type="button" class="btn btn-secondary" data-dismiss="modal" >취소</button>
										</div>    
									</div>
								</div>
							</div>
							<!-- End Modal -->
							<!-- Page Heading -->
		
							<div class="table-responsive">
							<!--  사용자 검색 -->
							<div class="row no-gutters">
								<!-- <div class="col-10"><h1>사용자 목록</h1></div> -->
								<div class="col-lg-2 col-md-2 col-sm-12 p-0"></div>
								<div class="col-lg-2 col-md-2 col-sm-12 p-0">
									<select name="searchType" id="searchType" class="form-control" >
										<option value="all" selected>선택</option>					 
										<option value="chat_room_num">번호</option>
										<option value="chat_room_nm">이름</option>
									</select>
																
								 </div>
								<div class="col-lg-5 col-md-5 col-sm-12 p-0">
									<div class="input-group">
										<input type="text" class="form-control small" name="keyword" id="keyword" placeholder="검색어"/>
										<div class="input-group-append">
											<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
											<button type="button" id="searchBtn" onclick="searchCheckChat(1);"class="btn btn-primary"> <i class="fas fa-search fa-sm" ></i> </button>
										</div>
									</div>
								</div>
							
								<div class="col-lg-3 col-md-3 col-sm-12 p-0 text-right"> <a href="<c:url value='/chat/downloadExel' />" class="btn btn-sm btn-success" target="_blank" id="excelDown">ExcelDown</a></div>
							</div> <br>
							<!-- END 검색 -->
								<!--  Begin 대화방 목록 -->
							<!-- <div class="wrap"> -->
							<table class="table  text-center " >
								<thead  class="thead-light">
									 <tr class="table-active"><th>번호</th><th>방번호</th> <th>대화방</th> <th>타입</th></tr>
								</thead>
								
								<tbody id="tbody"> </tbody>
							</table> 
							<input type='hidden' id='page' name='page' value='1' /><br>
							<div id="pageing"></div>
							<!-- </div>  -->
							<!-- End 대화 방 목록 -->
							<!-- 페이징(paging) -->
							</div>			
						</div>
						<!-- tab end -->
						
						<div class="tab-pane container fade" id="tabMap">
							<div id="map_div"></div>
						</div>
					</div>
				
					
				</div>
			</div>
		</div>
		<div class="col-lg-7">
			<div class="card">
			
				<div class="row g-0">
					
					<div class="col-12 col-lg-7 col-xl-8">
						<div class="py-2 px-4 border-bottom bg-light d-none d-lg-block">
														
							<div class="d-flex align-items-center py-1">
								<div class="position-relative"><h6 class="chat_room_no"></h6> </div>
								<div class="flex-grow-1 pl-3 text-primary"><strong class="chat_room_name"></strong></div>
								<div>
									<!-- onclick="initTmap();" -->
									<button class="btn btn-secondary btn-lg" id="voic"><i class="fa fa-microphone" aria-hidden="true"></i></button>
									<button class="btn btn-secondary btn-lg" id="voic" onclick="voicChange()"><i class="fa fa-microphone-slash" aria-hidden="true"></i></button>
									<button class="btn btn-secondary btn-lg"  data-toggle="modal" data-target="#mapModal" id="makerMap"><i class="fa fa-map" aria-hidden="true"></i></button>
									
									<!-- start Modal -->
									<div class="modal" id="mapModal">
									<div class="modal-dialog modal-xl modal-dialog-centered">   
									<div class="modal-content">
									
									<!-- Modal Header -->
									<div class="modal-header">
									<h5 class="modal-title text-primary">사용자 위치 정보</h5>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									</div>
									
									<!-- Modal body -->
									<div class="modal-body">
									<!-- <div id="map_div"></div> -->
									</div>
									
									<!-- Modal footer -->
									<div class="modal-footer">
									<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
									</div>
									
									</div>
									</div>
									</div>
									<!-- end Modal -->
									
								</div>
								
								
							</div>
						</div>							
						<div class="position-relative">
							<div class="chat-messages p-4">
								<div id="inChatUser"> </div>
								<div id="outChatUser"> </div><br>
								<div id="chatRoom"> </div>
								<div id="mqttClientMsg"> </div>
								<div id="msgSendView"> </div>
							</div>
						</div>
								
						<div class="flex-grow-0 py-3 px-4 border-top bg-light">
							<div class="input-group">
								<input type="text" id="msg" class="form-control" placeholder="메세지를 입력해 주세요">
								<button class="btn btn-secondary" id="btnMsg" ><i class="fa fa-times" aria-hidden="true" id="btnMsg_icon"></i></button>
							</div>
						</div>
					</div>

					
					<div class="col-12 col-lg-5 col-xl-4 "> <br>
						<div class="row g-0">	
							<div class="col-sm-12 text-primary text-center"><i class="fa fa-child"></i><span>사용자 참여 정보</span></div>
						</div> <br>
						
						 <div id="chatUser" style="magin:5px;"></div>
						
					</div>	
				</div>
			</div>
		</div>
	</div> <!-- End row-->
</div>	<!-- End of container-fluid -->
</div> <!-- End of Main Content -->
<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
</div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>