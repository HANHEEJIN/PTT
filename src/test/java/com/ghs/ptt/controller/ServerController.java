package com.ghs.ptt.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/*
@Controller
//@RequestMapping("/server")
public class ServerController {
	
	
	@Inject private SvrService svrService;
	
	private ModelAndView mav = new ModelAndView();

	// insertSip.jsp 이동
	@GetMapping(value = "/insertSipForm")
	public String insertSipForm() {

		return "server/insertSip";
	}
	*/

	/*
	// listSip.jsp 이동
	@GetMapping(value = "/listSip.do")
	public ModelAndView listSip(PageDTO PAGE,@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) { page = 1; }
		PAGE.setPage(page);
		
		List<SipDTO> SLIST = svrService.listSip(PAGE);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("SLIST", SLIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE
			
		
		mav.setViewName("server/listSip"); // 전달 vies : equip/listEqp
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		
		return mav; // home.jsp로 list가 전달
	}
	*/
	
	/*
	// listSip.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "/listSip.do", method = RequestMethod.GET)
	public String listSip() {
		return "server/listSip"; // writeBoard.jsp로 이동
	}	
	
	// viewSip.jsp 이동
	@GetMapping(value = "/viewSip")
	public String viewSip(@RequestParam String svr_num) {

		//mav.setViewName("server/listSip"); // 전달 view이름 .jsp
		//mav.addObject("SVIEW", svrService.viewSip(svr_num)); // view에 전달에 데이터

		return "server/listSip";
	}

	@GetMapping(value = "/getViewSip/{svr_num}")
	@ResponseBody
	public ResponseEntity<SipDTO> getViewSip(@PathVariable("svr_num") String svr_num) {

		//mav.setViewName("server/listSip"); // 전달 view이름 .jsp
		//mav.addObject("SVIEW", svrService.viewSip(svr_id)); // view에 전달에 데이터

		return new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
	}
	*/
	
	/* ------------------------------------------------------------------ */
	
	/*
	// insertMqtt.jsp 이동
	@GetMapping(value = "/insertMqttForm")
	public String insertMqttForm() {

		return "server/insertMqtt";
	}

	
	// listMqtt.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "/listMqtt.do", method = RequestMethod.GET)
	public String listMqtt() {
		return "server/listMqtt"; // writeBoard.jsp로 이동
	}
	*/
	
	/*
	// listMqtt.jsp 이동
	@GetMapping(value = "/listMqtt.do")
	public ModelAndView listMqtt(PageDTO PAGE,@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) { page = 1; }
		PAGE.setPage(page);
		
		List<MqttDTO> QLIST = svrService.listMqtt(PAGE);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("QLIST", QLIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE
			
		
		mav.setViewName("server/listMqtt"); // 전달 vies : equip/listEqp
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value

		return mav; // home.jsp로 list가 전달
	}
	*/
	
	/*
	// viewEqp.jsp 이동
	@GetMapping(value = "/viewMqtt")
	public String viewMqtt(@RequestParam String mqtt_svr_id) {

		//mav.setViewName("server/listMqtt"); // 전달 view이름 .jsp
		//mav.addObject("QVIEW", svrService.viewMqtt(mqtt_svr_id)); // view에 전달에 데이터

		return "server/listMqtt";
	}
	
	@GetMapping(value = "/getViewMqtt/{mqtt_svr_num}")
	@ResponseBody
	public ResponseEntity<MqttDTO> getViewMqtt(@PathVariable("mqtt_svr_num") String mqtt_svr_num) {

		//mav.setViewName("server/listSip"); // 전달 view이름 .jsp
		//mav.addObject("SVIEW", svrService.viewSip(svr_id)); // view에 전달에 데이터

		return new ResponseEntity<>(svrService.viewMqtt(mqtt_svr_num), HttpStatus.OK);
	}
}
*/