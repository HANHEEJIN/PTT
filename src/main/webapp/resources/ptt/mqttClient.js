// MQTT client
let mqttClient= null;

let subTopic = '';
let pubTopic = '';
let msg = '';

//MQTT connect info null
let host = '211.119.132.242'; //211.119.132.88
let port = '9001';				//9001
let userNm = 'admin'; 			//admin
let userPw = '1234'; 				//admin


//랜덤 클라이언트 ID 
let clientId = 'clientID-' + parseInt(Math.random() * 100);        


//MQTT 함수
$(document).ready(function(){
	// Broker 연결
	$('#btnCon').on("click", function() { fncStartMqtt();  });

	// Broker 연결 종료
	$('#btnDis').on("click", function() { disConnect();  });
	
	// sub topic 클릭, 구독을 먼저 해야 메시지 받기 가능
	$('#btnSub').on("click", function() { mqttClient.subscribe(subTopic); });
	
	// pub topic 클릭
	$('#btnPub').on("click", function() { fncMqttDoSend(pubTopic, msg); });
});

// **********  **********  ********** 연결 관련   ********** ********** **********
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

    // MQTT CONNECT 연결
    mqttClient.connect(options);
}

// 연결(1), 실패(2), 손실(3), 종료(4), 메세지받기_성공(5), 메세지 받기_실패(6)
let mqttState = '';

// 연결 성공 시 실행되는 function
function onConnect() 
{
    console.log('***** ***** WEBSOCKET  ***** *****');
    console.log('[   URL ] ' + host);
    console.log('[  PORT ] ' + port);
    console.log('[  NAME ] ' + userNm);
    console.log('[    PW ] ' + userPw);
    console.log('[    ID ] ' + clientId);

	return mqttState = 1;
}

// 연결 실패 시 실행되는 function
function onFailure() { console.log("연결 실패"); return mqttState = 2 ;}

 // 연결 손실
function onConnectionLost(responseObject) 
{	
    if (responseObject.errorCode !== 0) 
    {
        console.log("onConnectionLost : " + responseObject.errorMessage);

        // 연결 재시도
        onConnect();
    }

	return mqttState = 3 ;
}

// 연결 종료
function disConnect() {
	mqttClient.disconnect();
	console.log('연결 종료');
	return mqttState = 4 ;
}


// **********  **********  ********** [SUBSCRIBE] 메세지 받기  ********** ********** **********

// 구독 먼저 : subTopic -> mqttClient.subscribe(subTopic);
// 메시지 받는 부분, 구독한 채널에 메세지 도착 처리
function onMessageArrived(message) 
{
    console.log("onMessageArrived : " + message.payloadString);

    // mqtt 받은 메시지 
    // 받은 메시지를 각 화면에서 사용하려면 각 화면에서 아래 function 선언하여 사용
    fncMqttAction(message.payloadString);
}

// 메세지 동적 그리기
function fncMqttAction(mqttMsg){
	let i_output = [];
	
	// 1) 특정 문자열 자르기
	let str = mqttMsg.replace(/\}/g, "").replace(/\{/g, "").replace(/\\"/g, "").replace(/\:/g, ",");
	
	
	// 2) 배열 만들기
	let strArry = str.split(',');	
	let time = strArry[5]; // 시간 내용
	let send_user = strArry[13]; // 보낸 사람
	let msg = strArry[19]; // 텍스트 내용
	
	console.log('time		' + time);
	console.log('send_user	' + send_user);
	console.log('msg		' + msg);
	
	
	i_output.push('<div class="chat-message-left pb-4">');
	i_output.push('<div> <div class="text-muted small text-nowrap mt-2">' + send_user + '</div> </div>');
	i_output.push('<div class="flex-shrink-1 bg-light rounded py-2 px-3 ml-3">');
	i_output.push('<div class="font-weight-bold mb-1">' + msg + '</div>');
	i_output.push('<h6><small>' + displayTime(time) + '</small></h6>');
	i_output.push('</div>');
	i_output.push('</div>');
	
	 $('#mqttClientMsg').html(i_output.join(''));
	// 널 값, 스페이스 엔터 오류

	// document.write(mqttMsg);
	// $('#msg').append(clientId + ' 님 : ' + mqttMsg + '<br>')
}


// 대화방 동적 그리기
function subCallback(subTopic) { }


// **********  **********  ********** [PUBLISH]  메세지 보내기  ********** ********** **********
// 발행 : pubTopic -> fncMqttDoSend(pubTopic, msg);
// 각 화면에서 메시지를 보내려면 각 화면에서 아래 function 선언하여 사용
function fncMqttDoSend(pubTopic, sendMsg) { mqttClient.send(pubTopic, sendMsg); }

