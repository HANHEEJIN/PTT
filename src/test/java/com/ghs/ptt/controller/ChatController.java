package com.ghs.ptt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/*
@Controller
//@RequestMapping("/chat")

public class ChatController {

	
	@Inject private ChatService chatService;
	
	private ModelAndView mav = new ModelAndView();

	// jsp이동
	// insertEqp.jsp 이동
	@GetMapping(value = "/insertEqpForm")
	public String insertChatForm() {

		return "chat/insertChat";
	}

	// jsp이동
	// insertChatForm.jsp 이동
	@GetMapping(value = "/insertChatForm")
	public String insertEqpForm() {

		return "chat/insertChat";
	}

	// listChat.jsp 이동
	@GetMapping(value = "/listChat.do")
	public ModelAndView listChat(PageDTO PAGE, @RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) { page = 1;}
		PAGE.setPage(page);

		List<ChatDTO> CLIST = chatService.listChat(PAGE);
		//List<MsgDTO> MSGLIST = chatService.getMsg(chat_room_num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("CLIST", CLIST); // user/listUser.jsp 로 이동
		//map.put("MSG", MSGLIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE

		// mav.addObject("PAGE", PAGE);
		// mav.addObject("DLIST", DLIST); // view로 보낼 데이터 값 : 데이터를 저장 / key:value

		mav.setViewName("chat/listChat"); // 전달 vies : equip/listEqp
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value

		return mav; // home.jsp로 list가 전달
	}

	// viewChat.jsp 이동
	@GetMapping(value = "/viewChat")
	public ModelAndView viewChat(@RequestParam int chat_room_num) {

		mav.setViewName("chat/viewChat"); // 전달 view이름 .jsp
		mav.addObject("CVIWE", chatService.viewChat(chat_room_num)); // view에 전달에 데이터

		return mav;
	}

	/*  **********  **********  **********  **********  **********  대화 메세지  **********  **********  **********  **********  **********  */
	/*
	// lidtChat.jsp의 getMsg 메세지 내용 받기
	@GetMapping(value = "/getMsg")
	public ModelAndView getMsg(@RequestParam int chat_room_num) {

		List<MsgDTO> MSGLIST = chatService.getMsg(chat_room_num);
		List<ChatUserDTO> CUSERLIST = chatService.getCUser(chat_room_num);
		
		mav.setViewName("chat/listChat"); // 전달 view이름 .jsp
		mav.addObject("MSG", MSGLIST); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		mav.addObject("CUSER", CUSERLIST); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		
		System.out.println("[MSG]..." + MSGLIST);

		return mav;
	}
	*/

	/*  **********  **********  **********  **********  ********** 대화 메세지 참여자  **********  **********  **********  **********  **********  */
	/*
	// listChat.jsp 이동
	@GetMapping(value = "/getChatUser.do")
	public ModelAndView getChatUser(@RequestParam int chat_room_num) {

		 List<ChatUserDTO> CHLIST = chatService.getChatUserList();
		  
		 mav.setViewName("chat/listChat"); // 전달 vies : equip/listEqp
		 mav.addObject("CHLIST", CHLIST); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		 
		return mav; // home.jsp로 list가 전달
	}
	

}
	*/