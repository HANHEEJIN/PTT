package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor
public class MsgDTO {

	private int msg_num; 		// 메시지 번호;
	private int snd_user_num; 	// 메시지 발신_사용자_번호;
	private int chat_room_num; 	// 대화방 번호;
	private String snd_ymdt; 	// 메시지 발신_일시;
	private int rcv_user_num; 	// 메시지 수신_사용자_번호;
	private String snd_msg; 	// 메시지 발신_메시지;
	private String msg_typ; 	// 메시지 메시지_타입;
	private String snd_eqp_nm; 	// 메시지 발신_장치_이름;
	private String snd_eqp_typ; // 메시지 발신_장치_타입;


}
