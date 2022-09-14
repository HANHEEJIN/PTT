package com.ghs.ptt.dao;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.SipDTO;
import com.ghs.ptt.responseDto.SipResDTO;

public interface SvrDAO {

	// sip 상세 보기
	public SipResDTO viewSip(int svr_num);
	
	// sip 목록
	public List<SipResDTO> getSipList(int svr_num);
	
	// sip 추가
	public int sipInsert(SipResDTO SIP);

	// sip 수정
	public int sipUpdate(SipResDTO SIP, int svr_num);
	
	// sip 삭제
	public int sipDelete(int SIP);
		
	/*
	 * 
	// sip count
	public int sipCnt(SipResDTO SIP);
	
	*/
		
	
	
	// 목록
	public List<SipDTO> listSip(SearchCriteria scri) throws Exception;
	
	// 데이터 수
	public int listCountSip(SearchCriteria scri) throws Exception;
	
	/* --------------------------------- MQTT --------------------------------- */
	
	// Mqtt 목록
	public List<MqttDTO> listMqtt(SearchCriteria scri) throws Exception;
	
	// 데이터 수
	public int listCountMqtt(SearchCriteria scri) throws Exception;

	
	// mqtt 목록
	

	// mqtt 상세 보기
	public MqttDTO viewMqtt(String mqtt_svr_num);

	// 엑셀
	public List<SipDTO> sipExel(SipDTO SIP, HttpServletResponse response);
	
	public List<MqttDTO> mqttExel(MqttDTO MQTT, HttpServletResponse response);

	

}
