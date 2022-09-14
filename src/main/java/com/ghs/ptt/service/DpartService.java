package com.ghs.ptt.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.CompanyDTO;

public interface DpartService  {

	// 부서 목록
	//public List<DpartDTO> listDpart() throws Exception;

	// 부서 상세
	public DpartDTO getViewDpart(int dpart_index);

	// 직책 조회
	public List<PositionDTO> getPosiList(int pst_num);

	// 회사 상세
	public CompanyDTO getViewCompany(int co_index);


	// 엑셀
	public void downloadExel(DpartDTO DPART, HttpServletResponse response) throws Exception;

	public List<DpartDTO> listDpart() throws Exception;

	//public List<DpartDTO> getListDpart() throws Exception;

}
