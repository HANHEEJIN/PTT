<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./include/header.jsp"%>  <!-- 헤더(HEADER) -->
<%@ include file="./include/top.jsp"%> <!-- 상단(HEADER) -->

<script src="${path}/resources/js/posInfo.js"></script>
<script src="${path}/resources/js/mqtt.js"></script>

 <!-- Page Wrapper -->
<div id="wrapper">
	<%-- <%@ include file="./include/nav.jsp"%> --%> <!-- 메뉴(NAV) -->
	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
		<!-- Main Content -->
		<div id="content">
			<!-- Begin Page Content -->
			<div class="container-fluid"> <br>
				<!-- Page Heading -->
				<h1 class="h3 mb-1 text-gray-800">대쉬보드</h1>
				<p class="mb-4">지도 MQTT 대화방 참여자 <a href="https://getbootstrap.com/docs">대화방정보</a></p>
				
				<!-- Content Row -->
				<div class="row">		
					
					
					<!-- Second Column -->
					<div class="col-lg-3">
						<!-- Background Gradient Utilities -->
						<div class="card shadow mb-4">
							<div class="card-header py-3"><h6 class="m-0 font-weight-bold text-primary">대화방</h6></div>

							<div class="card-body">							
								<!--  Begin 대화방 목록 -->
								<div class="wrap">
								<table class="table  text-center display" id="listTable" width="100%" cellspacing="0">
									<!-- <thead  class="text-center">
										 <tr class="table-active"><th>방번호</th> <th>접속번호</th> <th>대화방</th> <th>타입</th> <th>작성자</th> <th>생성일시</th> <th>수정일시</th> </tr>
									</thead> -->
									
									<!-- <tbody id="tbody">
									</tbody>  -->
								</table>
								</div> <br>
								<!-- End 대화 방 목록 -->
								<!-- 페이징(paging) -->
							</div>
						</div>
					</div>
					
					<!-- Third Column -->
					<div class="col-lg-3">
						<!-- Grayscale Utilities -->
						<div class="card shadow mb-4">
							<div class="card-header py-3"><h6 class="m-0 font-weight-bold text-primary">참여자</h6></div>
							<div class="card-body"><h4 class="mb-3 text-primary">참여자</h4> </div>
						</div>
					</div>
					
					<!-- First Column -->
					<div class="col-lg-6">		
						<!-- Custom Text Color Utilities -->
						<div class="card shadow mb-4">
							<div class="card-header py-3"> <h6 class="m-0 font-weight-bold text-primary">지도</h6></div>
							<div class="card-body"><div id="map_div"> <br></div> <div id="makerClick"></div></div>
						</div>
					
						<!-- Custom Font Size Utilities -->
						<div class="card shadow mb-4">
							<div class="card-header py-3"><h6 class="m-0 font-weight-bold text-primary">MQTT</h6></div>
							<div class="card-body">
								
								<div class="row">
									<div class="col-8"> <h4 class="mb-3 text-primary">MQTT 연결</h4>
										<!-- Begin MQTT 추가 -->
										<div class="row gutters">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">Broker Connected</h6></div>
											<div class="col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
												<div class="form-group">
													<label for="name">HOST</label>
													<input type="text" id="conUrl" name="conUrl" size="15" value="211.119.132.242" class="form-control" readonly></input>
												</div>
											</div>
											<div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="code">PORT</label>
													<input type="text" id="conPort" name="conPort" size="5" value="9001" class="form-control" readonly></input>
												</div>
											</div>
											<div class="col-xl-2 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="editor">BUTTON</label>
													<div class="input-group-append">
														<button type="button" id="btnMqttCon" class="btn btn-outline-secondary btn-sm">연결</button>
														<button type="button" id="btnMqttDis" class="btn btn-outline-secondary btn-sm">종료</button>
													</div>
												</div>
											</div>
											<div class="col-xl-4 col-lg-12 col-md-12 col-sm-12 col-12">
												<div class="form-group">
													<label for="name">NAME</label>
													<input type="text" id="conNm" name="conNm" size="10" placeholder="NAME" class="form-control" value='han'></input>
												</div>
											</div>
											<div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="code">PW</label>
													<input type="text" id="conPw" id="conPw" size="10" placeholder="PW" class="form-control" value='1234'></input>
												</div>
											</div>
											<div class="col-xl-4 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="editor">Client_ID</label>
													<div class="input-group-append">
														<input type="text" id="conClient" name="conClient" size="10" placeholder="CLIENT_ID" class="form-control" value='1211'></input>	
													</div>
												</div>
											</div>
										</div>
										<div class="row gutters">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">Subscribe</h6></div>
											<div class="col-xl-10 col-lg-12 col-md-12 col-sm-12 col-12">
												<div class="form-group">
													<label for="name">TOPIC</label>
													<input type="text" id="subTopic" name="subTopic" size="50" placeholder="토픽 입력"  class="form-control" value='coord/S/#'></input>
												</div>
											</div>
											<div class="col-xl-2 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="code">BUTTON</label>
													<div class="input-group-append">
														<button type="button" id="btnSub" class="btn btn-outline-secondary btn-sm">전송</button>
														<button type="reset" class="btn btn-outline-secondary btn-sm">취소</button>
													</div>										
												</div>
											</div>
										</div>
										
										<!-- Begin MQTT 추가 -->
										<div class="row gutters">
											<div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12"> <h6 class="mb-3 text-primary">Publish</h6></div>
											<div class="col-xl-10 col-lg-12 col-md-12 col-sm-12 col-12">
												<div class="form-group">
													<label for="name">TOPIC</label>
													<input type="text" id="pubTopic" name="pubTopic" size="50" placeholder="토픽 입력"  class="form-control" value='coord/S/7' required></input>
												</div>
											</div>
											<div class="col-xl-2 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="editor">BUTTON</label>
													<div class="input-group-append">
														<button type="button" id="btnPub" class="btn btn-outline-secondary btn-sm">전송</button>
														<button type="reset" class="btn btn-outline-secondary btn-sm">취소</button>			
													</div>
												</div>
											</div>
											<div class="col-xl-12 col-lg-6 col-md-6 col-sm-6 col-12">
												<div class="form-group">
													<label for="editor">MESSAGE</label>
													<input type="text" id="pubMsg" name="pubMsg" size="50" placeholder="메세지 입력" class="form-control" value='1|중구|37.5579452|126.9941904' required></input>
												</div>
											</div>
										</div>
										<!-- END MQTT 추가 -->
										
									</div>
									<div class="col-4"><h3 class="mb-3 text-primary">TOPIC 목록</h3>
										<!-- javascript:getTopic(0; -> a href 에서 사용하는 문법 -->

										
										<select name="topic_nm" id="topic_nm" class="custom-select" onClick="getTopic();">
										<option value="noti">공지</option>
										<option value="chat">대화</option>
										<option value="load">LOAD</option>
										</select>
										<div id="getTopic"></div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div> <!-- End Row -->
			</div><!-- End container-fluid -->
		</div> <!-- End of Main Content -->
		<%@ include file="./include/footer.jsp"%>  <!-- 하단(FOOTER) -->
	</div> <!-- End of Content Wrapper -->
	
</div> <!-- End of Page Wrapper -->
</body>

<script type="text/javascript">
$(document).ready(function() { 
	userTypeCheck(); 
});

function userTypeCheck(){
	let data = '<c:out value="${sessionId.user_lvl}"/>' // 'a'
	let data2 = ${sessionId.user_lvl};					// a
	
	console.log(data);
	console.log(data2);
	
	let lvl = '<c:out value="${sessionId.user_lvl}"/>';
	

	if(lvl != 'u' || lvl != 'u') {
		console.log('u');
		//alert("접근불가");
	} else{
		console.log('u');
	}
}





$(document).ready(function() { 
	listChat(); // 채팅 목록, /resoures/ptt/chat.js
	getTopic(); // topic 정보
	initTmap(); // 지도
	
	$('#btnInsert').click(function() { confirm('등록하시겠습니까?') ? addChat() : false; }); // 장비 수정 버튼
	//$('#btnUpdate').click(function() { confirm('수정하시겠습니까?') ? modChat() : false; }); // 장비 수정 버튼
	//$('#btnDelete').click(function() { confirm('삭제하시겠습니까?') ? delChat() : false; }); // 장비 삭제 버튼
	
});

function getTopic(){
	topic_num = 1;
	
	let topic_nm = $("#topic_nm").val();	
	console.log(topic_nm);
 
	const URL = '/topic/getTopic/' + topic_nm + '/num/' + topic_num + '.json';	
	let i_output = [];
	$.getJSON(URL, function(data){
		
		i_output.push('<select name="topic_num" id="topic_num" class="custom-select" onclick="javascript:changeTopic()">');
		
		// TOPIC 목록화 하기
		$.each(data, function(i, item) {
			topic_id= item.topic_id;
			i_output.push('<option  value="' + topic_id + '">' + topic_id + '</option>');
		});
		
		i_output.push('</select>');
		
		$('#getTopic').html(i_output.join(''));
		
	}).fail(function(xhr, status, err) {
		if(error){
			error();
		}
	});
}

function changeTopic() {
	//console.log('topic_id' + topic_id);
	//document.getElementById("i").value = topic_id;
	
	let topic = $('#topic_num').val();
	$('input[name=pubTopic]').attr('value', topic);
	
	//let str = '';
	let str1 = topic.split('/', 1);
	let str2 = topic.split('/', 2);
	let str3 = topic.split('/', 3);
	let sub = str1 + '/' + str2 + '/#';
	console.log(str1);
	
	let pub = str1 + '/' + str2 + '/' + str3;
	console.log(pub);
	
	console.log('c top' + topic);
	// topic 변경
	$('input[name=subTopic]').attr('value', topic);
	

	// 
	
}

let map; // map 변수
let m_list = {}; // 마커 배열 변수
let markerList = [];


function initTmap(){
	// Tmap.map을 이용하여, div, 넓이, 높이를 설정
	map = new Tmapv2.Map("map_div", {
		center : new Tmapv2.LatLng(37.566481622437934, 126.98502302169841), // 지도 초기 좌표
		width  : "99%", 	// map의 width 설정
		height : "550px",	// map의 height 설정	
		zoom   : 6			//0~19
	});
	
	//var markerList = [];
	
	// 지도 좌표 돌리기
	for (let i = 0; i< posUserInfo.length; i++){//for문을 통하여 배열 안에 있는 값을 마커 생성
		lon = posUserInfo[i].lon; 	//
		lat = posUserInfo[i].lat;	//
		area = posUserInfo[i].area;	// 지역명
		
		
		coords = new Tmapv2.LatLng(lon, lat);

		//Marker 객체 생성.
		marker = new Tmapv2.Marker({
			position : coords, //Marker의 중심좌표 설정.
			map : map, //Marker가 표시될 Map 설정.
			title : area //Marker 타이틀.
		});
		
		addDrowMarker(coords, area);
	}
	/* map.setZoom(15); */
	/* 
	markerList.push(marker);
	
	// 마커클러스터 등록
	markerCluster = new Tmapv2.extension.MarkerCluster({
		markers: markerList, // 마커들이 담긴 배열
		map: map // 지도 객체
	});
	
	 */
	map.setCenter(new Tmapv2.LatLng(37.56520450, 126.98702028));
}

//이전 마커 지우고 새로 마커 그리기
function drawMarkerToMap(text)
{
	let marker_info = text.split('|');
	
	let label = "<span style='background-color: #46414E;color:white'>" + marker_info[1] + "</span>";
	
	if(m_list[marker_info[0]])
	{
		m_list[marker_info[0]].setMap(null);
	}	 
	 
	marker = new Tmapv2.Marker({
		position 		: new Tmapv2.LatLng(marker_info[2], marker_info[3]), //Marker의 중심좌표 설정.
		icon	 		: 'http://tmapapi.sktelecom.com/resources/images/common/pin_car.png',
		animation		: Tmapv2.MarkerOptions.ANIMATE_FADEIN, 	//Marker 애니메이션
		animationLength : 100, 				//애니메이션 길이
		label	 		: label, 	//Marker라벨(마커하단에표시될이름)
		map 	 		: map, 				//Marker가 표시될 Map
		title 	 		: marker_info[0] 	//Marker타이틀(마커풍선표시)
	});

	m_list[marker_info[0]] = marker;
}

function addDrowMarker(coords, area) {
	//console.log(area);	
	//infoWindow.setMap();
	
	marker.addListener("click", function(evt) {
		console.log('click');
		let content=
				"<div class='m-pop' style='position: static; top: 180px; left : 320px; display: flex; font-size: 14px; box-shadow: 5px 5px 5px #00000040; border-radius: 10px; width : 200px; height:100px; background-color: #FFFFFF; align-items: center; padding: 5px;'>" +
				"<div class='info-box' style='margin-left: 10px;'>"+
				"<p style='margin-bottom: 7px;'>"+
				"<p>"+
				"<span class='tit' style=' font-size: 16px; font-weight: bold;'>" + area + "</span>"+
				"</div>"+
				"</div>";
        
		  //Popup 객체 생성.
			infoWindow = new Tmapv2.InfoWindow({
			position: coords, //Popup 이 표출될 맵 좌표
			content: content, //Popup 표시될 text
			border :'0px solid #FF0000',
			type : 2,
			map: map //Popup이 표시될 맵 객체
			});
		    
		//document.getElementById("makerClick").innerHTML = content;
	});
	
}






</script>
</html>