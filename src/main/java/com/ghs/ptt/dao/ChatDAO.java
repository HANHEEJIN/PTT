package com.ghs.ptt.dao;

import java.util.List;

import com.ghs.ptt.dto.ChatDTO;
import com.ghs.ptt.dto.ChatUserDTO;
import com.ghs.ptt.dto.MsgDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.ResponseDTO;

public interface ChatDAO {

	
	// 대화방 목록
	//public List<ChatDTO> listChat(PageDTO PAGE);

	// 대화방 수
	//public int chatCount();
	
	// 대화방 상세 보기
	public ChatDTO viewChat(int chat_room_num);

	// 메세지 내용
	public List<MsgDTO> getMsg(int chat_room_num);
	
	// 메세지 수
	public int msgCount();
		
	// 대화 참여자 정보
	public List<ChatUserDTO> getChatUser(int chat_room_num);

	// 대화 참여자 수
	public int cuserCount();

	public List<UserDTO> findUserInfo(int user_num);

	
	// 엑셀
	public List<ChatDTO> downloadExel(ChatDTO CHAT);
	
	// 목록
	public List<ChatDTO> listChat(SearchCriteria scri) throws Exception;

	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception;
	
	
}
