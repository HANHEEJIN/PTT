package com.ghs.ptt.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.EqpDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.SearchCriteria;

public interface EqpService {

	// 장비 목록
	//public List<EqpDTO> listEqp(PageDTO PAGE);

	// 장비 상세
	public EqpDTO viewEqp(int equip_num);

	// 엑셀
	public void downloadExel(EqpDTO EQP, HttpServletResponse response);

	// 목록
	public List<EqpDTO> listEqp(SearchCriteria scri) throws Exception;

	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception;

}
