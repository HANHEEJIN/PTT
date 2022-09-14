package com.ghs.ptt.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.SipDTO;
import com.ghs.ptt.responseDto.SipResDTO;

public interface SvrService {

	// sip 상세보기
	public SipResDTO viewSip(int svr_num);
	
	// sip 목록
	public List<SipResDTO> getSipList(int svr_num);
	
	// sip 추가
	public int sipInsert(SipResDTO SIP);
	
	
	// sip count
	//public int sipCnt(SipResDTO SIP);

	
	// sip 수정
	public int sipUpdate(SipResDTO SIP, int svr_num);
	
	// sip 삭제
	public int sipDelete(int svr_num);
		
	// 엑셀
	public void sipExel(SipDTO SIP, HttpServletResponse response);
	
	// 목록
	public List<SipDTO> listSip(SearchCriteria scri) throws Exception;

	// 데이터 수
	public int listCountSip(SearchCriteria scri) throws Exception;
	
	/* --------------------------------- MQTT --------------------------------- */

	// Mqtt 목록
	public List<MqttDTO> listMqtt(SearchCriteria scri) throws Exception;

	// 데이터 수
	public int listCountMqtt(SearchCriteria scri) throws Exception;

	// Mqtt 상세 보기
	public MqttDTO viewMqtt(String mqtt_svr_num);

	// 엑셀
	public void mqttExel(MqttDTO MQTT, HttpServletResponse response);

	

	

	

	

}
