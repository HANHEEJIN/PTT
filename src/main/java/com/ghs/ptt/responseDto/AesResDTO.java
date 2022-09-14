package com.ghs.ptt.responseDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


public class AesResDTO {
	private int user_no; 	// 회사 번호
	private String user_id;	// 회사 이름
	private String user_pw;	// 회사 코드
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	@Override
	public String toString() {
		return "AesResDTO [user_no=" + user_no + ", user_id=" + user_id + ", user_pw=" + user_pw + "]";
	}
	
	
}
