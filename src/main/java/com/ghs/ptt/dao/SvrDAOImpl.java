package com.ghs.ptt.dao;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.SipDTO;
import com.ghs.ptt.responseDto.SipResDTO;

@Repository
public class SvrDAOImpl implements SvrDAO {
	
	@Inject SqlSession SqlSession;

	// sip 상세 보기
	@Override
	public SipResDTO viewSip(int svr_num) {
		return SqlSession.selectOne("Svr.viewSip", svr_num);
	}
	
	// sip 목록
	@Override
	public List<SipResDTO> getSipList(int svr_num) {
		return SqlSession.selectList("Svr.getSipList", svr_num);
	}
	
	// sip 추가
	@Override
	public int sipInsert(SipResDTO SIP) {
		return SqlSession.insert("Svr.sipInsert", SIP);
		//return SqlSession.insert("Svr.sipInsert", SIP); 
	}
	
	// sip 수정
	@Override
	public int sipUpdate(SipResDTO SIP, int svr_num) {
		int sql =SqlSession.update("Svr.sipUpdate", SIP);
		return sql;
	}
		
	
	// sip 삭제
	@Override
	public int sipDelete(int svr_num) {
		return SqlSession.delete("Svr.sipDelete", svr_num);
	}
		
	
	// sip count
	/*
	public int sipCnt(int svr_num) {
		return SqlSession.sipCnt(svr_num); 
	}

	
	*/
	// 엑셀
	@Override
	public List<SipDTO> sipExel(SipDTO SIP, HttpServletResponse response) {
		return SqlSession.selectList("Svr.sipExel", SIP);

	}
	
	@Override
	public List<MqttDTO> mqttExel(MqttDTO MQTT, HttpServletResponse response) {
		return SqlSession.selectList("Svr.mqttExel", MQTT);

	}
	
	
	// 목록
	@Override
	public List<SipDTO> listSip(SearchCriteria scri) throws Exception{
		return SqlSession.selectList("Svr.listSip", scri);
	}
	
	// 데이터 수
	@Override
	public int listCountSip(SearchCriteria scri) throws Exception{
		return SqlSession.selectOne("Svr.listCountSip", scri);
	}
	
	/* --------------------------------- MQTT --------------------------------- */
	
	// Mqtt 목록
	@Override
	public List<MqttDTO> listMqtt(SearchCriteria scri) throws Exception{
		return SqlSession.selectList("Svr.listMqtt", scri);
	}
	
	// 데이터 수
	@Override
	public int listCountMqtt(SearchCriteria scri) throws Exception{
		return  SqlSession.selectOne("Svr.listCountMqtt", scri);
	}
	
	// mqtt 상세 보기
	@Override
	public MqttDTO viewMqtt(String mqtt_svr_num) {
		return SqlSession.selectOne("Svr.viewMqtt", mqtt_svr_num);
	}


}
