package com.ghs.ptt.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.responseDto.CompanyDTO;

@Repository
public class DpartDAOImpl implements DpartDAO{

	@Inject
	SqlSession SqlSession;
	

	// 부서 목록
	@Override
	public List<DpartDTO> listDpart() throws Exception{
		return SqlSession.selectList("Dpart.listDpart");
	}
	
	
	// 부서 수
	@Override
	public int dpartCount() {
		return SqlSession.selectOne("Dpart.dpartCount");
	}
	
	// 부서 상세 보기
	@Override
	public DpartDTO getViewDpart(int dpart_index) {
		return SqlSession.selectOne("Dpart.getViewDpart", dpart_index);
	}
	
	// 직책 조회
	@Override
	public List<PositionDTO> getPosiList(int pst_num) {
		return SqlSession.selectList("Dpart.getPosiList", pst_num);
	}
	
	// 회사 상세 보기
	public CompanyDTO getViewCompany(int co_index) {
		return SqlSession.selectOne("Dpart.getViewCompany", co_index);
	}
		
	// 엑셀
	@Override
	public List<DpartDTO> downloadExel(DpartDTO DPART) {
		return SqlSession.selectList("Dpart.downloadExel", DPART);
	}
	
}
