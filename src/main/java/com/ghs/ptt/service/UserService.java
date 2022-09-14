package com.ghs.ptt.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.LoginDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.UserResDTO;

public interface UserService {

	// 아이디 중복
	public int insertIdCheck(Map<String, String> params) throws Exception;

	// 사용자 상세 보기
	public UserResDTO getViewUser(int user_num) throws Exception;

	// 사용자 로그인
	public UserDTO login(UserDTO USER) throws Exception;

	// 사용자 로그아웃
	// public void logOut() throws Exception;

	// 엑셀
	public void downloadExel(UserDTO USER, HttpServletResponse response) throws Exception;

	// 사용자 목록
	public List<UserDTO> listUser(SearchCriteria scri) throws Exception;
	
	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 엑셀 업로드
	//ublic List<UserDTO> insertExcel(MultipartHttpServletRequest request, Model model, HttpServletResponse response) throws Exception;
	
	//
	//public List<UserDTO> insertExcel(MultipartFile excelFile) throws Exception;
	

	// e164
	public UserDTO getE164(UserDTO USER) throws Exception;

}
