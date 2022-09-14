// 전체 부서 목록 띄우기
function listDpart(){	
	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":sendTime(),
		"snd_type":"request",
		"command":"dpart_all_list_v2",
		"contents":{
		}
	};
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/dpart",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			treeDpartpCallback(data);    	
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

function treeDpartpCallback(data){	
	// 객체 배열 접근
	// 1) 점 표기법 : _list[1].dpart_num
	// 2) 대괄호 표기법(문자열 접근) : _list[1]['dpart_num']
	// 3) 대괗호 표기법(변수 접근) : _list[1][dpart_num]
	

	/*
	foreach : undefined를 반환 , berak, continue, return 사용해서 함수 벗어나기 불가능
	foreach : 배열의 각 요소에 callback을 실행
	for :  break 문 만나면 반복 중단
	map : 배열의 각 요소에 대해 callback을 실행하고 실행결과를 모은 새 배열을 리턴
	*/

	const _list = data.data.contents.list;	// 데이터 json 
	let tree = []; 							// tree 메뉴 배열 생성
	let parents_part_set = new Set(); 		// set 객체 선언, 중복제거한 값들의 집합
	let dp_array = [];						// 데이터 전체부서 추가
	
	// 상위 부서 중복값 제거 
	_list.forEach(item => { 
		//console.log('item ... '+ item );		// 전체 부서
		parents_part_set.add(item['dpart_nm']); // set객체에 상위 부서 추가
		//console.log('Parents ... ' + JSON.stringify(parents_part_set));	// 상위부서 출력
		dp_array.push({'idx': item['dpart_index'], 'u_name' : item['dpart_nm'], 'd_name' : item['dpart_num'], 'co_num' : item['co_num']}); // 새로 배열 만듬
	});
	
	// 상위 부서 받아서 상위 항목 데이터 출력, 트리메뉴 구조 그리기
	// state : expanded(기본값_true 펼친상태)
	parents_part_set.forEach(part => { tree.push({text: part, state : {expanded : false}, nodes:[ ]}); });

	tree.forEach(tree => {
		// console.log('tree ... ' + JSON.stringify(tree)); // 상위 항목 출력
		// 새로 생성한 부서 배열
		dp_array.forEach(team =>{
			// console.log('tree.text ... ' + tree.text);	// tree 배열 각 상위 항목당 하위 배열 돌리기 ex) 상위 3, 하위 5 => 상위 1에 하위 5번 돌기 
			let index = team.idx;		// 인덱스
			let u_name = team.u_name;	// 상위부서
			let d_name = team.d_name;	// 하위부서		
			let co_num = team.co_num;	// 회사코드
			
			// 상위 부서 이름이 같으면
			if(tree.text == u_name) {
				// tree.nodes.push({text : team.d_name});
				// console.log('d_name ' + team.d_name); // 하위 항목 출력
				let a = "<a href='#' style='text-decoration:none; color:black;' onclick='getDpart(" + index + ");'>" + d_name + "</a>";
				tree.nodes.push({text : a, state : {expanded : false}});
			}
		})
	})
	// treeView 검색
	let $searchableTree = $('#treeview1').treeview({
		data: tree,
		collapseIcon:'fas fa-minus',
		expandIcon:'fas fa-plus',
		color: "#000000",					// 상위 기본 글씨 색
		selectedColor	: '#000000',
		selectedBackColor :'#EAECF4',		// 선택 색상값
		searchResultColor : '#000000',  	// 검색 결과 글씨 색
		searchResultBackColor : '#EAECF4',	// 검색 결과 배경 색
		onhoverColor : '#EAECF4'			// 마우스 커서 배경 색
	});

	let search = function(e) {
		let pattern = $('#input-search').val();
		let options = {
			ignoreCase	  : true,	// 대소문자 true(무시) false(정확)
			exactMatch	  : false,	// 정확성  true(), false()
			revealResults : true	// 결과값  true(포커스O), false(포커스X) 
		};
		$searchableTree.treeview('search', [ pattern, options ]); // input, 옵션
	}
	
	$('#btn-search').on('click', search);	// 검색 버튼
	$('#input-search').on('keyup', search); // 검색 키보드

	// 검색 취소 버튼 클릭시
	$('#btn-clear-search').on('click', function (e) {
		$searchableTree.treeview('clearSearch');
		$searchableTree.treeview('collapseAll', { silent: true }); // 검색 취소시 메뉴 펼치기 축소
		$('#input-search').val('');
	});

	// 검색 취소 버트 클릭시
	$('#btn-clear-search').on('click', function (e) {
		$searchableTree.treeview('clearSearch');	//
		$searchableTree.treeview('collapseAll', { silent: true }); // 검색 취소시 메뉴 펼치기 축소
		$('#input-search').val('');	// input값 비우기

		/*$('#treeview1').treeview('addNode', [ nodes, parentNode, index, { silent: true } ]);*/
	});
}
	

