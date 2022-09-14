package com.ghs.ptt.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.dto.LoginDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.UserResDTO;

@Repository
public class UserDAOImpl implements UserDAO {
	
	@Inject
	SqlSession SqlSession;

	// 아이디 중복
	@Override
	public int insertIdCheck(Map<String, String> params) throws Exception{
		int idCheck = SqlSession.selectOne("User.insertIdCheck", params);
		return idCheck;
	}
	
	// 사용자 상세 보기
	@Override
	public UserResDTO getViewUser(int user_num) throws Exception {
		return SqlSession.selectOne("User.getViewUser", user_num);
	}

	// 사용자 로그인
	@Override
	public UserDTO login(UserDTO USER) throws Exception{
		return SqlSession.selectOne("User.login", USER);
	}


	// 사용자 레벨 구분
	@Override
	public String userLvl() {
		return SqlSession.selectOne("User.userLvl");
	}
	

	
	
	// 엑셀
	@Override
	public List<UserDTO> downloadExel(UserDTO USER) throws Exception {
		return SqlSession.selectList("User.downloadExel", USER);
	}
	
	// 사용자 목록
	@Override
	public List<UserDTO> listUser(SearchCriteria scri)throws Exception{
		return SqlSession.selectList("User.listUser", scri);
	}

	// 사용자 수
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		//int userCnt = userDao.listUserCount(); // 사용자수 
		return SqlSession.selectOne("User.listCount", scri);
		
	}
	
	
	
	// e164 조회
	@Override
	public UserDTO getE164(UserDTO USER) throws Exception{
		return SqlSession.selectOne("User.getE164", USER);
	}
	
}
