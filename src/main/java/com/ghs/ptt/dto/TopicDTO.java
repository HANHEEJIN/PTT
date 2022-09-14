package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class TopicDTO {
	
	private int topic_num; 		// 토픽  번호
	private int user_num; 		// 사용자 번호
	private String topic_id; 	// 토픽 ID
	private String crt_ymdt; 	// 생성일
	private String topic_nm;	// topic 상위
}
