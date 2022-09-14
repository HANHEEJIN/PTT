package com.ghs.ptt.dto;

import java.util.List;

import com.ghs.ptt.responseDto.ResponseDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class ChatUserDTO {
	private int join_num; 		// 대화참여자 번호;
	private int chat_room_num; 	// 대화방 번호;
	private int user_num; 		// 사용자 번호;
	private String join_ymdt; 	// 대화참여자 참여_일시;
	private String join_stat; 	// 대화참여자 참여_상태;
	private String join_role; 	// 대화참여자 참여_역할;
	private String join_lvl; 	// 대화참여자 참여_권한;
	
	private List<ResponseDTO> info; // mapper resultMap의 collection일 때, List 사용
	//private ResUserDTO info; // association

}
