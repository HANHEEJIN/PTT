package com.ghs.ptt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

/*
@Controller
//@RestController
//@RequestMapping("/user")
//@SessionAttributes("LOGIN") //세션
public class UserController {

	
	@Inject private UserService userService;
	@Inject private DpartService dpartService;
	@Inject private SvrService svrService;
	private PositionDTO POSI;
	HttpSession session;
	
	
	private ModelAndView mav = new ModelAndView();
	
	//private JSONObject obj = new JSONObject();
	//private String msg = null;
	//private String url = null;
	
	// jsp이동
	// insertUser.jsp 이동
	@GetMapping(value = "/insertUserForm")
	public ModelAndView insertUserForm(PageDTO PAGE, @RequestParam(value = "page", required = false, defaultValue ="1") int page) {

		if (page <= 0) {page = 1;}
		PAGE.setPage(page);
		
		//List<PositionDTO> CLIST = dpartService.listCompany(); // 회사코드
		List<DpartDTO> DLIST = dpartService.listDpart(PAGE);  // 부서
		List<PositionDTO> PLIST = userService.getPosition(POSI); // 직급
		List<SipDTO> SLIST = svrService.listSip(PAGE); 		 // SIP
		List<MqttDTO> QLIST = svrService.listMqtt(PAGE); // MQTT

		Map<String, Object> map = new HashMap<String, Object>();
		
		//map.put("CLIST", CLIST);
		map.put("DLIST", DLIST);
		map.put("PLIST", PLIST);
		map.put("SLIST", SLIST);
		map.put("QLIST", QLIST);
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE
		
		mav.setViewName("user/insertUser");
		mav.addObject("map", map);

		return mav;
	}
	
	// 아이디 중복 체크
	// RequestParam <-> jsp html 태그에 name으로 매칭
	@PostMapping(value = "/insertIdCheck", produces = "application/json; charset=utf8")
	@ResponseBody
	public int insertIdCheck(@RequestBody Map<String, String> params) throws Exception {

		int idCheck = userService.insertIdCheck(params);

		try {
			// 아이디가 중복이면 1, 아니면 0
			if (idCheck == 0) {
				params.put("msg", "ID_CHECK_SUS"); // string 형 일때, data.msg = "ID_CHECK_SUS"
			} else if (idCheck == 1) {
				// return "user/insertUser";
				params.put("msg", "ID_CHECK_FAIL");
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}

		System.out.println("중복 아이디 체크 : " + params);

		return idCheck;
	}

	// listUser.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "/listUser.do", method = RequestMethod.GET)
	public String listUser() {
		return "user/listUser"; // writeBoard.jsp로 이동
	}
	*/
	
	/*
	// listUser.jsp 사용자 목록 이동, 처리
	// paging, search
	@ResponseBody
	@GetMapping(value = "/listUser.do")
	public ModelAndView listUser(PageDTO PAGE,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "user_id") String searchType,
			@RequestParam(required = false, defaultValue = "") String keyword) throws Exception {

		System.out.println(page);
		System.out.println(searchType);
		System.out.println(keyword);

		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) {page = 1;}
		PAGE.setPage(page);

		List<UserDTO> USER_LIST = userService.listUser(PAGE, searchType, keyword);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ULIST", USER_LIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE
		map.put("searchType", searchType); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		map.put("keyword", keyword);

		mav.setViewName("user/listUser"); // 전달 vies : user/listUser
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value

		return mav; // home.jsp로 list가 전달
	}
	*/
	
	/*
	// viewUser.jsp 사용자 상세보기 이동
	@GetMapping(value = "/viewUser")
	public ModelAndView viewUser(@RequestParam int user_num) throws Exception {
		mav.setViewName("user/viewUser"); // 전달 view이름 .jsp
		mav.addObject("VUSER", userService.viewUser(user_num)); // view에 전달에 데이터
		return mav;
	}
	

	// login 사용자 로그인
	@RequestMapping(value = "/login.do")
	public ModelAndView login(HttpServletRequest request) throws Exception {
		
		// session 객체 생성
		HttpSession session = request.getSession();
	
		// 1) jsp -> controller form user_id값 request에 저장
		String id = request.getParameter("user_id");
		
		
		//System.out.println("[CONTROLLER SESSION ID]... " + session.getAttribute("LOGIN_ID"));
		// 로그인 null 이면 실패, not null 성공
		if (id == null) {
			mav.setViewName("home"); // home.jsp
			mav.addObject("msg", "FAIL");
		} else if (id != null) {
			// 2) session에 id값을 저장
			// session.setAttribute("저장하고자 하는 변수명", 저방변수값)
			// 3) jsp 사용 시, ${sesssionId}
			session.setAttribute("sessionId", id);
			
			//mav.addObject("LOGIN", id);	// session.setAttributr("LOGIN", login), Controller의 어노테이션 SessionAttributr
			mav.setViewName("redirect:/user/listUser.do");
		}
		
		return mav;
	}
	*/
	
	/*
	// login 사용자 로그인
		@RequestMapping(value = "/login.do")
		public ModelAndView login(@ModelAttribute UserDTO USER, HttpServletRequest request) throws Exception {
			System.out.println(USER);
			
			
			HttpSession session = request.getSession();
			
			String name = "";
			// session.setAttribute("저장하고자 하는 변수명", 저방변수값)
			// html ${sesssionId}
			session.setAttribute("sessionId", name);
			
			
			UserDTO login = userService.login(USER);

			//System.out.println("[CONTROLLER SESSION ID]... " + session.getAttribute("LOGIN_ID"));
			// 로그인 null 이면 실패, not null 성공
			if (login == null) {
				mav.setViewName("home"); // home.jsp
				mav.addObject("msg", "FAIL");
			} else if (login != null) {
				// 성공 시, 사용자 레벨 a이면 관리자
				mav.addObject("LOGIN", login);	// session.setAttributr("LOGIN", login), Controller의 어노테이션 SessionAttributr
				String u_lvl = login.getUser_lvl();
				
				if(u_lvl.equals("a")) {
					mav.addObject("msg", "ADMIN");
					mav.setViewName("redirect:/user/listUser.do"); // user/listBoard.jsp 로 이동
					
				} else if(u_lvl.equals("u")) {
					mav.addObject("msg", "USER");
					mav.setViewName("home"); // home.jsp
				}
				//mav.addObject("msg", "SUCCESS");
			}

			System.out.println("[CONTROLLER USER_LELVEL] : " + USER.getUser_lvl());
			System.out.println("[CONTROLLER LOGIN] : " + login);
			
			mav.setViewName("redirect:/user/listUser.do");
			return mav;
		}
		
	*/
	
	/*
	// logout 사용자 로그아웃
	@GetMapping(value = "/logOut")
	public ModelAndView logOut() throws Exception {
		userService.logOut();
		// 세션 전체 제거, 무효화
	    //session.invalidate();
	    
		mav.setViewName("home"); // home.jsp로 이동(login)
		mav.addObject("msg", "LOGOUT");
		
		
		return mav;
	}

	// 사용자수
	@RequestMapping(value = "")
	public int userCnt() {
		return userService.listUserCount();
	}


	// AJAX : 1) ajax pst 값을 조회  2) 결과값으로 pst 값 빼서 넣기 3) 사용자 등록 시, 값 같이 전달하기
	// 기본 DB 조회 후, ModelANdView로 받아서 데이터 넘겨서 jsp 쪽에서 jstl 사용해서 뿌려주기
	@GetMapping(value = "/getPosition")
	public ModelAndView getPosition(PositionDTO POSI) {
		
		// DB에서 해당 값을 가져와 JSON 형태로 만들어 줌
		List<PositionDTO> PLIST = userService.getPosition(POSI);
		
		mav.addObject("PLIST", PLIST);
		mav.setViewName("user/insertUser");
		return mav;
	}
	
}*/
