package com.ghs.ptt.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ghs.ptt.dto.PageMaker;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.UserResDTO;
import com.ghs.ptt.service.UserService;
import com.ghs.ptt.util.E164Util;
import com.ghs.ptt.util.SessionListener;
import com.ghs.ptt.util.AES.AES128;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;


@Controller
//@RestController
@RequestMapping("/user")
@SessionAttributes("LOGIN") //세션
public class UserController {

	@Inject private UserService userService;
	//HttpSession session;
	String key = "ghs2022lab000000";		// KEY(16Byte)
	AES128 aes = new AES128(key); 			// AES128클래스 객체 선언(인스턴스화)
	
	private ModelAndView mav = new ModelAndView();
	
	@Resource(name = "E164Util")
	E164Util E164Util;

	
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
	
	
	
	
	// JSON ->  데이터 확인 시, /server/getViewSip/{svr_num}.json
	// REST API SIP 상세 정보 조회
	@GetMapping(value = "/getViewUser/{user_num}")
	@ResponseBody // json ->문자열 객체로 변환
	public ResponseEntity<UserResDTO> getViewUser(@PathVariable("user_num") int user_num) throws Exception {
		
		ResponseEntity<UserResDTO> entity = null;
		UserResDTO is_sus = userService.getViewUser(user_num);
		
		if(is_sus != null) {
			try {
				entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.READ, is_sus), HttpStatus.OK);
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}

		} else {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}		
		return entity;
	}
	
	// login 사용자 로그인
	@RequestMapping(value = "/login.do")
	public String login(@ModelAttribute UserDTO USER, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) throws Exception {
		
		
		HttpSession session = null;
		
		// 1) form user_id값 request에 저장 (API로 로그인 성공된 ID가져옴)
		//String id = request.getParameter("user_id");
		
		// 2) 로그인된 ID 정보 조회
		UserDTO login = userService.login(USER);
		String id = login.getUser_id();
		
		String url = null;
		
		// 3) 로그인 성공 (login != null)
		if(login != null) {
			
			// 4) 세션 객체 생성
			session = request.getSession(true);	// true : 세션 존재시 현재 세션 반환, 없으면 세션 생성  / false : 세션 존재 현재 세션 반환, 없으면 세션 생성x null을 반환
			
			// 5) 이미 접속한 아이디 체크, 현재 접속자 보여줌, isUsing(변수) -> request.getParamater 변수
			SessionListener.getInstance().printloginUsers();
			
			// false : 중복 없음, true : 중복 있음
			if(SessionListener.getInstance().isUsing(id)) {
				System.out.println("중복 로그인 O");
				rttr.addFlashAttribute("LOGIN", "USING_USER");
				
				url = "redirect:/";
				
			} else {
				System.out.println("중복 로그인 X");
			
				
				// 7) 로그인 권한 레벨 정보
				String lvl = login.getUser_lvl();
			
				// 8) 로그인 권한 레벨, LOGIN : 관리자 a A , 사용자 u U, 그 외 USER_INFO_ERROR
				if(lvl.equals("a") || lvl.equals("A")) {
					rttr.addFlashAttribute("LOGIN", "SUS_ADMIN");
					url = "redirect:/dashBoard";
					
				} else if(lvl.equals("u") || lvl.equals("U")) {
					rttr.addFlashAttribute("LOGIN", "SUS_USER");
					url = "redirect:/dashBoardGuest";
				} else {
					rttr.addFlashAttribute("LOGIN", "USER_INFO_ERROR");
					url = "redirect:/dashBoard";
					session.setAttribute("sessionId", null);
				} 
				
				// 6) 접속하려는 아이디 세션에 담기, session에 id값을 저장
				// session.setAttribute("저장하고자 하는 변수명", 저방변수값), jsp사용 ${sesssionId}
				session.setMaxInactiveInterval(60*10); // 접속 시간 10분
				session.setAttribute("sessionId", login); // 로그인된 id값 -> api에서 로그인된 id를 받아오기때문에, 데베 직접 접근시, 조회된 id값으로 가져오기
				SessionListener.getInstance().setSession(session, id);
				
			}	
		} else {
			// 9) 로그인 실패 (login == null)
			url = "redirect:/dashBoard";
			session.setAttribute("sessionId", null);
			rttr.addFlashAttribute("LOGIN", "FAIL");
		}
		
		return url;
	}
	
	
	// logout 사용자 로그아웃
	@PostMapping(value = "/logOut")
	public String logOut(HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr, @RequestParam("user_id") String user_id) throws Exception {
		// userService.logOut();
		
		// 세션 전체 제거, 무효화
		HttpSession session = request.getSession();
		
		// 1) 저장된 세션 가져오기
		//Object object = session.getAttribute("sessionId"); 
		
		// 2) 저장된 세션값이 널이 아니면 
		/*
		if(object != null) {
			UserDTO user = (UserDTO) object;
			
			System.out.println("user_id " + user_id);
			System.out.println("user " + user); // user_id 값 확인
			session.removeAttribute("sessionId");
			session.invalidate();
			SessionListener.getInstance().removeSession(user_id);
			rttr.addFlashAttribute("LOGIN", "LOGOUT");
		}*/
		
		
		if(session != null) {
			//session.removeAttribute(user_id);
			session.invalidate();
			SessionListener.getInstance().removeSession(user_id);
			//session.setAttribute("sessionId", null);
			
			rttr.addFlashAttribute("LOGIN", "LOGOUT");
			System.out.println("[ 종료 세션 ID ] ... " + session.getId());
		}
		
		return "redirect:/";
	}
	
	
	
	
	/* **********  **********  ********** 리스트 **********  **********  **********  */
	@GetMapping(value = {"/listUser.do/{page}/{searchType}/{keyword}",  "/listUser.do/{page}/{searchType}", "/listUser.do/{page}"}, produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // GET, POST 둘다 지원
	@ResponseBody
	public ResponseEntity<HashMap<String, Object>> listUser(@ModelAttribute SearchCriteria scri,
			@PathVariable("page") int page, @PathVariable(required = false) String searchType, @PathVariable(required = false) String keyword) throws Exception {
	
		// searchType : user_num, user_nm, co_num 번호, 이름, 회사
		ResponseEntity<HashMap<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<UserDTO> list = userService.listUser(scri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(userService.listCount(scri));
		
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
		System.out.println("user list tempEndPage	" + pageMaker.getTempEndPage());
		
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
	
	
	/* **********  **********  ********** 다운로드 엑셀 **********  **********  **********  */
	
	// 엑셀
	@GetMapping("/downloadExel")
	public void downloadExel(@ModelAttribute UserDTO USER, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		userService.downloadExel(USER, response);
	}

	
	/* **********  **********  ********** 업로드 엑셀 **********  **********  **********  */
	/*
	 * @GetMapping("/uploadExel") public String uploadExel( ModelMap model,
	 * HttpServletRequest request) throws Exception{
	 * 
	 * return "redirect:/user/insertExcel.do"; }
	 */
	
	/* **********  **********  ********** 업로드 엑셀 **********  **********  **********  */
	@PostMapping("/insertExcel")
	@ResponseBody
	public ModelAndView insertExcel(MultipartFile testFile, MultipartHttpServletRequest request) throws  Exception{
        
        System.out.println("업로드 진행");
        
        MultipartFile excelFile = request.getFile("excelFile");
        
        if(excelFile == null || excelFile.isEmpty()) {
            throw new RuntimeException("엑셀파일을 선택해 주세요");
          //result.map("code", "0");
        	//result.map("msg", "업로드실패");
        } else {
        	//result.map("code", "1");
        	//result.map("msg", "업로드성공");
        }
        File destFile = new File("C:/Users/HAN/eclipse-workspace/ptt/src/main/webapp/resources/fileUpload/"+excelFile.getOriginalFilename());
        
        try {
            //내가 설정한 위치에 내가 올린 파일을 만들고 
            excelFile.transferTo(destFile);
        }catch(Exception e) {
            throw new RuntimeException(e.getMessage(),e);
        }
        
        //업로드를 진행하고 다시 지우기
        //userService.insertExcel(destFile);
        System.out.println("업로드 완료");
        destFile.delete();
        System.out.println("업로드 삭제");
        ModelAndView view = new ModelAndView();
        view.setViewName("/egovSampleList.do");
        
        return view;
    }
	
	
	// e164 번호
	@GetMapping(value = "/getE164", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public void getE164(@ModelAttribute UserDTO USER) throws Exception {
	
		// e164.getE164Util();
		// userService.e164num(e164_no);
		
		UserDTO user = userService.getE164(USER);
		
		
		String e164 = user.getE164_no();
		int num = user.getUser_num();
		
		System.out.println("마지막 getE164 " + e164);
		System.out.println("마지막 num     " + num);
		
		
		if (user != null) {
			E164Util.getE164Util(num);
		}
		
		 
		System.out.println("생성한 getE164 " + e164);
		System.out.println("생성한 num     " + num);
		
		//return "";

	}
	
}
