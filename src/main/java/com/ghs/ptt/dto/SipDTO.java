package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class SipDTO {
	private String svr_num; // MQTT NUMBER;
	private String svr_type; // MQTT NUMBER;
	private String svr_id; // SIP 아이디;
	private String svr_ip; // SIP IP;
	private String svr_port; // SIP PORT;
	private String svr_rpt_start_port;
	private String svr_rpt_count_port;
	private int rnum;
}
