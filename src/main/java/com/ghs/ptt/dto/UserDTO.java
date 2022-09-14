package com.ghs.ptt.dto;

import java.util.List;

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
public class UserDTO {

	private int user_num; 		// 사용자 번호
	private String user_nm; 	// 사용자 이름
	private String user_id; 	// 사용자 아이디
	private String user_lvl; 	// 사용자 레벨
	private String e164_no; 	// 사용자 e164_no
	private String user_pwd;	// 사용자 비밀번호
	private String co_num;		// 부서  부서_번호
	private String dpart_num; 	// 부서  부서_번호
	private String user_pst;	// 사용자 직급
	private String sip_svr_id;	// 사용자 sip
	private String mqtt_svr_id; // 사용자 mqtt
	private String editor; 		// 사용자 사용자_작성자
	private String crt_ymdt; 	// 사용자 생성_일시
	private String mdfy_ymdt; 	// 사용자 수정_일시
	private int rnum;			// 번호
	
	// private List<ChatUserDTO> info; // mapper resultMap의 collection일 때, List 사용
	// private ChatUserDTO info // association
	
	@Data				
	@NoArgsConstructor 	
	@AllArgsConstructor
	public static class position {
		private int pst_num; 		// 사용자 직책번호
		private String pst; 		// 사용자 직책명
	}
		
	//private int userCnt;		// 사용자 수 

	
	/*
	//@JsonIgnore //Getter에서 사용, 특정 변수를 json 변환에서 제외
	@JsonIgnore
	public int getUser_num() {
		return user_num;
	}
	 
	
	@Data				
	@NoArgsConstructor 	
	@AllArgsConstructor
	public static class contents{
		private String user_nm; 	// 사용자 이름
		private String user_id; 	// 사용자 아이디
		private String user_pwd;	// 사용자 비밀번호
		private String dpart_num; 	// 사용자_부서 부서_번호
	}
	
	@Getter @Setter
	public static class insertUser {
		private String user_nm; 	// 사용자 이름
		private String user_id; 	// 사용자 아이디
		private String user_pwd;	// 사용자 비밀번호
		private String dpart_num; 	// 사용자_부서 부서_번호
	}
	
	@Getter @Setter
	public static class updateUser {
		private int user_num; 		// 사용자 번호
		private String user_nm; 	// 사용자 이름
		private String user_id; 	// 사용자 아이디
		private String user_pwd;	// 사용자 비밀번호
		private String dpart_num; 	// 사용자_부서 부서_번호
		private String editor; 		// 사용자 사용자_작성자
	}
	
	@Getter @Setter
	public static class updatePw {
		private int user_num; 		// 사용자 번호
		private String user_pwd;	// 사용자 비밀번호
		//private String 			// 사용자 초기 비밀번호
	}
	
	@Getter @Setter			
	@NoArgsConstructor 	
	@AllArgsConstructor
	public static class deleteUser {
		private int user_num; 		// 사용자 번호
		private String user_pwd;	// 사용자 비밀번호
	}
	*/
}
