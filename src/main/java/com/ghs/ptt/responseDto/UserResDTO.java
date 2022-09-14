package com.ghs.ptt.responseDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// Controller와 view사이에서 데이터 주고 받기 위한 용도
// VO를 Back-End 내에서 (비즈니스 로직 등) 매핑처리가 필요한 경우에 반환하여 사용하는 객체


@Data				// getter, setter, toString
@NoArgsConstructor 	// 비어있는 생성자 만듬
@AllArgsConstructor // 생성자, 모든 속성 사용, RequestBody에서는 기본 생성자 필요, setter는 불 필요
@Builder
public class UserResDTO {


	private int user_num; 		// 사용자 번호
	private String user_nm; 	// 사용자 이름
	private String user_id; 	// 사용자 아이디
	private String user_lvl; 	// 사용자 레벨
	private String e164_no; 	// 사용자 e164_no
	private String co_num;		// 부서 회사 번호
	private String dpart_num; 	// 부서 부서 번호
	private String user_pst;	// 사용자 직급
	private String sip_svr_id;	// 사용자 sip
	private String mqtt_svr_id; // 사용자 mqtt
	private String editor; 		// 사용자 사용자_작성자
}
