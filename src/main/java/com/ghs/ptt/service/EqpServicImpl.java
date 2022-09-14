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

import com.ghs.ptt.dao.EqpDAO;
import com.ghs.ptt.dto.DpartDTO;
import com.ghs.ptt.dto.EqpDTO;
import com.ghs.ptt.dto.PageDTO;
import com.ghs.ptt.dto.SearchCriteria;

@Service
public class EqpServicImpl implements EqpService {
	@Inject
	EqpDAO eqpDao;
	
	// 목록
	@Override
	public List<EqpDTO> listEqp(SearchCriteria scri) throws Exception{
		return eqpDao.listEqp(scri);
	}
	
	// 데이터 수
	@Override
	public int listCount(SearchCriteria scri) throws Exception{
		return eqpDao.listCount(scri);
	}

	// 장비 상세
	@Override
	public EqpDTO viewEqp(int equip_num) {
		return eqpDao.viewEqp(equip_num);
	}
	
	// 엑셀
	@Override
	public void downloadExel(EqpDTO EQP, HttpServletResponse response) {
		List<EqpDTO> eqpList = eqpDao.downloadExel(EQP);
		try {
		
			//Excel Down 시작
			Workbook workbook = new HSSFWorkbook();
			
			//시트생성
			Sheet sheet = workbook.createSheet("장비목록");
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"번호", "ID", "이름", "타입", "회사"};
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(EqpDTO excelData : eqpList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getEquip_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getEqp_id());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getEqp_nm());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getEqp_typ());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getCo_num());
			
			}

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("장비목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
		
}
