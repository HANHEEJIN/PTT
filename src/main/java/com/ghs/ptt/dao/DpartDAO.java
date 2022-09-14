package com.ghs.ptt.dao;

import java.util.List;

import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.CompanyDTO;


public interface DpartDAO {

	// 부서 출력
	public List<DpartDTO> listDpart() throws Exception;

	// 부서 수
	public int dpartCount();

	// 부서 상세 보기
	public DpartDTO getViewDpart(int dpart_index);
	
	// 직책 조회
	public List<PositionDTO> getPosiList(int pst_num);

	// 회사 상세 보기
	public CompanyDTO getViewCompany(int co_index);

	// 엑셀
	public List<DpartDTO> downloadExel(DpartDTO DPART);
		

}
