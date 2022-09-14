<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>  <!-- 헤더(HEADER) -->
<script type="text/javascript">

// 대화방 검색
function findChat() {
	var num = $('#user_num').val();
	var nm = $('#chat_room_nm').val();
	
	var oParam = 
	{
	    "snd_id":"ghs.co.kr",
	    "snd_device":"pc-1111",
	    "snd_ymdt":"{{currentTime}}",
	    "snd_type":"request",
	    "command":"room_search",
	    "contents":{
	            "user_num"		: num,
	            "chat_room_nm"	: nm
	    }
	}
	
	$.ajax({
		url : 'http://211.119.132.242:3000/ptt/room',
	    type: 'POST',
	    dataType: 'JSON', //서버로부터 내가 받는 데이터의 타입
	    data :  JSON.stringify(oParam),
	    contentType : "application/json;charset=UTF-8",//내가 서버로 보내는 데이터의 타입
	    success: function(data){
	    	
			if( data.is_success ) {	
	    		alert('대화방 검색 성공');
		    	window.location.href = '${pageContext.request.contextPath}/server/listMqtt.do'; 		
	    	} 
			
	    	if( ! data.is_success ) {	    		
	    		alert('대화방 검색 실패');
	    		//return;
	    	}
	    },
	    error: function (){
	    	//debugger;
	    }
	});
}


// 선택시 색상 변경
function clickRow(target){
	var tbody = target.parentNode;
	var trs = tbody.getElementsByTagName('tr');
	
	var backColor = "#ffffff";
    var textColor = "black";
    var orgBColor = "6e6e6e";
    var orgTColor = "#ffffff";
    
    for ( var i = 0; i < trs.length; i++ ) {
        if ( trs[i] != target ) {
            trs[i].style.backgroundColor = backColor;
            trs[i].style.color = textColor;
        } else {
            trs[i].style.backgroundColor = orgBColor;
            trs[i].style.color = orgTColor;
            var td = trs[i].getElementsByTagName('td');
            no = td[0].innerText;
            no1 = td[1].innerText;
        }
    }

	
}