// ********** ********** ********** 상위 부서 ********** ********** **********
function listUpDpart(num, co_num) {
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"dpart_uppr_list_v2",
	    "contents":{ "co_num" : co_num }
	};
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dpart',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){	    	

	    	// 게시글 목록 데이터 값 확인, userDpartCallback 사용자 등록 화면 상위 부서 select box
			// (1)부서등록_회사리트스클릭, (2), 사용자등록_리스트 (3)사용자수정_리스트
	    	  if(data.is_success) {
				if(num == 1) {
					listDpartpCallback(data)
				} else if(num == 2) {
					userUpDpCallback(data)
				} 
				else if(num == 3) {
					userViewUpDpCallback(data)
				} else{
					alert('상위부서 목록 실패'); 	
				}
			} else {
				alert('상위부서 목록 실패'); 	
			}
			
	    },
	    error: function (){

	    }
	});
}

// ********** ********** ********** [1] 부서등록_리스트 ********** ********** **********
function listDpartpCallback(data) {
	let list_output = [];
	
	list_output.push("<tr>");
	if(!data.data.contents) {
		list_output.push("<td colspan='5' style='color:red;'>해당 회사의 부서 목록이 존재하지 않습니다.</td>");
		list_output.push("</tr>");
		$('#tbodyDown').html(list_output.join(''));
	} else if(data.data.contents.list.length == 0)  {
		list_output.push("<td colspan='5' style='color:red;'>등록된 부서가 존재하지 않습니다.</td>");
		list_output.push("</tr>");
	} else if(data.data.contents.list.length != 0) {
		for(let i in data.data.contents.list) {

			let _list = data.data.contents.list;		
			let row = _list[i];	
			let dpart_num = row.dpart_num;
			let dpart_nm = row.dpart_nm;
			let dpart_index = row.dpart_index; // 상위부서 코드
			let co_num = row.co_num;
			
			
			list_output.push("<tr class='candidates-list' onclick='javascript:clickRow(this);'>");		
			list_output.push("<td>" + dpart_num + "</td>");
			list_output.push("<td> <a href='#' onclick='javascript:listDownDpart(" + 1 + ", " + dpart_index + ",\"" + co_num + "\"); getDpart(" + dpart_index + ");'>" + dpart_nm + "</a></td>");
			list_output.push("<td>" + dpart_index + "</td>");		
			list_output.push("</tr>");
			
			let text_output = [];
			text_output.push("<td colspan='5' style='color:red;'>상위 부서를 선택해 주세요.</td>");
			text_output.push("</tr>");
			$('#tbodyDown').html(text_output.join(''));
		} 
	}
	$('#tbodyDpart').html(list_output.join(''));
}

// 상위부서 등록
function addDpart() {
	//debugger;
	
	let com = $('#up_co_num').val();
	let nm = $('#up_dpart_nm').val();
	let type = $('#up_dpart_typ').val();
	let num = $('#up_dpart_num').val();
	let editor = $("#editor").val();

	let oParam = 
	{
		    "snd_id":"ghs.co.kr",
		    "snd_device":"pc-1111",
		    "snd_ymdt":sendTime(),
		    "snd_type":"request",
		    "command":"dpart_create_v2",
		    "contents":{
		        "dpart_nm"		 : nm,
		        "dpart_typ"		 : type,
		        "uppr_dpart_num" : num,
		        "editor"		 : editor,
		        "co_num"		 : com
		    }
		}
	
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/dpart",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('상위 부서 등록 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/dpart/insertDpartForm';
				window.location.href = '/dpart/insertDpartForm';		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('상위 부서 등록 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	debugger;
	    }
	});
}

