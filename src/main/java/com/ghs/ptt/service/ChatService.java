package com.ghs.ptt.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.ChatDTO;
import com.ghs.ptt.dto.ChatUserDTO;
import com.ghs.ptt.dto.MsgDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.ResponseDTO;

public interface ChatService {

	// 채팅방 목록
	// public List<ChatDTO> listChat(PageDTO PAGE);

	// 채팅방 상세 보기
	public ChatDTO viewChat(int chat_room_num);

	// 메세지 내용
	public List<MsgDTO> getMsg(int chat_room_num);
	//public MsgDTO getMsg(int chat_room_num);

	// 대화 참여자 정보
	public List<ChatUserDTO> getChatUser(int chat_room_num);

	public List<UserDTO> findUserInfo(int user_num);

	// 엑셀
	public void downloadExel(ChatDTO CHAT, HttpServletResponse response);

	// 목록
	public List<ChatDTO> listChat(SearchCriteria scri) throws Exception;

	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception;
	
	

}
