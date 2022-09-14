package com.ghs.ptt.responseDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @NoArgsConstructor @AllArgsConstructor 
public class SipResDTO {

	private String svr_type; // MQTT NUMBER;
	private String svr_id; // SIP 아이디;
	private String svr_ip; // SIP IP;
	private String svr_port; // SIP PORT;
	
	private int svr_num; // MQTT NUMBER;
	private int svr_rpt_start_port; // SIP IP;
	private int svr_rpt_count_port; // SIP PORT;

}
