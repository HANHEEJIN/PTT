// 문자열 치화

/*let entityMap = {
		'&': '&amp;',
		'<': '&lt;',
		'>': '&gt;',
		'"': '&quot;',
		"'": '&#39;',
		'/': '&#x2F;',
		'`': '&#x60;',
		'=': '&#x3D;'
	};*/

function escapeHtml (msg){
	
	//let escapeMsg = msg;
	// \ ' "
	msg.replace(/\\/g, "&quot;").replace(/\'/g, "&#39;").replace(/\"/g, "&quot;");
	

	return msg;
}



function displayTime(timeValue) {
	
	//console.log(timeValue);
	const year = timeValue.substring(0, 4);
	const month = timeValue.substring(4, 6);
	const day = timeValue.substring(6, 8);
	const t = timeValue.substring(8, 10);
	const m = timeValue.substring(10, 12);
	//const h = timeValue.substring(12, 14);
	
	//console.log(year + '년 ' + month + '월 ' + day + '일 ' + t + ': ' + m );
	//const disTime = year + '년 ' + month + '월 ' + day + '일 ' + t + ': ' + m;
	
	const cur = '{{currentTime}}';
	
	if(timeValue === cur){
		//console.log('sss');
		return  '';
	} else{
		
		
		return year + '년 ' + month + '월 ' + day + '일 ' + t + ': ' + m;
	} 
}

function sendTime() {
	// yyyyMMddHHmmss 형식으로 보내기
	const date = new Date();
	
	let yyyy = date.getFullYear(); //년도
	let MM = ('0' + (date.getMonth() + 1)).slice(-2);
	let dd = ('0' + date.getDate()).slice(-2);
	let HH = ('0' + date.getHours()).slice(-2);
	let mm = ('0' + date.getMinutes()).slice(-2);
	let ss = ('0' + date.getSeconds()).slice(-2); 
	
	return yyyy +  MM + dd+  HH + mm + ss;
}



// 검색
function searchCheck(page){
	let searchType = $("#searchType option:selected").val();
	if(searchType === 'all') {
		let list_output = [];
		let page_output = [];
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>검색조건을 선택해 주세요.</td>");
		list_output.push("</tr>");
		list_output.push("</tr>");
		$("#tbody").html(list_output.join('')); 
		$("#pageing").html(page_output.join('')); 
		//$("#pageing").remove();
	} else {
		listUser(page);
	}
}

function searchCheckEqp(page){
	let searchType = $("#searchType option:selected").val();
	if(searchType === 'all') {
		let list_output = [];
		let page_output = [];
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>검색조건을 선택해 주세요.</td>");
		list_output.push("</tr>");
		list_output.push("</tr>");
		$("#tbody").html(list_output.join('')); 
		$("#pageing").html(page_output.join('')); 
		//$("#pageing").remove();
	} else {
		listEqp(page);
	}
}

function searchCheckChat(page){
	let searchType = $("#searchType option:selected").val();
	if(searchType === 'all') {
		let list_output = [];
		let page_output = [];
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>검색조건을 선택해 주세요.</td>");
		list_output.push("</tr>");
		list_output.push("</tr>");
		$("#tbody").html(list_output.join('')); 
		$("#pageing").html(page_output.join('')); 
		//$("#pageing").remove();
	} else {
		listChat(page);
	}
}

function searchCheckSip(page){
	let searchType = $("#searchType option:selected").val();
	if(searchType === 'all') {
		let list_output = [];
		let page_output = [];
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>검색조건을 선택해 주세요.</td>");
		list_output.push("</tr>");
		list_output.push("</tr>");
		$("#tbody").html(list_output.join('')); 
		$("#pageing").html(page_output.join('')); 
		//$("#pageing").remove();
	} else {
		listSip(page);
	}
}

function searchCheckMqtt(page){
	let searchType = $("#searchType option:selected").val();
	if(searchType === 'all') {
		let list_output = [];
		let page_output = [];
		list_output.push("<tr>");
		list_output.push("<td colspan='10' style='color:red;'>검색조건을 선택해 주세요.</td>");
		list_output.push("</tr>");
		list_output.push("</tr>");
		$("#tbody").html(list_output.join('')); 
		$("#pageing").html(page_output.join('')); 
		//$("#pageing").remove();
	} else {
		listMqtt(page);
	}
}



// 세션 값 가져오기


// 뒤로가기 막기
function noBack() {
	console.log('back');
	
	//alert('로그아웃 하시겠습니까?');
	
	//$('#logoutModal').modal(); 
	//$('#logoutModal').modal('show');
	//window.history.forward();
	//confirm('로그아웃 하시겠습니까?') ? logOut() : window.history.forward();
}

// 입력칸 비우기
function form_reset() {
	$('form').each(function() { this.reset(); });
}

/*
function CheckSession() {
	if (sessionStorage.getItem("loginKey") == null) {
		window.location = "로그인화면주소";
	}
}

		setInterval(CheckSession(), 100);
*/

function pageing(){
	let _page = data.data.PAGE;
 	
 	let no = _page.numPage; // 총게시물 갯수

	let page_output = [];
	let next = _page.page + 1;
	let prev = _page.page - 1;

	page_output.push('<ul class="pagination justify-content-center" >');
	if (_page.page <= 1) { page_output.push('<li class="page-item disabled"><a class="page-link">이전</a></li>');}
	if (_page.page > 1) { page_output.push('<li class="page-item"><a href="javascript:listUser1(' + prev + ')"; class="page-link">이전</a></li>'); }

	for (var i = _page.startPage; i <= _page.endPage; i++) {
		if (i == _page.page) { page_output.push('<li class="page-item active"><a class="page-link">' + i.toString() + '</a></li>');
		} else { page_output.push('<li class="page-item"><a href="javascript:listUser1(' + i + ')"; class="page-link">' + i + '</a></li>');	}
	}

	if (_page.page >= _page.maxPage) { page_output.push('<li class="page-item disabled"><a class="page-link">다음</a></li>');	}
	if (_page.page < _page.maxPage) { page_output.push('<li class="page-item"><a href="javascript:listUser1(' + next + ')"; class="page-link">다음</a></li>'); }

	page_output.push('</ul>');
	
	$("#pageing").html(page_output.join(''));
	
}


//선택시 색상 변경
function clickRow(target){

	let tbody = target.parentNode;
	let trs = tbody.getElementsByTagName('tr');
	
	let backColor = "#ffffff";
	let textColor = "black";
	let orgBColor = "6e6e6e";
	let orgTColor = "#ffffff";
    
    for ( var i = 0; i < trs.length; i++ ) {
        if ( trs[i] != target ) {
            trs[i].style.backgroundColor = backColor;
            trs[i].style.color = textColor;
        } else {
            trs[i].style.backgroundColor = orgBColor;
            trs[i].style.color = orgTColor;
            let td = trs[i].getElementsByTagName('td');
            no = td[0].innerText;
            no1 = td[1].innerText;
        }
    }
}