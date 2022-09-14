package com.ghs.ptt.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.dto.ChatDTO;
import com.ghs.ptt.dto.ChatUserDTO;
import com.ghs.ptt.dto.MsgDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;

@Repository
public class ChatDAOImpl implements ChatDAO{
	
	@Inject
	SqlSession SqlSession;
	
	// 목록
	public List<ChatDTO> listChat(SearchCriteria scri) throws Exception{
		return SqlSession.selectList("Chat.listChat", scri);
	}

	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception{
		return SqlSession.selectOne("Chat.listCount", scri);
	}
		
	
	// 대화방 목록
	/*
	public List<ChatDTO> listChat(PageDTO PAGE){
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("startRow", PAGE.getStartRow());
		map.put("endRow", PAGE.getEndRow());
		
		return SqlSession.selectList("Chat.listChat", map);
	}
	

	// 대화방 수
	public int chatCount() {
		return SqlSession.selectOne("Chat.chatCount");
	}
	*/
	
	// 대화방 상세 보기
	@Override
	public ChatDTO viewChat(int chat_room_num) {
		return SqlSession.selectOne("Chat.viewChat", chat_room_num);
	}
	
	// 메세지 내용
	@Override
	public List<MsgDTO> getMsg(int chat_room_num){
		return SqlSession.selectList("Chat.getMsg", chat_room_num);
	}
	
		
	// 메세지 수
	@Override
	public int msgCount() {
		return SqlSession.selectOne("Chat.msgCnt");
	}
	

	// 대화 참여자 정보
	@Override
	public List<ChatUserDTO> getChatUser(int chat_room_num){
		return SqlSession.selectList("Chat.getChatUser", chat_room_num);
	}
	
	// 대화 참여자 수
	@Override
	public int cuserCount() {
		return SqlSession.selectOne("Chat.cuserCnt");	
	}
	
	@Override
	public List<UserDTO> findUserInfo(int user_num){
		return SqlSession.selectList("Chat.findUserInfo", user_num);
	}
	
	@Override
	public List<ChatDTO> downloadExel(ChatDTO CHAT){
		return SqlSession.selectList("Chat.downloadExel", CHAT);
	}
}
