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
$(document).ready(function() {	 listChat(1);  });




//getMsg 대화내용 가져오기
function getMsg(chat_room_num, callback, error) {
	//console.log(chat_room_num);
	
	$('#msg').attr('placeholder', '메세지를 입력해 주세요.');
	$('#msg').attr('readonly', false);
	$('#btnMsg').attr('disabled', false);
	
	
	
	const URL = '/chat/getMsg/' + chat_room_num + '.json';
	let i_output = [];
	
	$.get(URL, function(data){
		
		
		
		$('#msgSendView').html('');
		$('#msg').val('');
		//console.log(data);

		if(data.length === 0){
			i_output.push('<h6>대화내용이 없습니다</h6>');
		}
		
		// 대화 내용 리스트화 하기
		$.each(data, function(i, item) {			
			// 대화상대 비교
			//if(){}

			//  || item.snd_msg !== "" || item.snd_msg !== null || item.snd_msg !== undefined
			if(item.snd_msg !== '') {

				i_output.push('<div class="chat-message-left pb-4">');
				i_output.push('<div> <div class="text-muted small text-nowrap mt-2">${row.snd_ymdt}</div> </div>');
				i_output.push('<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">');
				i_output.push('<div class="font-weight-bold mb-1">ID :' + item.snd_user_num + '</div>');
				i_output.push('<h5>' + item.snd_msg + '</h5>');
				i_output.push('<h6><small>' + item.snd_ymdt + '</small></h6>');
			} else {
				i_output.push('<h6>대화내용 NULL 값 오류</h6>');
			}
			
			i_output.push('</div>');
			i_output.push('</div>');	
		});
		
		 $('#chatRoom').html(i_output.join(''));
		 $('.chat-messages').scrollTop($('.chat-messages')[0].scrollHeight);
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

//getChatUser 대화 참여자 정보 가져오기
function getChatUser(chat_room_num, callback, error) {
	const URL = '/chat/getChatUser/' + chat_room_num + '.json';
	let i_output = [];
	
	$.get(URL, function(data){
		
		if(data.length === 0){ i_output.push('<h6> 대화 참여자 없음</h6>'); }
		
		// 대화 참여자 정보 불러오기
		$.each(data, function(i, item) {	
			user_num = item.user_num;
			getUserInfo(user_num);
		});
		
		 $('#chatUser').html(i_output.join(''));
		 
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

let i_output = [];
let id_list = []; 

function getUserInfo(user_num) {
	$('#chatUser').html('');
	const URL = '/chat/findUserInfo/' + user_num + '.json';
	
	$.get(URL, function(data){

		let room = data[0].chat_room_num;
		console.log('***** ****** ROOM ' + room + ' CHAT USER INFO ***** ******')
		$.each(data, function(i, item) {
			let name = data[0].info[0].user_nm;
			let num = data[0].info[0].user_num;
			let id = data[0].info[0].user_id;
			
			if ($.inArray( id, id_list ) == -1)
			{
				// 대화 참여자 정보 초기화 한뒤 가져오기
				$('#chatUser').html('')
				
				i_output.push('<div class="badge bg-success float-right">' + id + '</div>');
				i_output.push('<div class="d-flex align-items-start">'); 			
	 			i_output.push('<h6>' + num + '</h6>');
				i_output.push('<div class="flex-grow-1 ml-3">' + name + '</div>');
				i_output.push('</div>');
				
				id_list.push(id);
			}

		});		
	
		$('#chatUser').append(i_output.join(''));
		 
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function inviUser() {
	let oParam = 
	{
		"snd_id"	: "ghs.co.kr",
		"snd_device": "pc-1111",
		"snd_ymdt"	: "{{currentTime}}",
		"snd_type"	: "request",
		"command"	: "user_list",
		"contents"	: 
		{
			"pageNum" : 1,
			"type" 	  : 'NONE',
			"search"  : ''
		}
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/user",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
	    	// 게시글 목록 데이터 값 확인
	    	data.is_success ? listinviUserCallback(data) : alert('게시글 목록 실패');

	    },
	    error: function (){
	    	debugger;
	    }
	});
}


function listinviUserCallback(data){
	let _list = data.data.contents.list;	// 데이터 배열
	
	let list_output = [];
	if (_list.length == 0) {
		list_output.push("<tr>");
		list_output.push("<td colspan='5' style='color:red;'>사용자가 존재하지 않습니다.</td>");
		list_output.push("</tr>");
		return;
	}
	
	for(let i in _list) {
		let row = _list[i];
		
		let user_num = row.user_num;
		let user_nm = row.user_nm;
		let user_id = row.user_id;
		list_output.push('<a href="${path}/user/viewUser?user_num=' + user_num + '" class="list-group-item">');
		list_output.push('<h6 class="media-heading">' + user_id + '</h6>');
		list_output.push('<small>' + user_num + ' | ' + user_nm + '</small>');
		list_output.push('</a>');

	}
	$("#inviUser").html(list_output.join(''));
}


$(document).ready(function() {	
	
	listChat22();
	$('#msg').attr('placeholder', '대화방을 클릭해 주세요');
	$('#msg').attr('readonly', true);
	$('#btnMsg').attr('value', 'X');
	$('#btnMsg').attr('disabled', true);
	
	
	$('#btnInChat').click(function() { confirm('입장하시겠습니까?') ? inChat() : false; }); 	// 사용자 입장
	$('#btnOutChat').click(function() { confirm('퇴장하시겠습니까?') ? outChat() : false; }); // 사용자 퇴장
	

	let output = [];
	$('#btnMsg').click(function() { 
		
		let msg = $('#msg').val();
		// 입력 null 값 처리
		if(msg != '') {
			
			output.push('<div class="chat-message-left pb-4">');
			output.push('<div> <div class="text-muted small text-nowrap mt-2">2020.08 <small>today</small></div> </div>');
			output.push('<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">');
			output.push('<div class="font-weight-bold mb-1">ID : ADMIN</div>');
			output.push(msg);
			output.push('</div></div>');
				
			$("#msgSendView").html(output.join(''));
			
			$('.chat-messages').scrollTop($('.chat-messages')[0].scrollHeight);

			$('#msg').val('');
		} else {
			alert('메세지를 입력하세요');
		}
		
	}); 
	
	// 메세지 전송 엔터키
	$("#msg").keypress(function (e) {
        if (e.keyCode === 13) {
        	$('#btnMsg').click(); 
        }
    });
	
	
});

function listChat22(){
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"room_join_users",
	    "contents":{
	            "user_num"		: 385,
	            "chat_room_num"	: 327
	    }
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/roomjoin",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
	    	// 게시글 목록 데이터 값 확인
	    	//data.is_success ? listinviUserCallback(data) : alert('게시글 목록 실패');
	    	
	    	console.log(data);

	    },
	    error: function (){
	    	debugger;
	    }
	});
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
<div class="container-fluid">
    <div class="row ">
		<div class="col-5">
			<div class="card h-100">
				<div class="card-body"> <br>
					<a class="nav-link" data-toggle="modal" data-target="#addChat" href="#" ><i class="fa fa-comments"></i><span>대화방추가</span></a>
					
					<!-- Begin Modal -->
					<div class="modal" id="addChat">
						<div class="modal-dialog">
							<div class="modal-content">
							      
							    <!-- Modal Header -->
								<div class="modal-header">
									<h5 class="modal-title">대화방 추가</h5>
									<button type="button" class="close" data-dismiss="modal">×</button>
								</div>
								        
								<!-- Modal body -->
								<div class="modal-body" >
									<!-- SIP 추가 BEGIN -->
									<div class="row gutters">
										<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">대화방 추가</h6></div>
									</div>
									<div class="row gutters">
										<div class="col-xl-8 col-lg-9 col-md-9 col-sm-9 col-12">
											<div class="form-group">
												<label for="id">관리자</label>
												<input type="text" class="form-control" name="editor" id="editor" value="${sessionId}" readonly>
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
									<button type="button" id="btnInsert" class="btn btn-primary">추가</button>
									<button type="button" class="btn btn-secondary" data-dismiss="modal" >취소</button>
								</div>    
							</div>
						</div>
					</div>
					<!-- End Modal -->
					<!-- Page Heading -->

					
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
						<thead  class="thead-dark">
							 <tr class="table-active"><th>번호</th><th>방번호</th> <th>대화방</th> <th>타입</th> </tr>
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
		</div>
		<div class="col-7">
			<div class="card">
				<div class="card">
					<div class="row g-0">
						<div class="col-12 col-lg-7 col-xl-8">
							<div class="py-2 px-4 border-bottom d-none d-lg-block">
															
								<div class="d-flex align-items-center py-1">
									<div class="position-relative"><h5>NO</h5> </div>
									<div class="flex-grow-1 pl-3"><strong>대화제목</strong>
										<div class="text-muted small"><em>대화참여자</em> </div>							
									</div>
									<div>
										<button class="btn btn-info btn-lg mr-1 px-3 d-none d-md-inline-block"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-video feather-lg"><polygon points="23 7 16 12 23 17 23 7"></polygon><rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect></svg></button>
										<button class="btn btn-light border btn-lg px-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-horizontal feather-lg"><circle cx="12" cy="12" r="1"></circle><circle cx="19" cy="12" r="1"></circle><circle cx="5" cy="12" r="1"></circle></svg></button>
									</div>
								</div>
							</div>
									
													
							<div class="position-relative">
								<div class="chat-messages p-4">
									<button type="button" id="btnInChat" class="btn btn-outline-primary btnIn">입장</button> <br>
									<button type="button" id="btnOutChat" class="btn btn-outline-danger btnOut">퇴장</button>
									<div id="inChatUser"> </div>
									<div id="outChatUser"> </div><br>
									<div id="chatRoom"> </div> 
									<div id="msgSendView"> </div>
									
									<%-- 
									<c:forEach var="row" items="${MSG}" >
									<div class="chat-message-left pb-4">
										<div> <div class="text-muted small text-nowrap mt-2">${row.snd_ymdt}</div> </div>
										<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
											<div class="font-weight-bold mb-1">ID : HAN</div>
												<c:if test = "${empty row.snd_msg}"> <h6>대화내용이 없습니다.</h6></c:if>
												<c:if test = "${!empty row.snd_msg}"> ${row.snd_msg} </c:if>
										</div>
									</div>
															
									<%--	
									<div class="chat-message-right mb-4">
										<div><div class="text-muted small text-nowrap mt-2">2:43 am</div></div>
										<div class="flex-shrink-1 bg-light rounded py-2 px-3 mr-3">
											<div class="font-weight-bold mb-1">ID : HOME</div>
												6시이지.. 않을까여?
										</div>
									</div>
									%-->
									</c:forEach>--%>
								</div>
							</div>
									
							<div class="flex-grow-0 py-3 px-4 border-top">
								<div class="input-group">
									<input type="text" id="msg" class="form-control" placeholder="메세지를 입력해 주세요">
									<button class="btn btn-primary" id="btnMsg" >전송</button>
								</div>
							</div>
						</div>

						
						<div class="col-12 col-lg-5 col-xl-4 border-right"> <br>
							<div class="row">
							
								<div class="col-sm-12"><a class="nav-link" href="#" data-toggle="modal" data-target="#invitation"   onclick="inviUser()"><i class="fa fa-child"></i><span>사용자추가</span></a></div>
								
								
								
							</div>
							
							
							
							<a href="#" class="list-group-item list-group-item-action border-0">
								<div id="chatUser"></div>
							</a>
						</div>
						
						<!-- Begin Modal -->
						<div class="modal" id="invitation">
							<div class="modal-dialog">
								<div class="modal-content">
								      
								    <!-- Modal Header -->
									<div class="modal-header">
										<h5 class="modal-title">사용자 초대</h5>
										<button type="button" class="close" data-dismiss="modal">×</button>
									</div>
									        
									<!-- Modal body -->
									<div class="modal-body" >
										<div class="list-group people-group">
											<div id="inviUser"></div>
										</div>
									</div>
										
						        
									<!-- Modal footer -->
									<div class="modal-footer">
										<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
									</div>
								        
								</div>
							</div>
						</div>
						<!-- End Modal -->
					</div>
				</div>
			</div>
		</div>
	</div>

	
	
		
		<!-- 

		<div class="card bg-muted" id="_msg">
			<h5 class="m-0 font-weight-bold text-primary">대화내용을 불러올 수 없습니다</h5>
		</div>
				
		<div class="card bg-muted" id="chat_user">
			<h5 class="m-0 font-weight-bold text-primary">사용자 정보를 불러올 수 없습니다</h5>
			<div ></div>
		</div>
		
		-->
		
		
	</div>
	
</div>
<!-- End of Main Content -->
<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
</div> <!-- End of Content Wrapper -->
</div> <!-- End of Page Wrapper -->
</body>
</html>