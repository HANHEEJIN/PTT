package com.ghs.ptt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ghs.ptt.dto.ChatDTO;
import com.ghs.ptt.dto.ChatUserDTO;
import com.ghs.ptt.dto.MsgDTO;
import com.ghs.ptt.dto.PageMaker;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.service.ChatService;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;

@Controller
@RequestMapping("/chat")
public class ChatController {

	@Inject private ChatService chatService;
	
	private ModelAndView mav = new ModelAndView();

	/* **********  **********  ********** 페이지 jsp 이동 **********  **********  **********  */

	// insertChatForm.jsp 이동
	@GetMapping(value = "/insertChatForm")
	public String insertChatForm() {
		return "chat/insertChat";
	}
	
	// listChat.jsp 이동
	@GetMapping(value = "/listChat.do")
	public String listChat() {
		return "chat/listChat";
	}
	
	/* **********  **********  ********** 대화방 상세 정보 JSON **********  **********  **********  */
	// viewChat.jsp 이동
	@GetMapping(value = "/viewChat")
	public ModelAndView viewChat(@RequestParam int chat_room_num) {

		mav.setViewName("chat/viewChat"); // 전달 view이름 .jsp
		mav.addObject("CVIWE", chatService.viewChat(chat_room_num)); // view에 전달에 데이터

		return mav;
	}
	
	/* **********  **********  ********** 대화 메세지 JSON **********  **********  **********  */
	// getMsg 메세지 내용 조회
	@GetMapping(value = "/getMsg/{chat_room_num}")
	@ResponseBody
	public ResponseEntity<List<MsgDTO>> getMsg(@PathVariable("chat_room_num") int chat_room_num) {
		
		ResponseEntity<List<MsgDTO>> entity = null;
		try {
			entity = new ResponseEntity<>(chatService.getMsg(chat_room_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
		// return new ResponseEntity<>(chatService.getMsg(chat_room_num), HttpStatus.OK);
	}
	
	/* **********  **********  ********** 대화방 사용자 조회 JSON **********  **********  **********  */
	// viewMqtt.jsp 이동 MQTT 상세 정보 조회
	@GetMapping(value = "/getChatUser/{chat_room_num}")
	@ResponseBody
	public ResponseEntity<List<ChatUserDTO>> getChatUser(@PathVariable("chat_room_num") int chat_room_num) {
		
		ResponseEntity<List<ChatUserDTO>> entity = null;
		try {
			entity = new ResponseEntity<>(chatService.getChatUser(chat_room_num), HttpStatus.OK);
			
			
			
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
		// return new ResponseEntity<>(chatService.getCUser(chat_room_num), HttpStatus.OK);
	}
		
	/* **********  **********  ********** 대화방 사용자 상세 정보 조회 JSON **********  **********  **********  */
	@GetMapping(value = "/findUserInfo/{user_num}")
	@ResponseBody
	public ResponseEntity<List<UserDTO>> findUserInfo(@PathVariable("user_num") int user_num) {
		
		ResponseEntity<List<UserDTO>> entity = null;
		try {
			entity = new ResponseEntity<>(chatService.findUserInfo(user_num), HttpStatus.OK);		

		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
		// return new ResponseEntity<>(chatService.getCUser(chat_room_num), HttpStatus.OK);
	}
	
	/* **********  **********  ********** 엑셀 **********  **********  **********  */
	@GetMapping("/downloadExel")
	public void downloadExel(@ModelAttribute ChatDTO CHAT, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		chatService.downloadExel(CHAT, response);
	}
	
	/* **********  **********  ********** 리스트 **********  **********  **********  */
	@GetMapping(value = {"/listChat.do/{page}/{searchType}/{keyword}",  "/listChat.do/{page}/{searchType}", "/listChat.do/{page}"}, produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // GET, POST 둘다 지원
	@ResponseBody
	public ResponseEntity<HashMap<String, Object>> listChat(@ModelAttribute SearchCriteria scri,
			@PathVariable("page") int page, @PathVariable(required = false) String searchType, @PathVariable(required = false) String keyword) throws Exception {
	
		// searchType : user_num, user_nm, co_num 번호, 이름, 회사
		ResponseEntity<HashMap<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<ChatDTO> list = chatService.listChat(scri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(chatService.listCount(scri));
		
		
		//scri.setSearchType(searchType);
		//scri.setKeyword(keyword);
		//scri.setPage(page);
		
		map.put("list", list); // user/listUser.jsp 로 이동
		map.put("pageMaker", pageMaker); // request영역에 dto객체 올리기 PageDTO-> PAGE
	
		System.out.println("user list pageMaker 	" + pageMaker);
		System.out.println("user list scri 			" + scri);
		System.out.println("user list page		 	" + scri.getPage());
		System.out.println("user list PerPage	 	" + scri.getPerPageNum());
		System.out.println("user list start		 	" + scri.getRowStart());
		System.out.println("user list end		 	" + scri.getRowEnd());
		
		
		
		if( map != null) {
			try {
				entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.READ, map), HttpStatus.OK);
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		} else {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}

}
