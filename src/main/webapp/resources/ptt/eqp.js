// 장비 목록
function listEqp(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	const URL = '/equip/listEqp.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listEqpCallback(data) : alert('user 목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listEqpCallback(data){	
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
		let equip_num = row.equip_num;
		let id = row.eqp_id;
		let name = row.eqp_nm;
		let type = row.eqp_typ;
		let co_num = row.co_num;
		
		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td>' + equip_num + '</td>');
		list_output.push('<td> <a href="#" data-toggle="modal" data-target="#eqpInfo" onclick="javascript:getEqp(' + equip_num + ');">' +  id + '</a></td>');
		list_output.push('<td>' + name + '</td>');
		list_output.push('<td>' + type + '</td>');
		list_output.push('<td>' + co_num + '</td>');
		list_output.push("</tr>");
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let max = _page.tempEndPage; // 총 페이지
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음
	
	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (!_page.prev && _list.length > 0) { page_output.push('<li class="page-item"><a href="javascript:listEqp(' + prev + ')"; class="page-link"><</a></li>'); } 

	for(let i = start; i <= end; i++) { 
		
		if (i == curPage) {
			page_output.push('<li class="page-item active"><a class="page-link">' + i + '</a></li>');
		} else {
			page_output.push('<li class="page-item"><a href="javascript:listEqp(' + i + ')"; class="page-link">' + i + '</a></li>');
		}
	}
	
	if (!_page.next && curPage < max) { page_output.push('<li class="page-item"><a href="javascript:listEqp(' + next + ')"; class="page-link">></a></li>'); }
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}

// 장비 등록
function addEqp() {
	let id = $('#eqp_id').val();
	let nm = $('#eqp_nm').val();
	let typ = $('#eqp_typ').val();
	let code = $('#co_num').val();
	let editor = $("#editor").val();
	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"dvc_regist",
	    "contents":{
	            "eqp_id"    : id,
	            "eqp_nm"    : nm,
	            "eqp_typ"   : typ,
	            "co_num"	: code,
	            "editor"    : editor
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('장비 등록 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do'; 
				window.location.href = '/equip/listEqp.do';		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 등록 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

// 장비 수정
function modEqp(){
	let num = $('#view_num').val();
	let id = $('#view_id').val();
	let nm = $('#view_nm').val();
	let typ = $('#view_type').val();
	let editor = $('#editor').val();

	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":sendTime(),
		"snd_type":"request",
		"command":"dvc_update",
	    "contents":{
	    		"equip_num" : num,
	            "eqp_id"	: id,
	            "eqp_nm"	: nm,
	            "eqp_typ"	: typ,
	            "editor"	: editor
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('장비 정보 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do';
				window.location.href = '/equip/listEqp.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


// 장비 삭제
function delEqp(){
	let num = $('#view_num').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"dvc_delete",
	    "contents":{ "equip_num" : num }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dvc',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('장비 정보 삭제 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/equip/listEqp.do'; 
				window.location.href = '/equip/listEqp.do'; 		
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('장비 정보 삭제 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    	debugger;
	    }
	});
} 

function getEqp(equip_num, callback, error) {
	const URL = '/equip/getViewEqp/' + equip_num + '.json';	

	$.get(URL, function(data){
		//location.href = "/equip/viewEqp?equip_num="+data.equip_num;

		$('input[name=view_num]').attr('value', data.equip_num);
		$('input[name=view_id]').attr('value', data.eqp_id);
		$('input[name=view_nm]').attr('value', data.eqp_nm);		
		$('input[name=view_type]').attr('value', data.eqp_typ);
		$('input[name=co_num]').attr('value', data.co_num);
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}


function deleteEqp(num) {
	console.log(num);
	
	
}