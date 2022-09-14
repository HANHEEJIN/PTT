// **********  ********** SIP 목록 가져오기 **********  **********
function getSipList() {
	svr_num = 1;
	const URL = '/server/getSipList/' + svr_num + '.json';	
	$.getJSON(URL, function(data){
		// userListSipCallback : lisetUser.jsp의 sip 목록, user.js의 userListSipCallback
		data.statusCode == 200 ? ( userAddSipCallback(data), userModSipCallback(data)) : alert('SIP 목록 실패');
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listSip(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	

	const URL = '/server/listSip.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	
	console.log('URL... ' + URL);
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listSipCallback(data) : alert('목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listSipCallback(data){		
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
		let svr_id = row.svr_id;
		let svr_ip = row.svr_ip;
		let svr_num = row.svr_num;
		let svr_port = row.svr_port;
		let svr_type = row.svr_type;
		let svr_rpt_start_port = row.svr_rpt_start_port;
		
		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#sipInfo" onclick="javascript:getSip(' + svr_num + ');">' + svr_id  + '</a></td>');
		
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#sipInfo" onclick="javascript:getSip(' + svr_num + ');">' + svr_ip  + '</a></td>');
		list_output.push('<td>' + svr_port + '</td>');
		list_output.push('<td>' + svr_type + '</td>');
		list_output.push('<td>' + svr_rpt_start_port + '</td>');
 		list_output.push("</tr>");
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let max = _page.tempEndPage; // 총 페이지
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음

	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (!_page.prev && _list.length > 0) { page_output.push('<li class="page-item"><a href="javascript:listSip(' + prev + ')"; class="page-link"><</a></li>'); } 
	for(let i = start; i <= end; i++) { 
		
		if (i == curPage) {
			page_output.push('<li class="page-item active"><a class="page-link">' + i + '</a></li>');
		} else {
			page_output.push('<li class="page-item"><a href="javascript:listSip(' + i + ')"; class="page-link">' + i + '</a></li>'); 
		}
	}
	if (curPage < max) { page_output.push('<li class="page-item"><a href="javascript:listSip(' + next + ')"; class="page-link">></a></li>'); }
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}

function listSip(page){	
	$("#page").val(page);
	let searchType = $("#searchType option:selected").val();
	let keyword = $('#keyword').val();
	

	const URL = '/server/listSip.do/' + page.toString() + '/' + searchType + '/' + keyword;		
	
	console.log('URL... ' + URL);
	$.getJSON(URL, function(data){
			data.statusCode == 200 ? listSipCallback(data) : alert('목록 실패');
			
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function listSipCallback(data){		
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
		let svr_id = row.svr_id;
		let svr_ip = row.svr_ip;
		let svr_num = row.svr_num;
		let svr_port = row.svr_port;
		let svr_type = row.svr_type;
		let svr_rpt_start_port = row.svr_rpt_start_port;
		
		list_output.push('<tr>');
		list_output.push('<td>' + num + '</td>');
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#sipInfo" onclick="javascript:getSip(' + svr_num + ');">' + svr_id  + '</a></td>');
		
		list_output.push('<td><a href="#" data-toggle="modal" data-target="#sipInfo" onclick="javascript:getSip(' + svr_num + ');">' + svr_ip  + '</a></td>');
		list_output.push('<td>' + svr_port + '</td>');
		list_output.push('<td>' + svr_type + '</td>');
		list_output.push('<td>' + svr_rpt_start_port + '</td>');
 		list_output.push("</tr>");
	}

	let page_output = [];
	let start = _page.startPage; // 시작
	let end = _page.endPage;	 // 끝
	let prev = curPage - 1;		 // 이전
	let next = curPage + 1;		 // 다음

	page_output.push('<ul class="pagination pagination-sm justify-content-center" >');
	if (!_page.prev && _list.length > 0) { page_output.push('<li class="page-item"><a href="javascript:listSip(' + prev + ')"; class="page-link">이전</a></li>'); } 
	for(let i = start; i <= end; i++) { page_output.push('<li class="page-item"><a href="javascript:listSip(' + i + ')"; class="page-link">' + i + '</a></li>'); }
	if (curPage < end) { page_output.push('<li class="page-item"><a href="javascript:listSip(' + next + ')"; class="page-link">다음</a></li>'); }
	page_output.push('</ul>');
	
	$("#tbody").html(list_output.join(''));
	$("#pageing").html(page_output.join('')); 
}
function addSip() {
	//debugger;
	let svr_num = $('#svr_num').val();
	let ip = $('#svr_ip').val();
	let id = $('#svr_id').val();
	let port = $('#svr_port').val();
//let type = $('input:checkbox[name="svr_type"]').val();
	let type = $("select[name=svr_type]").val();
	
	
	let rpt_port = $('#svr_rpt_start_port').val();
	let rpt_cnt = $('#svr_rpt_count_port').val();
	
	let oParam = {
		"svr_num"				: svr_num,
	    "svr_id"				: id,
	    "svr_ip"				: ip,
	    "svr_port"				: port,
	    "svr_type"				: type,
		"svr_rpt_start_port"	: rpt_port,
	    "svr_rpt_count_port"	: rpt_cnt
	  };

	$.ajax({
		url : '/server/sip/new',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json; charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.statusCode == 200 ) {	
	    		alert('SIP 등록 성공');
				window.location.href = '/server/listSip.do'; 		
	    	} else {	    		
	    		alert('SIP 등록 실패');
	    		//return;
	    	}
	    },
	    error: function(request, status, error) {
			alert('SIP 등록 실패');
			alert("code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:"
					+ error);
		}
	});
}

function modSip(){
	let svr_num = $('#view_num').val();
	let id = $('#view_id').val();
	let ip = $('#view_ip').val();
	let port = $('#view_port').val();
	//let type = $('#view_type').val();
	let rpt_port = $('#view_rpt').val();
	let rpt_cnt = $('#view_rpt_count').val();
	

	let type = $("select[name=view_type]").val();
	
	
	

	let oParam = {
		"svr_num"				: svr_num,
	    "svr_id"				: id,
	    "svr_ip"				: ip,
	    "svr_port"				: port,
	    "svr_type"				: type,
		"svr_rpt_start_port"	: rpt_port,
	    "svr_rpt_count_port"	: rpt_cnt
	};
		
	$.ajax({
		url : '/server/sip/' + svr_num,
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.statusCode == 200 ) {	
	    		alert('SIP 정보 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/server/listSip.do'; 
				window.location.href = '/server/listSip.do'; 		
	    	} else {	    		
	    		alert('SIP 정보 수정 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    }
	});
}

//SIP 삭제
function delSip(){
	let svr_num = $('#view_num').val();
	let oParam = { "svr_num" : svr_num };
	
	$.ajax({
		url : '/server/sip/' + svr_num,
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.statusCode == 200 ) {	
	    		alert('SIP 정보 삭제 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/server/listSip.do';
				window.location.href = '/server/listSip.do'; 		
	    	} else {	    		
	    		alert('SIP 정보 삭제 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    }
	});
}

//sip 상세 정보 json 데이터 가져오시
function getSip(svr_num, callback, error) {
	//console.log(svr_num);

	const URL = '/server/getViewSip/' + svr_num + '.json';
	
	$.get(URL, function(data){

		$('input[name=view_num]').attr('value', data.svr_num);
		$('input[name=view_id]').attr('value', data.svr_id);
		$('input[name=view_ip]').attr('value', data.svr_ip);		
		$('input[name=view_port]').attr('value', data.svr_port);
		$('input[name=view_type]').attr('value', data.svr_type);
		
		//let type = $("select[name=view_type]").val();
		
		//$('select[name=view_type]').attr('selected', data.svr_type);
		
		
		
		switch (data.svr_type) {
			case 'SIP' : 
		   		$("#view_type").val("SIP").prop("selected", true);
			    break;
			case 'MQTT' : 
			    $("#view_type").val("MQTT").prop("selected", true);
			    break; 
			case 'MDS' :
				 $("#view_type").val("MDS").prop("selected", true);

			default :  
				//$("#view_type").text("선택해주세요").prop("selected", true);
		}
		
 
		
		//$("#selectBox > option[@value=지정값]").attr("selected", "true");
		
		
		$('input[name=view_rpt]').attr('value', data.svr_rpt_start_port);
		$('input[name=view_rpt_count]').attr('value', data.svr_rpt_count_port);
		//console.log(data.svr_rpt_start_port);
		//console.log(data.svr_rpt_count_port);
		
		/* 
		let view_output = [];
		view_output.push('<input type="text" class="form-control" name="view_ip" id="view_ip" value="' + data.svr_num + '" >');
		view_output.push('<input type="text" class="form-control" name="view_num" id="view_num" value="' + data.svr_id + '" >');
		view_output.push('<input type="text" class="form-control" name="view_id" id="view_id" value="' + data.svr_ip + '" >');
		view_output.push('<input type="text" class="form-control" name="view_port" id="view_port" value="' + data.svr_port + '" readonly>');
		view_output.push('<input type="text" class="form-control" name="view_type" id="view_type" value="' + data.svr_type + '"  readonly>');
		$('#getSip').html(view_output.join(''));
		 */	
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}