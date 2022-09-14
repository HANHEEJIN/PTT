package com.ghs.ptt.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.CompanyDTO;
import com.ghs.ptt.responseDto.UserResDTO;
import com.ghs.ptt.service.DpartService;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;

@Controller
@RequestMapping("/dpart")
public class DpartController {

	
	@Inject private DpartService dpartService;
	
	//private ModelAndView mav = new ModelAndView();

	/* **********  **********  ********** 페이지 jsp 이동 **********  **********  **********  */
	// insertDpart.jsp 이동
	@GetMapping(value = "/insertDpartForm")
	public String insertDpartForm() {
		return "dpart/insertDpart";
	}
	
	// listDpart.jsp 글쓰기 페이지 이동
	@GetMapping(value = "/listDpart.do")
	public String listDpart() {
		return "dpart/listDpart"; // listDpart.jsp로 이동
	}
	
	/* **********  **********  ********** 부서 상세 JSON **********  **********  **********  */

	// REST API 부서 리스트
	// viewDpart.jsp 이동
	@GetMapping(value = "/getViewDpart/{dpart_index}")
	@ResponseBody
	public ResponseEntity<DpartDTO> getViewDpart(@PathVariable("dpart_index") int dpart_index) {
		ResponseEntity<DpartDTO> entity = null;
		try {
			entity = new ResponseEntity<>(dpartService.getViewDpart(dpart_index), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		//return new ResponseEntity<>(dpartService.getViewDpart(dpart_index), HttpStatus.OK);
		return entity;
		
	}
	
	/* **********  **********  ********** 직급 JSON **********  **********  **********  */
	
	// REST API 직급 리스트
	// viewDpart.jsp 이동
	@GetMapping(value = "/getPosiList/{posi_num}")
	@ResponseBody
	public ResponseEntity<List<PositionDTO>> getPosiList(@PathVariable("posi_num") int pst_num) {
		ResponseEntity<List<PositionDTO>> entity = null;
		try {
			entity = new ResponseEntity<>(dpartService.getPosiList(pst_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		//return new ResponseEntity<>(dpartService.getPosiList(pst_num), HttpStatus.OK);
		return entity;
	}
	
	/* **********  **********  ********** 회사 상세정보 JSON **********  **********  **********  */
	
	// REST API 회사 상세정보
	// viewDpart.jsp 이동
	@GetMapping(value = "/getViewCompany/{co_index}")
	@ResponseBody
	public ResponseEntity<CompanyDTO> getViewCompany(@PathVariable("co_index") int co_index) {
		ResponseEntity<CompanyDTO> entity = null;
		try {
			entity = new ResponseEntity<>(dpartService.getViewCompany(co_index), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		//return new ResponseEntity<>(dpartService.getPosiList(pst_num), HttpStatus.OK);
		return entity;
	}
	
	/* **********  **********  ********** 회사 목록 JSON **********  **********  **********  */
	// REST API 회사 상세정보
	// producesproduces 웹 출력 형식
	@GetMapping(value = "/getListDpart", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<DpartDTO> getListDpart() {
		ResponseEntity<DpartDTO> entity = null;
		
		try {
			entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.READ, dpartService.listDpart()), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	// 엑셀
	@GetMapping("/downloadExel")
	public void downloadExel(@ModelAttribute DpartDTO DPART, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		dpartService.downloadExel(DPART, response);
	}
	
		
	
}
