let map; // map 변수
let m_list = {}; // 마커 배열 변수
let markerList = [];


function initTmap(lat, lon){
	// Tmap.map을 이용하여, div, 넓이, 높이를 설정
	map = new Tmapv2.Map("map_div", {
		center : new Tmapv2.LatLng(37.566481622437934, 126.98502302169841), // 지도 초기 좌표
		width  : "500px", 	// map의 width 설정
		height : "500px",	// map의 height 설정	
		zoom   : 7			//0~19
	});
	
	
	/*coords = new Tmapv2.LatLng(lat , lon);
	
	//Marker 객체 생성.
	marker = new Tmapv2.Marker({
		position : coords, //Marker의 중심좌표 설정.
		map : map, //Marker가 표시될 Map 설정.
	});
	addDrowMarker(coords);
	*/
	//map.setCenter(coords);
	/*

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
	*/
	//map.setCenter(new Tmapv2.LatLng(37.56520450, 126.98702028));
}

//이전 마커 지우고 새로 마커 그리기
function removeMarkers() {
	for (let i = 0; i < markerList.length; i++) {
		markerList[i].setMap(null);
	}
	markerList = [];
}

// 마커 그리기 
function addDrowMarker(coords) {
	//console.log(area);	
	//infoWindow.setMap();
	
	marker.addListener("click", function(evt) {
		//console.log('click');
		/*let content=
				"<div class='m-pop' style='position: static; top: 180px; left : 320px; display: flex; font-size: 14px; box-shadow: 5px 5px 5px #00000040; border-radius: 10px; width : 200px; height:100px; background-color: #FFFFFF; align-items: center; padding: 5px;'>" +
				"<div class='info-box' style='margin-left: 10px;'>"+
				"<p style='margin-bottom: 7px;'>"+
				"<p>"+
				"<span class='tit' style=' font-size: 16px; font-weight: bold;'>" + area + "</span>"+
				"</div>"+
				"</div>";*/
        
		  //Popup 객체 생성.
			infoWindow = new Tmapv2.InfoWindow({
			position: coords, //Popup 이 표출될 맵 좌표
			//content: content, //Popup 표시될 text
			
			border :'0px solid #FF0000',
			type : 2,
			map: map //Popup이 표시될 맵 객체
			});
		    
		//document.getElementById("makerClick").innerHTML = content;
	});
	markerList.push(marker);
}