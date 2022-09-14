// MQTT 추가
function addMqtt() {
	//debugger;
	let id = $('#mqtt_svr_id').val();
	let ip = $('#mqtt_svr_ip').val();
	let port = $('#mqtt_svr_port').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"mqsvr_regist",
	    "contents":{
	            "mqtt_svr_id"	: id,
	            "mqtt_svr_ip"	: ip,
	            "mqtt_svr_port"	: port
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/svr',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('MQTT 등록 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 	
				window.location.href = '/server/listMqtt.do'; 		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('MQTT 등록 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


//MQTT 수정
function modMqtt(){
	//debugger;
	let num = $('#view_num').val();
	let id = $('#view_id').val();
	let ip = $('#view_ip').val();
	let port = $('#view_port').val();
	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"mqsvr_update",
	    "contents":{
	    	"mqtt_svr_num"	: num,
            "mqtt_svr_id"	: id,
            "mqtt_svr_ip"	: ip,
            "mqtt_svr_port" : port
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/svr',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('MQTT 정보 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 		
				window.location.href = '/server/listMqtt.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('MQTT 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

// MQTT 삭제
function delMqtt(){
	//debugger;
	let num = $('#view_num').val();
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"mqsvr_delete",
	    "contents":{
	            "mqtt_svr_num" : num
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/svr',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('MQTT 정보 삭제 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 		
				window.location.href = '/server/listMqtt.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('MQTT 정보 삭제 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

// **********  ********** MQTT 목록 가져오기 **********  **********
function listMqtt(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	

	const URL = '/server/listMqtt.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	
	console.log('URL... ' + URL);
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listMqttCallback(data) : alert('목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listMqttCallback(data){		
	console.log(data);
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
		let mqtt_svr_num = row.mqtt_svr_num;
		let mqtt_svr_id = row.mqtt_svr_id;
		let mqtt_svr_ip = row.mqtt_svr_ip;
		let mqtt_svr_port = row.mqtt_svr_port;

		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td>' + mqtt_svr_num + '</td>');
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#mqttInfo" onclick="javascript:getMqtt(' + mqtt_svr_num + ');">' +  mqtt_svr_id + '</a></td>');
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#mqttInfo" onclick="javascript:getMqtt(' + mqtt_svr_num + ');">' +  mqtt_svr_ip + '</a></td>');
		list_output.push('<td>' + mqtt_svr_port + '</td>');
 		list_output.push("</tr>");
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let max = _page.tempEndPage; // 총 페이지
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음

	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (!_page.prev && _list.length > 0) { page_output.push('<li class="page-item"><a href="javascript:listMqtt(' + prev + ')"; class="page-link"><</a></li>'); } 
	for(let i = start; i <= end; i++) { 
		if (i == curPage) {
			page_output.push('<li class="page-item active"><a class="page-link">' + i + '</a></li>');
		} else {
			page_output.push('<li class="page-item"><a href="javascript:listMqtt(' + i + ')"; class="page-link">' + i + '</a></li>');
		}
	}
	if (curPage < max) { page_output.push('<li class="page-item"><a href="javascript:listMqtt(' + next + ')"; class="page-link"><</a></li>'); }
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}

//MQTT 상세 정보 json 데이터 가져오시
function getMqtt(mqtt_svr_num, callback, error) {

	const URL = '/server/getViewMqtt/' + mqtt_svr_num + '.json';
	
	$.get(URL, function(data){
		$('input[name=view_num]').attr('value', data.mqtt_svr_num);
		$('input[name=view_id]').attr('value', data.mqtt_svr_id);
		$('input[name=view_ip]').attr('value', data.mqtt_svr_ip);		
		$('input[name=view_port]').attr('value', data.mqtt_svr_port);
		$('input[name=view_type]').attr('value', data.mqtt_svr_type);
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