// ********** ********** ********** 하위 부서 ********** ********** **********
function listDownDpart(num, dpart_index, co_num) {
	
	console.log("down " + num)
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"dpart_sub_list_v2",
	    "contents":{
	        "parent_id" : dpart_index,
	        "co_num" 	: co_num
	    }
	};
	$.ajax({
		url : "http://211.119.132.242:2000/ptt/dpart",
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){	    	
	    	// 게시글 목록 데이터 값 확인
			// getDownDpName -> user.js

		    if(data.is_success) {
				// (1) 부서등록_리스트, (2)사용자등록_리스트, (3)사용자수정_리스트
				if(num == 1){
					listDownCallback(data);
				} else if(num == 2){
					userDownDpCallback(data);
				} else if(num == 3) {
					userViewDownDpCallback(data);
				} else {
					alert('하위부서 목록 실패'); 	
				}
			} else {
				alert('하위부서 목록 실패'); 	
			}		    	
	    },
	    error: function (){
	    }
	});
}

function listDownCallback(data) {
	let  _list = data.data.contents.list;

	let list_output = [];
	if (_list.length == 0) {
		list_output.push("<tr>");
		list_output.push("<td colspan='5' style='color:red;'>등록된 글이 존재하지 않습니다.</td>");
		list_output.push("</tr>");
		return;
	}
	
	for(let i in _list) {
		let row = _list[i];
		
		let dpart_num = row.dpart_num;
		let dpart_nm = row.dpart_nm;
		let dpart_typ = row.dpart_typ;
		let dpart_index = row.dpart_index;
		let editor = row.editor;
		
		list_output.push("<tr class='candidates-list' onclick='javascript:clickRow(this);'>");
		list_output.push("<td>" + dpart_nm+ "</td>");
		list_output.push("<td> <a href='#' onclick='javascript:getDpart(" + dpart_index + ");'>" + dpart_num + "</a></td>");
		list_output.push("<td>" + dpart_index + "</td>");
		list_output.push("</tr>");
	}
	$('#tbodyDown').html(list_output.join(''));	
}
//하위부서등록
function addDown() {
	let com = $('#down_co_num').val();
	let nm = $('#down_dpart_nm').val();
	let type = $('#down_dpart_typ').val();
	let num = $('#down_uppr_dpart_num').val();
	let editor = $("#editor").val();
	let parent = $('#parent_id').val();
   
	let oParam = 
	{
	  "snd_id": "ghs.co.kr",
	  "snd_device": "pc-1111",
	  "snd_ymdt": sendTime(),
	  "snd_type": "request",
	  "command": "dpart_create_v2",
	  "contents": {
	    "dpart_nm"		: nm,
	    "co_num"		: com,
	    "dpart_typ"		: type,
	    "uppr_dpart_num": num,
	    "editor"		: editor,
	    "parent_id"		: parent
	  }
	}
  
	$.ajax({
	  "url": "http://211.119.132.242:2000/ptt/dpart",
	  "method": "POST",
	  "timeout": 0,
	  "headers": {
	    "Content-Type": "application/json"
	  },
	  "data": JSON.stringify(oParam),
	    success: function(data){
	    	if( data.is_success ) {	
	    		if(data.data.result_code == 200) {
	    			alert('하위 부서 등록 성공');
			    	//window.location.href = '${pageContext.request.contextPath}/dpart/insertDpartForm';
					window.location.href = '/dpart/insertDpartForm'; 
	    		} else if(data.data.result_code == 400) {
	    			alert('하위 부서 등록 실패');
	    		}		
	    	}
			if( ! data.is_success ) {	    		
	    		alert('하위 부서 등록 실패');
	    		//return;
	    	} 
	    },
	    error: function (err){
	       console.log(err)
	    }
	});
}

