package com.ghs.ptt.dao;

import java.util.List;
import java.util.Map;

import com.ghs.ptt.dto.LoginDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.UserResDTO;


public interface UserDAO {


	// 아이디 중복
	public int insertIdCheck(Map<String, String> params) throws Exception;

	// 사용자 상세 보기
	public UserResDTO getViewUser(int user_num) throws Exception;
	
	// 사용자 로그인
	public UserDTO login(UserDTO USER) throws Exception;

	// 사용자 레벨 구분
	public String userLvl();
	
	

	public List<UserDTO> downloadExel(UserDTO USER) throws Exception;

	
	// 사용자 목록
	public List<UserDTO> listUser(SearchCriteria scri)throws Exception;
	// 사용자 수
	public int listCount(SearchCriteria scri) throws Exception;
	
	
	
	// e164 조회
	public UserDTO getE164(UserDTO USER) throws Exception;
	
}
