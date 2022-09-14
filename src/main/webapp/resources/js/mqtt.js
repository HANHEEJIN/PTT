// MQTT client

let mqttClient= null;

let subTopic = '';
let pubTopic = '';
let msg = '';

//MQTT connect info null
let host = ''; 		//211.119.132.88
let port = '';  		 //9001
let userNm = ''; 		 //admin
let userPw = ''; 		 //admin

//랜덤 클라이언트 ID 
//let clientId = 'clientID-' + parseInt(Math.random() * 100);        
let clientId = '';

//MQTT 함수
$(document).ready(function(){
	// Broker 연결
	$('#btnMqttCon').on("click", function() {
		
		host = document.getElementById('conUrl').value;
		port = document.getElementById('conPort').value;
		userNm = document.getElementById('conNm').value;
		userPw = document.getElementById('conPw').value;
		clientId = document.getElementById('conClient').value;
		
		fncStartMqtt(); 
	});
	
	// Broker 연결 종료
	$('#btnMqttDis').on("click", function() { disConnect(); });
	
	// sub topic 클릭, 구독을 먼저 해야 메시지 받기 가능
	$('#btnSub').on("click", function() {
		subTopic = document.getElementById('subTopic').value;
		mqttClient.subscribe(subTopic);
		console.log('[ TOPIC ] ' + subTopic);
		
		setTimeout(function() {
			job_loop(mqttClient);
		}, 3000);
	
		subCallback(subTopic);
	});
	
	
	// pub topic 클릭
	$('#btnPub').on("click", function() {
		//pubTopic = document.getElementById('pubTopic').value;
		msg = document.getElementById('pubMsg').value;
		//console.log(msg);
		// === 사용 : value와 data type까지 비교
		if(msg === '' || msg === undefined  || msg === null) {
			alert('MESSAGE 입력');
		} else {
			fncMqttDoSend(msg);
		}  
	});

});

// MQTT 클라이언트 연결
function fncStartMqtt() 
{
	// MQTT 객체 생성
    mqttClient = new Paho.MQTT.Client(host, Number(port), clientId);
  
    // OPTION( TIME, SUS, FAIL(FUNCTION), BROKER_ID, BROKER_PW)
    // BROKER_ID, BROKER_PW : 사용자 인증 권한시 필요
    let options = {
		timeout: 3,
		onSuccess: onConnect,
		onFailure : function(err)
		{
			console.log(err.errorCode);
			console.log(err.errorMessage);
        	
			if (err.errorCode == 0x4) {
            	console.log(err);
            	console.log(err.errorCode);
          	}
        },
		userName : userNm,
		password : userPw
	};
	
    mqttClient.onConnectionLost = onConnectionLost;		// 연결 손실
    mqttClient.onMessageArrived = onMessageArrived;		// 구독한 채널에 메세지 도착 처리
    mqttClient.connect(options);  // MQTT CONNECT 연결
}

// 연결 성공 시 실행되는 function
function onConnect() 
{
    console.log('***** ***** WEBSOCKET  ***** *****');
    console.log('[   URL ] ' + host);
    console.log('[  PORT ] ' + port);
    console.log('[  NAME ] ' + userNm);
    console.log('[    PW ] ' + userPw);
    console.log('[    ID ] ' + clientId);
	$('#btnSub').click();
}

function job_loop()
{
	for (let i = 0; i< positions.length; i++){
		setTimeout(function() {
			msg = '1|빠방이|' + positions[i]['lon']+'|'+positions[i]['lat'];
			//console.log(msg);
			
			
			if(positions[i]['type'] === 'S') {
				topic = 'coord/S';
			} else if(positions[i]['type'] === 'I'){
				topic = 'coord/I';
			} else if(positions[i]['type'] === 'K'){
				topic = 'coord/K';
			} else {
				
			}
			console.log('[   PUB ] ' + topic);
			
			fncMqttDoSend(msg, topic);
		}, 300*i);
	} 
}

// 연결 실패 시 실행되는 function
function onFailure() { console.log("연결 실패"); }

 // 연결 손실
function onConnectionLost(responseObject) 
{
    if (responseObject.errorCode !== 0) 
    {
        console.log("onConnectionLost : " + responseObject.errorMessage); 
        onConnect(); // 연결 재시도
    }
}

// 메시지 받는 부분, 구독한 채널에 메세지 도착 처리
function onMessageArrived(message) 
{
	//console.log('메세지도착');
	drawMarkerToMap(message.payloadString);			// 일반데이터 마커 표시
	//drawLocationMarkerToMap(message.payloadString);	// 경로데이터 마커 표시
	
    console.log("[   MSG ] " + message.payloadString);
    // mqtt 받은 메시지를 각 화면에 그려주기
    //fncMqttAction(message.payloadString);
}

// 연결 종료
function disConnect(){
	mqttClient.disconnect();
	console.log('연결 종료');
	//document.getElementById("messages").innerHTML += '<span>Disconnected</span><br/>';
}

// mqtt 받은 메시지를 각 화면에 그려주기
function fncMqttDoSend(sendMsg, pubTopic) 
{
	
    mqttClient.send(pubTopic, sendMsg);

}

//
function subCallback(subTopic) {
	$('#chatRoom').append(subTopic + '<br>')
}

// 메세지 동적 그리기
/*function fncMqttAction(mqttMsg){
	//document.write(mqttMsg);
	$('#msg').append(clientId + ' 님 : ' + mqttMsg + '<br>')
}*/