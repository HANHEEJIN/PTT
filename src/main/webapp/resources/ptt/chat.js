//대화방 목록
function listChat(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	const URL = '/chat/listChat.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listChatCallback(data) : alert('user 목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}
// ********** ********** 대화방 목록 ********** **********
function listChatCallback(data){	
	//console.log('data' + JSON.stringify(data));
	let _list = data.data.list;
	let list_output = [];
	let _page = data.data.pageMaker;
	let curPage = _page.cri.page; // 현재 페이지
	

	if (_list.length == 0) {
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>조회 정보가 일치하지 않습니다.</td>");
		list_output.push("</tr>");
	} 	

	for(let i in _list) {
		let row = _list[i];
		let num = row.rnum;
		let chat_room_num = row.chat_room_num;	// 대화방 번호
		let name = row.chat_room_nm;			// 대화방 이름
		let type = row.chat_room_typ;			// 대화방 타입

		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td>' + chat_room_num + '</td>');
		list_output.push('<td> <a href="#" onclick="javascript:getMsg(' + chat_room_num + ',\'' + name + '\');');
		list_output.push('roomUser(' + chat_room_num + '); roomJoinClick(' + chat_room_num + ') ">' + name + '</a></td>');
		list_output.push('<td>' + type + '</td>');
		list_output.push('</tr>');
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let max = _page.tempEndPage; // 총 페이지
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음

console.log('curPage' + curPage);
	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (_page.prev/* && _list.length > 0*/ && curPage > 1) { page_output.push('<li class="page-item"><a href="javascript:listChat(' + prev + ')"; class="page-link"><</a></li>'); } 
	//else if (!_page.prev && start > 10) { page_output.push('<li class="page-item"><a href="javascript:listChat(' + prev + ')"; class="page-link"><</a></li>'); } 
	for(let i = start; i <= end; i++) { 
		if (i == curPage) {
			page_output.push('<li class="page-item active"><a class="page-link">' + i + '</a></li>');
		} else {
			page_output.push('<li class="page-item"><a href="javascript:listChat(' + i + ')"; class="page-link">' + i + '</a></li>');
		}
	}
	if (curPage < max) { page_output.push('<li class="page-item"><a href="javascript:listChat(' + next + ')"; class="page-link">></a></li>'); }
	
	
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}

// ********** ********** 대화방 추가 ********** **********
function addChat() {
	//console.log('add chat');
	let num = $('#chat_user_num').val();
	let nm = $('#chat_room_nm').val();
	let pw = $('#chat_room_pwd').val();
	let typ = $('#chat_room_typ').val();
	
	let editor = $("#editor").val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"2021-01-01 22:14:16",
	    "snd_type":"request",
	    "command":"room_create",
	    "contents":{
	            "user_num"		 : num,
	            "chat_room_nm"	 : nm,
	            "chat_room_pwd"	 : pw,
	            "chat_room_type" : typ,
	            "editor"		 : editor
	    }
	}
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/room',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			data.is_success ? (alert('대화방 등록 성공'), window.location.href = '/chat/listChat.do') : alert('대화방 등록 실패');
			
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

// ********** ********** 대화방 삭제 ********** **********
function delChat() {
	//console.log('add chat');
	let num = $('#chat_room_num').val();
	let pwd = $('#chat_room_pwd').val();

	
	let editor = $("#editor").val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"room_delete",
	    "contents":{
	        "chat_room_num": "444",
	        "chat_room_pwd": "1234"
	    }
	
	}
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/room',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){

			data.is_success ? (alert('대화방 삭제 성공'), window.location.href = '/chat/listChat.do') : alert('대화방 삭제 실패');
			
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

// ********** ********** 대화방 참가자 정보 ********** **********
function roomUser(chat_room_num){
	
	// 이전 마커 지우기
	removeMarkers();
	
	console.log('chat_room_num' + chat_room_num);
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"room_join_users",
	    "contents":{
	            "user_num"		: 352,
	            "chat_room_num"	: chat_room_num
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
	    	data.is_success ? roomUserCallback(data) : alert('참여자 정보 조회 실패');
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

function roomUserCallback(data){
	console.log(data);
	$('#chatUser').html('')
	let users = data.data.contents.users;
	let list_output = [];
		
	//if(data.length === 0){ list_output.push('<h6> 대화 참여자 없음</h6>'); }
	
	if(users.length === 0){
		console.log('contents' + users);
		list_output.push('<h5 class="bg-light text-center text-danger p-3" >사용자정보가 없습니다.</h5>');
	}
	
	
	$.each(users, function(i, item) {	
		let name = users[i].user_nm;
		let num = users[i].user_num;
		let id = users[i].user_id;
		let lat = users[i].latitude;	
		let lon = users[i].longitude;	
		
		if(id !== null) {
			list_output.push('<a href="#" class="list-group-item list-group-item-action border-0" >');
			list_output.push('<div class="badge bg-outline-primary float-right text-warning login_id">' + id + '</div>');
			list_output.push('<div class="d-flex align-items-start">'); 			
			list_output.push('<h6 class="login_no">' + num + '</h6>');
			list_output.push('<div class="flex-grow-1 ml-3 login_nm">' + name + '</div>');
			list_output.push('</div>');
			list_output.push('</a>');
			
			//markerNo = 'http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_' + num + '.png';
			
			// lat lon이 널 값이 아닐때
			if(lat !== null && lon !== null){
				// 마커 표시
				//initTmap(lat, lon);
				coords = new Tmapv2.LatLng(lat , lon);
				marker = new Tmapv2.Marker({
					position : coords, //Marker의 중심좌표 설정.
					//icon : markerNo,
					map : map, //Marker가 표시될 Map 설정.
				});
				addDrowMarker(coords);
				//location.href = '#tabMap';
				
				// tabMap
			}
			
		}
		
	});	
	

	$('#chatUser').append(list_output.join(''));
}


// ********** ********** getMsg 대화내용 가져오기 ********** **********
function getMsg(chat_room_num, name){
	
	// 대화방 번호, 제목 리셋
	//$('#btnMsg').attr('value', 'X');
	//$('#btnMsg').attr('value', 'X');
	
	$('.chat_room_no').html('')
	$('.chat_room_name').html('')
	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":"{{currentTime}}",
		"snd_type":"request",
		"command":"talk_scroll_admin",
		"contents":{
		        "chat_room_num":chat_room_num
		}
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/roomjoin",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	data.is_success ? getMsgCallback(data, name) : alert('대화내용을 불러올수 없습니다. 관리자에게 문의하세요');
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

function getMsgCallback(data, name){
	console.log(JSON.stringify(data));
	$(".chat_room_name").text(name);
	//console.log('data data' + JSON.stringify(data));
	// 메시지 보내기, 버튼, 지도 마커 활성화
	$('#msg').attr('placeholder', '메세지를 입력해 주세요.');
	$('#msg').attr('readonly', false);
	//$('#btnMsg').attr('disabled', false);
	$('#makerMap').attr('disabled', false);

	let i_output = [];
	let contents = data.data.contents;
	
	$('#msgSendView').html('');
	$('#msg').val('');

	if(contents.length === 0){i_output.push('<h5 class="bg-light text-center text-danger p-3" >대화내용이 없습니다</h5>');}
	
	// 대화 내용 리스트화 하기
	$.each(contents, function(i, item) {			
		//console.log('contents data' + JSON.stringify(contents));
		let no = contents[i].chat_room_num;
		$(".chat_room_no").text(no);

		let msg = contents[i].snd_msg.text;
		//let msg_typ = contents[i].msg_typ;
		//let lat = contents[i].snd_msg.lat;
		//let lon = contents[i].snd_msg.lon;
		
		//let msg = contents[0].snd_msg.text;
		
		// 대화상대 비교
		//if(){}
		

		console.log('contents type' + item.msg_typ);
		if(item.msg_typ === 'TEXT' || item.msg_typ === 'text'){
			if(item.snd_msg !== '') {
			i_output.push('<div class="chat-message-left pb-4">');
			i_output.push('<div> <div class="text-muted small text-nowrap mt-2">' + item.user_nm + '</div> </div>');
			i_output.push('<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">');
			i_output.push('<div class="font-weight-bold mb-1">' + msg + '</div>');
			i_output.push('<h6><small>' + displayTime(item.snd_ymdt) + '</small></h6>');
		} else {
			i_output.push('<h6>대화내용 NULL 값 오류</h6>');
		}
		}
		
		
		
		i_output.push('</div>');
		i_output.push('</div>');	
	});
	
	 $('#chatRoom').html(i_output.join(''));
	 $('.chat-messages').scrollTop($('.chat-messages')[0].scrollHeight);
}

// ********** ********** 메세지 보내기 ********** **********
function sndMsg(msg) {
	debugger;
	
	let no = $(".chat_room_no").text();
	
	let sessionId = $("#sessionId").val(); 
	let login_id = $(".login_id").text(); 
	let login_nm ='';
	let login_no = '';
	console.log('ssss');
	console.log(sessionId);
	console.log(login_id);
	if(sessionId === login_id){
		console.log('cccc');
		login_nm = $(".login_nm").text(); 
		login_no = $(".login_no").text(); 
	}
	console.log('no ' + login_no);
	console.log('nm ' + login_nm);
	
	
	
	
	let oParam = 
		{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt": sendTime(),
	    "snd_type":"request",
	    "command":"snd_msg",
	    "contents":{
	        "user_num"		: login_no,
	        "user_nm"		: login_nm,
	        "chat_room_num" : no,
	        "rcv_user_num"	: 0,
	        "snd_msg":{
	            "text"		: msg,
	            "lat" 		: 27.55652100,
	            "lon" 		: 128.5522000
	        },
	        "msg_typ":"TEXT",
	        "snd_eqp_nm":"mac",
	        "snd_eqp_typ":"woki",
	        "explain" : "msg type : ENTERANCE, EXIT, REMOVE, TEXT, GPS, VOICE, MIC_REQ, MIC_CANCEL"
	    }
	}
		
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/msg',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			
			// href이동 해당 메세지 방으로 이동 /*window.location.href = '/chat/listChat.do')*/
			data.is_success ? sndMsgCallBack(data, msg) : alert('메세지를 보낼 수 없습니다. 관리자에게 문의하세요.');
	    },
	    error: function (){
	    	debugger;
	    }
	});

}

function sndMsgCallBack(data, msg) {
	
	let output = [];
	let day = data.data.snd_ymdt;

			
	output.push('<div class="chat-message-right mb-4">');
	output.push('<div> <div class="text-muted small text-nowrap mt-2 ">사용자</div> </div>'); //사용자
	output.push('<div class="flex-shrink-1 bg-primary rounded py-2 px-3 mr-3">');
	output.push('<div class="font-weight-bold mb-1 text-white">' + msg + '</div>');
	output.push('<h6 class="text-white"><small>' + displayTime(day)+ '</small></h6>');
	output.push('</div></div>');
	$("#msgSendView").html(output.join(''));
	$('.chat-messages').scrollTop($('.chat-messages')[0].scrollHeight);
	$('#msg').val('');
	
	// window.location.href = '/chat/listChat.do'
	
	// 대화내용 가져오기
	let chat_room_num = $(".chat_room_name").text();
	let name = $(".chat_room_no").text();
	
	console.log('SND' + chat_room_num);
	console.log('SND' + name);
	
	//getMsg(chat_room_num, name);
}




