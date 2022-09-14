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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.PageMaker;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.SipDTO;
import com.ghs.ptt.responseDto.SipResDTO;
import com.ghs.ptt.service.SvrService;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;

@Controller
@RequestMapping("/server")
public class ServerController {
	
	@Inject private SvrService svrService;
	//private SipResDTO SIP;
	
	
	// insertSip.jsp 이동
	@GetMapping(value = "/insertSipForm")
	public String insertSipForm() {
		return "server/insertSip";
	}


	// listSip.jsp SIP 목록 페이지 이동
	@GetMapping(value = "/listSip.do")
	public String listSip() {
		return "server/listSip"; // writeBoard.jsp로 이동
	}	
	
	// viewSip.jsp 이동
	@GetMapping(value = "/viewSip")
	public String viewSip(@RequestParam String svr_num) {
		return "server/listSip";
	}

	// JSON ->  데이터 확인 시, /server/getViewSip/{svr_num}.json
	// REST API SIP 상세 정보 조회
	@GetMapping(value = "/getViewSip/{svr_num}")
	@ResponseBody // json ->문자열 객체로 변환
	public ResponseEntity<SipResDTO> getViewSip(@PathVariable("svr_num") int svr_num) {
		
		ResponseEntity<SipResDTO> entity = null;
		try {
			entity = new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		//return new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
	}
	
	// JSON REST API SIP 목록
	@GetMapping(value = "/getSipList/{svr_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<SipResDTO>> getSipList(@PathVariable("svr_num") int svr_num) {
		ResponseEntity<List<SipResDTO>> entity = null;
		
		List<SipResDTO> is_sus = svrService.getSipList(svr_num);
	
		
		if( is_sus != null) {
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
	
	// produces 읍답 값 형식 지정: json, xml 
	// 1) MediaType.APPLICATION_XML_VALUE
	// 2) MediaType.APPLICATION_JSON_VALUE
	@PostMapping(value = "/sip/new", produces = MediaType.APPLICATION_JSON_VALUE, consumes="application/json")
	@ResponseBody
	public ResponseEntity<String> sipInsert (@RequestBody SipResDTO SIP) {		
		ResponseEntity<String> entity = null;
		
		int is_sus = svrService.sipInsert(SIP);
		
		if(is_sus == 1) {
			try {
				entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.CREATED, SIP), HttpStatus.OK);
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		} else {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
	}
	
	
	// JSON REST API SIP 수정
	@PutMapping(value = "/sip/{svr_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> sipUpdate (@RequestBody SipResDTO SIP, @PathVariable("svr_num") int svr_num) {		
		ResponseEntity<String> entity = null;
		
		int is_sus = svrService.sipUpdate(SIP,svr_num);
		
		if(is_sus == 1) {
			try {
				entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.UPDATE, SIP), HttpStatus.OK);
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		} else {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	
	// JSON REST API SIP 삭제
	@DeleteMapping(value = "/sip/{svr_num}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<String> sipDelete (@PathVariable("svr_num") int svr_num) {		
		ResponseEntity<String> entity = null;
		
		int is_sus = svrService.sipDelete(svr_num);
		
		if(is_sus == 1) {
			try {
				entity = new ResponseEntity(DefaultRes.res(StatusCode.OK, ResponseMessage.DELETE, is_sus), HttpStatus.OK);
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
		} else {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

		return entity;
	}
	
	// 엑셀
	@GetMapping("/sip/downloadExel")
	public void sipExel(@ModelAttribute SipDTO SIP, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		svrService.sipExel(SIP, response);
	}
	
	// 엑셀
	@GetMapping("/mqtt/downloadExel")
	public void mqttExel(@ModelAttribute MqttDTO MQTT, HttpServletResponse response, HttpServletRequest request) throws Exception{
	
		svrService.mqttExel(MQTT, response);
	}
		
	/* **********  **********  ********** 리스트 **********  **********  **********  */
	@GetMapping(value = {"/listSip.do/{page}/{searchType}/{keyword}",  "/listSip.do/{page}/{searchType}","/listSip.do/{page"}, produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // GET, POST 둘다 지원
	@ResponseBody
	public ResponseEntity<HashMap<String, Object>> listSip(@ModelAttribute SearchCriteria scri,
			@PathVariable("page") int page, @PathVariable(required = false) String searchType, @PathVariable(required = false) String keyword) throws Exception {
	
		// searchType : user_num, user_nm, co_num 번호, 이름, 회사
		ResponseEntity<HashMap<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<SipDTO> list = svrService.listSip(scri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(svrService.listCountSip(scri));
		
		//scri.setSearchType(searchType);
		//scri.setKeyword(keyword);
		//scri.setPage(page);
		
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
		
	
	/* **********  **********  ********** MQTT **********  **********  **********  */
	
	/* **********  **********  ********** 리스트 **********  **********  **********  */
	@GetMapping(value = {"/listMqtt.do/{page}/{searchType}/{keyword}",  "/listMqtt.do/{page}/{searchType}", "/listMqtt.do/{page}"}, produces = MediaType.APPLICATION_JSON_UTF8_VALUE) // GET, POST 둘다 지원
	@ResponseBody
	public ResponseEntity<HashMap<String, Object>> listMqtt(@ModelAttribute SearchCriteria scri,
			@PathVariable("page") int page, @PathVariable(required = false) String searchType, @PathVariable(required = false) String keyword) throws Exception {
	
		// searchType : user_num, user_nm, co_num 번호, 이름, 회사
		ResponseEntity<HashMap<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		
		List<MqttDTO> list = svrService.listMqtt(scri);
		
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(svrService.listCountMqtt(scri));
		
		//scri.setSearchType(searchType);
		//scri.setKeyword(keyword);
		//scri.setPage(page);
		
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
	// insertMqtt.jsp 이동
	@GetMapping(value = "/insertMqttForm")
	public String insertMqttForm() {
		return "server/insertMqtt";
	}

	// listMqtt.jsp MQTT 목록 페이지 이동
	@RequestMapping(value = "/listMqtt.do", method = RequestMethod.GET)
	public String listMqtt() {
		return "server/listMqtt"; // writeBoard.jsp로 이동
	}
	
	// viewMqtt.jsp 이동 MQTT 상세 정보 조회
	@GetMapping(value = "/viewMqtt")
	public String viewMqtt(@RequestParam String mqtt_svr_id) {
		return "server/listMqtt";
	}
	
	// viewMqtt.jsp 이동 MQTT 상세 정보 조회
	@GetMapping(value = "/getViewMqtt/{mqtt_svr_num}")
	@ResponseBody
	public ResponseEntity<MqttDTO> getViewMqtt(@PathVariable("mqtt_svr_num") String mqtt_svr_num) {
		ResponseEntity<MqttDTO> entity = null;
		try {
			entity = new ResponseEntity<>(svrService.viewMqtt(mqtt_svr_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
		//return new ResponseEntity<>(svrService.viewMqtt(mqtt_svr_num), HttpStatus.OK);
	}
}
