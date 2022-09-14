package com.ghs.ptt.dao;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import com.ghs.ptt.dto.EqpDTO;
import com.ghs.ptt.dto.SearchCriteria;

@Repository
public class EqpDAOImpl implements EqpDAO{
	
	@Inject
	SqlSession SqlSession;


	// 장비 수
	@Override
	public int eqpCount() {
		return SqlSession.selectOne("Eqp.eqpCount");
	}

	// 장비 상세 보기
	@Override
	public EqpDTO viewEqp(int equip_num) {
		return SqlSession.selectOne("Eqp.viewEqp", equip_num);
	}
	
	// 엑셀
	@Override
	public List<EqpDTO> downloadExel(EqpDTO EQP) {
		return SqlSession.selectList("Eqp.downloadExel", EQP);
	}
	
	// 목록
	@Override
	public List<EqpDTO> listEqp(SearchCriteria scri) throws Exception{
		return SqlSession.selectList("Eqp.listEqp", scri);
	}

	// 데이터 수
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		return SqlSession.selectOne("Eqp.listCount", scri);
	}

}
