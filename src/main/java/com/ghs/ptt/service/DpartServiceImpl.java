package com.ghs.ptt.service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import com.ghs.ptt.dao.DpartDAO;
import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.PositionDTO;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.CompanyDTO;

@Service
public class DpartServiceImpl implements DpartService{

	@Inject	DpartDAO dpartDao;

	// 부서 목록
	@Override
	public List<DpartDTO> listDpart() throws Exception{
		return dpartDao.listDpart();
	}
	
	// 부서 상세 보기
	@Override
	public DpartDTO getViewDpart(int dpart_index) {
		return dpartDao.getViewDpart(dpart_index);
	}
	
	// 직책 조회
	@Override
	public List<PositionDTO> getPosiList(int pst_num) {
		return dpartDao.getPosiList(pst_num);
	}
	
	// 부서 상세 보기
	@Override
	public CompanyDTO getViewCompany(int co_index) {
		return dpartDao.getViewCompany(co_index);
	}
	
	// 엑셀
	public void downloadExel(DpartDTO DPART, HttpServletResponse response) throws Exception{
		List<DpartDTO> dpartList = dpartDao.downloadExel(DPART);
		try {
		
			//Excel Down 시작
			Workbook workbook = new HSSFWorkbook();
			
			//시트생성
			Sheet sheet = workbook.createSheet("부서목록");
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"회사", "상위부서", "상위번호", "하위부서", "하위번호"};
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(DpartDTO excelData : dpartList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getCo_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getDpart_nm());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getParent_id());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getDpart_num());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getDpart_index());
			
			}

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("부서목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
