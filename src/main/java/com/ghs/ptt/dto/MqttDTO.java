package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class MqttDTO {
	private String mqtt_svr_num; // MQTT NUMBER;
	private String mqtt_svr_id; // MQTT 아이디;
	private String mqtt_svr_ip; // MQTT IP;
	private String mqtt_svr_port; // MQTT PORT;
	private String mqtt_svr_type; // MQTT PORT;
	private int rnum;
}
