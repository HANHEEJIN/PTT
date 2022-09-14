package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class ChatDTO {
	private int chat_room_num; // 대화방 번호;
	private String chat_room_nm; // 대화방 이름;
	private String chat_room_conn_num; // 대화방 접속번호;
	private String chat_room_pwd; // 대화방 비밀번호;
	private String chat_room_typ; // 대화방 타입;
	private String editor; // 대화방 작성자;
	private String crt_ymdt; // 대화방 생성_일시;
	private String mdfy_ymdt; // 대화방 수정_일시;
	private int rnum;
}
