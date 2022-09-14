package com.ghs.ptt.dao;

import java.util.List;

import com.ghs.ptt.dto.EqpDTO;
import com.ghs.ptt.dto.SearchCriteria;

public interface EqpDAO {


	// 장비 수
	public int eqpCount();

	// 장비 상세 보기
	public EqpDTO viewEqp(int equip_num);

	public List<EqpDTO> downloadExel(EqpDTO EQP);
	

	public List<EqpDTO> listEqp(SearchCriteria scri) throws Exception;

	public int listCount(SearchCriteria scri) throws Exception;

}
