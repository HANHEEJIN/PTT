package com.ghs.ptt.dto;

import lombok.Data;

@Data
public class LoginDTO {
	
	private String user_id; 	// 사용자 아이디
	private String user_pwd;
	private String user_lvl; 	// 사용자 레벨
	private boolean useCookie;

}
