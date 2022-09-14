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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.EqpDTO;
import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.PageMaker;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.service.EqpService;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;

@Controller
@RequestMapping("/equip")
public class EqpController {
	
	
	@Inject private EqpService eqpService;
	
	private ModelAndView mav = new ModelAndView();
	
	// jsp이동
	// insertEqp.jsp 이동
	@GetMapping(value = "/insertEqpForm")
	public String insertEqpForm() {

		return "equip/insertEqp";
	}
	
	// listUser.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "/listEqp.do", method = RequestMethod.GET)
	public String listEqp() {
		return "equip/listEqp"; // writeBoard.jsp로 이동
	}
	
	
	/* **********  **********  ********** JSON **********  **********  **********  */
	
	// viewDpart.jsp 이동
	@GetMapping(value = "/viewEqp")
	public String viewEqp(@RequestParam String equip_num) {
		return "equip/listEqp";
	}
	
	
	// REST API SIP 상세 정보 조회
	@GetMapping(value = "/getViewEqp/{equip_num}")
	@ResponseBody
	public ResponseEntity<EqpDTO> getViewEqp(@PathVariable("equip_num") int equip_num) {
		
		ResponseEntity<EqpDTO> entity = null;
		try {
			entity = new ResponseEntity<>(eqpService.viewEqp(equip_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
		//return new ResponseEntity<>(eqpService.viewEqp(equip_num), HttpStatus.OK);
	}
	
	// 엑셀
	@GetMapping("/downloadExel")
	public void downloadExel(@ModelAttribute EqpDTO EQP, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		eqpService.downloadExel(EQP, response);
	}
		
	/* **********  **********  ********** 리스트 **********  **********  **********  */
	@GetMapping(value = {"/listEqp.do/{page}/{searchType}/{keyword}",  "/listEqp.do/{page}/{searchType}"}, produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // GET, POST 둘다 지원
	@ResponseBody
	public ResponseEntity<HashMap<String, Object>> listEqp(@ModelAttribute SearchCriteria scri,
			@PathVariable("page") int page, @PathVariable("searchType") String searchType, @PathVariable(required = false) String keyword) throws Exception {
	
		ResponseEntity<HashMap<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<EqpDTO> list = eqpService.listEqp(scri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(eqpService.listCount(scri));
		
		map.put("list", list); // user/listUser.jsp 로 이동
		map.put("pageMaker", pageMaker); // request영역에 dto객체 올리기 PageDTO-> PAGE

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