//부서 상세 정보 json 데이터 가져오기
function getDpart(dpart_index, callback, error) {
	const URL = '/dpart/getViewDpart/' + dpart_index + '.json';
	$.get(URL, function(data){
		
		// **********  ********** 리스트항목의 상세보기 value 값 변경  **********  ********** 
		$('input[name=list_view_co_num]').attr('value', data.co_num);
		$('input[name=list_view_upDp]').attr('value', data.dpart_nm);
		$('input[name=list_view_upId]').attr('value', data.parent_id);		
		$('input[name=list_view_downDp]').attr('value', data.dpart_num);		// 부서 이름 수정 : 변경전 부서 이름, hidden
		$('input[name=lsit_view_change_nm]').attr('value', data.dpart_num);  // 부서 이름 수정 : 변경할 부서 이름
		$('input[name=list_view_downId]').attr('value', data.dpart_index);
		$('input[name=list_view_type]').attr('value', data.dpart_typ);
		$('input[name=list_view_level]').attr('value', data.uppr_dpart_num);
		$('input[name=list_view_editor]').attr('value', data.editor);
		
		
		// **********  ********** 상위 부서 추가 vlaue 값 변경 **********  ********** 
		// 클릭시, 상위부서 상세정보 조회 value 값 변경
		$('input[name=view_ch_up_name]').attr('value', data.dpart_nm);
		$('input[name=view_up_name]').attr('value', data.dpart_nm);
		$('input[name=view_up_index]').attr('value', data.dpart_index);
		
		// 클릭시, 하위부서 등록 상위부서 이름 및 번호 value 값 변경
		$('input[name=parent_id]').attr('value', data.dpart_index);
		
		// **********  ********** 하위 부서 추가 vlaue 값 변경 **********  ********** 
		// 클릭시, 상위부서 상세정보 조회 value 값 변경
		$('input[name=view_down_name]').attr('value', data.dpart_num);
		$('input[name=view_ch_down_name]').attr('value', data.dpart_num);
		$('input[name=view_downId]').attr('value', data.dpart_index);
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

//부서 수정
function modDpart(num){
	let co_num = $('#view_co_num').val();	
	let dpart_nm = '';
	let change_nm = '';

	 // 1 : 상위부서, 2 :  하위 부서, 3 : 리스트 상세보기 수정
	switch(num){
	 case 1: 
		 change_nm = $('#view_ch_up_name').val();
		 dpart_nm = $('#view_up_name').val();
		 break; 
	 case 2: 
		 change_nm = $('#view_ch_down_name').val();
		 dpart_nm = $('#view_down_name').val();
		 break;
	 case 3: 
		 change_nm = $('#list_view_change_nm').val();
		 dpart_nm = $('#list_view_downDp').val();
		 break;
	 default: break; 
	};
	
	let oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":sendTime(),
	    "snd_type":"request",
	    "command":"dpart_update_v2",
	    "contents":{
	        "dpart_nm" 			: dpart_nm,
	        "co_num" 			: co_num ,
	        "change_dpart_nm" 	: change_nm
	    }
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dpart',
	    type: 'PUT',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
			if( data.is_success ) {	
	    		alert('부서 정보 수정 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/dpart/listDpart.do'; 	
				window.location.href = '/dpart/insertDpartForm';	
	    	}
	    	if( ! data.is_success ) {	    		
		    	console.log(data.contents.result_code);
		    	if(data.contents.result_code == '409'){
		    		alert(data.contents.result_msg); // 부서 이름 존재
		    		$('#view_change_nm').focus();
		    	}
	    	}
	    	

	    },
	    error: function (){
	    }
	});
}

// 부서 삭제
function delDpart(num){

	let co_num = $('#view_co_num').val();	
	let dpart_nm = '';

	 // 1 : 상위부서, 2 :  하위 부서, 3 : 리스트 상세보기 수정
	switch(num){
	 case 1: 
		 dpart_nm = $('#view_up_name').val();
		 break; 
	 case 2: 
		 dpart_nm = $('#view_down_name').val();
		 break;
	case 3: 
		 dpart_nm = $('#list_view_downDp').val();
		 break;
	 default: break; 
	}
	
	let oParam = 
	{
		"snd_id":"ghs.co.kr",
		"snd_device":"pc-1111",
		"snd_ymdt":sendTime(),
		"snd_type":"request",
		"command":"dpart_delete_v2",
		"contents":{
		    "dpart_nm" 	: dpart_nm,
		    "co_num" 	: co_num 
		},
		"주의" : "상위 부서를 삭제하면 [하위 부서]도 삭제 됩니다. - 해당 데이터는 포함되지 않습니다."
	};
	
	$.ajax({
		url : 'http://211.119.132.242:2000/ptt/dpart',
	    type: 'DELETE',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : 'application/json;charset=UTF-8',//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	if( data.is_success ) {	
	    		alert('부서 정보 삭제 성공');
		    	//window.location.href = '${pageContext.request.contextPath}/dpart/listDpart.do'; 
				window.location.href = '/dpart/insertDpartForm';	
	    	}
			
	    	if( ! data.is_success ) {	    		
	    		alert('부서 정보 삭제 실패');
	    		return;
	    	}
	    },
	    error: function (){
	    }
	});
}


