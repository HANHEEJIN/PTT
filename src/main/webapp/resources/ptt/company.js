// ********** ********** ******** 회사55 ********** ********** **********
// 회사 목록
function listCom(num) {
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"com_list",
	    "contents":{
	     }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/company',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){	    	
	    	// 게시글 목록 데이터 값 확인, insertUser.js company 목록
			if(data.is_success) {

				// (1) 회사정보등록_리스트, (2) 사용자정보등록_리스트, (3) 사용자정보수정_리스트
				if (num == 1){
					listComCallback(data);
				} else if (num == 2){
					console.log('2  xx' + num);
					userComCallback(data);
				} else if (num == 3){
					userViewComCallback(data)
				} else {
					
				}
				
			} else {
				alert('회사 목록 실패');
			}
	    	
	    },
	    error: function (){

	    }
	});
}

function listComCallback(data){

	let _list = data.data.contents;

	let list_output = [];
	if (_list.length == 0) {
		list_output.push('<tr>');
		list_output.push('<td colspan="5" style="color:red;">등록된 글이 존재하지 않습니다.</td>');
		list_output.push('</tr>');
		return;
	}
	
	for(let i in _list) {
		let row = _list[i];
		let co_index = row.co_index;
		let co_name = row.co_name;
		let co_num = row.co_num;
		
		console.log('co_num ssssssssssss'+ co_num);
		
		list_output.push('<tr class="candidates-list" onclick="javascript:clickRow(this);">');		
		
		list_output.push('<td>' + co_num + '</td>');
		
		// 함수 매개변수 문자열 처리
		//list_output.push("<td> <a href='#' onclick='javascript:listUpDpart(\"" + co_num + "\"); getViewCompany(" + co_index + ");'>" + co_name + "</a></td>");
		
		list_output.push('<td> <a href="#" onclick="javascript:listUpDpart( ' + 1 + ', \'' + co_num + '\'); getViewCompany(' + co_index + ');">' + co_name + '</a></td>');
		
		// 문자열 : list_output.push(`<td> <a href="#" onclick="javascript:listDpart('` + co_num + `');">` + co_name + `</a></td>`);
		// 숫자	: list_output.push("<td> <a href='#' onclick='javascript:listDown(" + dpart_index + ");'>" + dpart_nm + "</a></td>");
		list_output.push('<td>' + co_index + '</td>');
		list_output.push('</tr>');	
	}
	$('#tbodyCom').html(list_output.join(''));
}





// 회사 상세정보 조회
function getViewCompany(co_index, callback, error) {
	
	const URL = '/dpart/getViewCompany/' + co_index + '.json';
	$.get(URL, function(data){	
		// 상위,하위 부서 등록 회사 코드 value 값 변경
		$('input[name=down_co_num]').attr('value', data.co_num);
		$('input[name=up_co_num]').attr('value', data.co_num);
		
		// 상세정보 상위 부서 등록 회사 코드 value 값 변경
		$('input[name=view_co_index]').attr('value', data.co_index);
		$('input[name=view_co_name]').attr('value', data.co_name);
		$('input[name=view_co_num]').attr('value', data.co_num);
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}


// 회사 등록
function addCom() {
	//debugger;
	let nm = $('#co_name').val();
	let num = $('#co_num').val();
	let editor = $('#editor').val();

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"com_regist",
	    "contents":{
	        "co_name" : nm,
	        "co_num"  : num,
	        "editor"  : editor
	    }
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/company",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('회사 등록 성공');
		    	// window.location.href = '${pageContext.request.contextPath}/dpart/insertDpartForm'; 
				window.location.href = '/dpart/insertDpartForm'; 		
	    	} 
			
	    	if( !data.is_success ) {	    		
	    		alert('회사 등록 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

//회사 수정
function modCom() {
	let num = $('#view_co_index').val(); // 회사 번호
	let name = $('#view_co_name').val(); // 회사 이름
	let code = $('#view_co_num').val();  // 회사 코드

	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"com_update",
	    "contents":{
	            "co_index" : num,
	            "co_name"  : name,
	            "co_num"   : code
	    }
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/company",
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('회사 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/dpart/insertDpartForm'; 	
				window.location.href = '/dpart/insertDpartForm';	
	    	} 
			
	    	if( !data.is_success ) {	    		
	    		alert('회사 수정 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}

//회사 삭제
function delCom() {
	let index = $('#view_co_index').val();
	
	let requestParam = {
		"snd_id": "ghs.co.kr",
		"snd_device": "pc-1111",
		"snd_ymdt": sendTime(),
		"snd_type": "request",
		"command": "com_delete",
		"contents": {
		  "co_index": index
		}
	}

	$.ajax({
		"url": "http://211.119.132.242:2000/ptt/company",
		"method": "DELETE",
		"headers": { "Content-Type": "application/json"},
		"data": JSON.stringify(requestParam),
		success: function(data){
			if( data.is_success ) {	
			alert('회사 삭제 성공');
			//window.location.href = '${pageContext.request.contextPath}/dpart/insertDpartForm'; 
			window.location.href = '/dpart/insertDpartForm';		
			} 
			
			if( !data.is_success ) {	    		
			alert('회사 삭제 실패');
			//return;
			}

		},
		error: function (err){	
		}
	});
}