// 버튼 클릭 시, 대화 방 접속
function showChatRoom() {
	var chatRoom_output = [];
	
	
	
	chatRoom_output.push('');
	chatRoom_output.push('');
	
	chatRoom_output.push('<button type="button" onclick="chatRoomSetup();" >설정</button>');
	chatRoom_output.push('<button type="button" onclick="getFindUser();" >친구</button>');
	
	/* chatRoom_output.push('<a href="${path}/user/listUser.do">ddd</a>'); */
	/* chatRoom_output.push('<div class=".chatcontent"></div>'); */
	
	
	chatRoom_output.push('<h5>대화방명 : 쿠키 만들기</h5>');
	
	
	$("#chat_room").html(chatRoom_output.join(''));
 }
 
 
 // 대화 방에서 사용자 추가
 function getFindUser() {
	 var findUser_output = [];
	
	 
	 
	 findUser_output.push('<h3>대화 참여자 정보</h3><hr>');
	 findUser_output.push('<button type="button" onclick="getFindUser();" >추가</button>');
	 findUser_output.push('<button type="button" onclick="getFindUser();" >퇴장</button> <hr>');
	 findUser_output.push('<table>');
	 findUser_output.push('<thead> <tr> <td>NO</td> <td>ID</td> <td>NAME</td> <td>추방</td> </tr> </thead>');
	 findUser_output.push('<tbody> <tr> <td>01</td> <td>HAN</td> <td>HAN</td> <td><button type="button" id="btnDelete">Del</button></td>  </tr> </tbody>');
	 findUser_output.push('<tbody> <tr> <td>01</td> <td>KIM</td> <td>KIM</td> <td><button type="button" id="btnDelete">Del</button></td> </tr> </tbody>');
	 findUser_output.push('<tbody> <tr> <td>01</td> <td>ICE</td> <td>ICE</td> <td><button type="button" id="btnDelete">Del</button></td> </tr> </tbody>');
	 findUser_output.push('');
	 findUser_output.push('');
	 findUser_output.push('');
	 findUser_output.push('');
	 findUser_output.push('</table>');
	 
	 $("#chat_user").html(findUser_output.join(''));
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
	<div class="container-fluid">
		<!-- Page Heading -->
		<h1 class="h3 mb-4 text-gray-800"> 대화방 목록</h1>
        
		<div class="card-group shadow">
			<div class="card">
				<form name="search">
					<div class="row">
						<div class="col-sm-3"></div>
						<div class="col-sm-2">
							<select name="searchType" class="form-control">
								<option value="user_nm"> 이름 </option>
							</select>
						</div>
	
						<div class="col-sm-4">
							<div class="input-group">
								<input type="text" class="form-control small" name="keyword" placeholder="검색어"/>
								<div class="input-group-append">
									<!-- <input type="submit"  value="검색하기" data-role="button"/> -->
									<button type="submit" class="btn btn-primary btn-sm"> <i class="fas fa-search fa-sm" ></i> 검색</button>
								</div>
							</div>
						</div>
						
						<div class="col-sm-3"></div>
					</div> 
				</form>
					
					
				<table class="table manage-candidates-top mb-0" style="width:100%; float: none; margin: auto;">
					<thead  class="text-center">
						 <tr><th>NO.</th> <th>INFOMATION</th> <th>STATUS</th> <th>ACTION</th></tr>
					</thead>
					<tbody>
						<c:forEach var="row" items="${map.CLIST}" >
						<tr class="candidates-list" onclick="javascript:clickRow(this);">
							<td> ${row.chat_room_num}</td>
							<td class="title">
								<div class="candidate-list-details">
									<div class="candidate-list-info">
										<div class="candidate-list-title">
											<h5 class="mb-0"><a href="#" onclick="showChatRoom();">${row.chat_room_nm}</a>
											<%-- <a href="${path}/chat/viewChat?chat_room_num=${row.chat_room_num}">${row.chat_room_nm}</a> --%></h5>
										</div>
										
										<div class="candidate-list-option">
											<ul class="list-unstyled">
												<li><i class="fas fa-filter pr-1"></i>접속번호 : ${row.chat_room_conn_num}</li>
												<li><i class="fas fa-map-marker-alt pr-1"></i>유형 : ${row.chat_room_typ}</li>
											</ul>
										</div>
									</div>
								</div>
							</td>
							<td class="candidate-list-favourite-time text-center">
								<a class="candidate-list-favourite order-2 text-danger" href="#"><i class="fas fa-heart"></i></a>
								<span class="candidate-list-time order-1"> ${row.editor} | ${row.crt_ymdt} | ${row.mdfy_ymdt}</span>	
							</td>
							<td>
								<ul class="list-unstyled mb-0 d-flex justify-content-end">
								<li><a href="${path}/chat/viewChat?chat_room_num=${row.chat_room_num}" class="text-primary" data-toggle="tooltip" title="" data-original-title="view"><i class="far fa-eye"></i></a>&nbsp;</li>
								<li><a href="#" class="text-danger" data-toggle="tooltip" title="" data-original-title="Delete"><i class="far fa-trash-alt"></i></a></li>
								</ul>
							</td>
						</tr>
						</c:forEach>
					</tbody>
					
				</table>
				
			</div>
		
			
			<div class="card bg-muted" id="chat_room">
				<h5 class="m-0 font-weight-bold text-primary">대화내용을 불러올 수 없습니다</h5>
				${MSG.chat_room_num}
			</div>
					
			<div class="card bg-muted" id="chat_user">
				<h5 class="m-0 font-weight-bold text-primary">사용자 정보를 불러올 수 없습니다</h5>
				<div ></div>
			</div>
			
		</div>
    </div>



	
</div>
<!-- End of Main Content -->


<%@ include file="../include/footer.jsp"%>  <!-- 하단(FOOTER) -->
	
</div>
<!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

    <div class="container p-0">
		<h1 class="h3 mb-3">Messages</h1>
		<div class="card">
			<div class="row g-0">
				<div class="col-12 col-lg-7 col-xl-9">
					<div class="py-2 px-4 border-bottom d-none d-lg-block">
						<div class="d-flex align-items-center py-1">
							<div class="position-relative">
								<h5>NO</h5>
							</div>
							<div class="flex-grow-1 pl-3">
								<strong>대화제목</strong>
								<div class="text-muted small"><em>대화참여자</em></div>
							</div>
							<div>
								<button class="btn btn-info btn-lg mr-1 px-3 d-none d-md-inline-block"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-video feather-lg"><polygon points="23 7 16 12 23 17 23 7"></polygon><rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect></svg></button>
								<button class="btn btn-light border btn-lg px-3"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-more-horizontal feather-lg"><circle cx="12" cy="12" r="1"></circle><circle cx="19" cy="12" r="1"></circle><circle cx="5" cy="12" r="1"></circle></svg></button>
							</div>
						</div>
					</div>

					<div class="position-relative">
						<div class="chat-messages p-4">
							<div class="chat-message-left pb-4">
								<div>
									<div class="text-muted small text-nowrap mt-2">2:34 am</div>
								</div>
								<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">
									<div class="font-weight-bold mb-1">ID : HAN</div>
									퇴근은 몇시일까요?
								</div>
							</div>
						</div>
					</div>

					<div class="flex-grow-0 py-3 px-4 border-top">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="Type your message">
							<button class="btn btn-primary">전송</button>
						</div>
					</div>
				</div>
				<div class="col-12 col-lg-5 col-xl-3 border-right">
					<!-- <hr class="d-block d-lg-none mt-1 mb-0"> -->
					<div class="px-4 d-none d-md-block">
						<div class="d-flex align-items-center">
							<div class="flex-grow-1">
								<input type="text" class="form-control my-3" placeholder="Search...">
							</div>
						</div>
					</div>

					<a href="#" class="list-group-item list-group-item-action border-0">
						<div class="badge bg-success float-right">별명</div>
						<div class="d-flex align-items-start">
							<h6>NO</h6>
							<div class="flex-grow-1 ml-3"> ID </div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>


</body>


</html>