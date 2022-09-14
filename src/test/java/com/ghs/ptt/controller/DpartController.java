package com.ghs.ptt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


/*
@Controller
//@RequestMapping("/dpart")
public class DpartController {


	@Inject private DpartService dpartService;
	
	private ModelAndView mav = new ModelAndView();

	// jsp이동
	// insertDpart.jsp 이동
	@GetMapping(value = "/insertDpartForm")
	public String insertDpartForm() {

		return "dpart/insertDpart";
	}
	*/
	
	/*
	// listDpart.jsp 이동
	@GetMapping(value = "/listDpart.do")
	public ModelAndView listDpart(PageDTO PAGE,@RequestParam(value = "page", required = false, defaultValue = "1") int page)  {
		
		// 현재 페이지 계산 / 페이지 0보다 작으면 1
		if (page <= 0) { page = 1; }
		PAGE.setPage(page);
		
		List<DpartDTO> DLIST = dpartService.listDpart(PAGE);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("DLIST", DLIST); // user/listUser.jsp 로 이동
		map.put("PAGE", PAGE); // request영역에 dto객체 올리기 PageDTO-> PAGE

		mav.setViewName("dpart/listDpart"); // 전달 vies : user/listDpart
		
		mav.addObject("map", map); // view로 보낼 데이터 값 : 데이터를 저장 / key:value
		
		return mav; // home.jsp로 list가 전달
	}
	*/
	
	// listDpart.jsp 글쓰기 페이지 이동
	/*
	@RequestMapping(value = "/listDpart.do", method = RequestMethod.GET)
	public String listDpart() {
		return "dpart/listDpart"; // listDpart.jsp로 이동
	}
		
	
	// viewDpart.jsp 이동
	@GetMapping(value = "/viewDpart")
	public ModelAndView viewDpart(@RequestParam String dpart_num) {
		
		mav.setViewName("dpart/viewDpart"); // 전달 view이름 .jsp
		mav.addObject("VDPART", dpartService.viewDpart(dpart_num)); // view에 전달에 데이터

		return mav;
	}
	

}
*/