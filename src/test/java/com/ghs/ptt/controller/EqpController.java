package com.ghs.ptt.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/*
@Controller
//@RequestMapping("/equip")
public class EqpController {
	
	
	@Inject private EqpService eqpService;
	
	private ModelAndView mav = new ModelAndView();
	
	// jsp이동
	// insertEqp.jsp 이동
	
	@GetMapping(value = "/insertEqpForm")
	public String insertEqpForm() {

		return "equip/insertEqp";
	}
	*/
	
	/*
	// listEqp.jsp 이동
	@GetMapping(value = "/listEqp.do")
	public ModelAndView listEqp(PageDTO PAGE,@RequestParam(value = "page", required = false, defaultValue = "1") int page)  {
		
		 
		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) { page = 1; }
		PAGE.setPage(page);
		
		List<EqpDTO> ELIST = eqpService.listEqp(PAGE);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ELIST", ELIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE
		
		mav.setViewName("equip/listEqp"); // 전달 vies : equip/listEqp
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		
		return mav; // home.jsp로 list가 전달
	}
	*/
	
	/*
	// listUser.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "/listEqp.do", method = RequestMethod.GET)
	public String listEqp() {
		return "equip/listEqp"; // writeBoard.jsp로 이동
	}
	
	
	// viewEqp.jsp 이동
	@GetMapping(value = "/viewEqp")
	public ModelAndView viewEqp(@RequestParam int equip_num) {

		mav.setViewName("equip/viewEqp"); // 전달 view이름 .jsp
		mav.addObject("EVIWE", eqpService.viewEqp(equip_num)); // view에 전달에 데이터
		
		return mav;
	}
	
}
*/