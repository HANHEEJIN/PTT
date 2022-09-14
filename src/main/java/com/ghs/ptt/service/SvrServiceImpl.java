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
import com.ghs.ptt.dao.SvrDAO;
import com.ghs.ptt.dto.MqttDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.SipDTO;
import com.ghs.ptt.responseDto.SipResDTO;

@Service
public class SvrServiceImpl implements SvrService {
	
	@Inject
	SvrDAO svrDAO;

	// sip 상세보기
	@Override
	public SipResDTO viewSip(int svr_num) {
		return svrDAO.viewSip(svr_num);
	}
	
	// sip 목록
	@Override
	public List<SipResDTO> getSipList(int svr_num) {
		return svrDAO.getSipList(svr_num);
	}
	
	// sip 추가
	@Override
	public int sipInsert(SipResDTO SIP) {
		return svrDAO.sipInsert(SIP); 
	}
	
	
	// sip 수정
	@Override
	public int sipUpdate(SipResDTO SIP, int svr_num) {
		return svrDAO.sipUpdate(SIP, svr_num);
	}
	
	// sip 삭제
	@Override
	public int sipDelete(int svr_num) {
		return svrDAO.sipDelete(svr_num);
	}
	
	/*
	// sip count
	public int sipCnt(int svr_num) {
		return svrDAO.sipCnt(svr_num); 
	}
	*/
		
	@Override
	public void sipExel(SipDTO SIP, HttpServletResponse response) {
		List<SipDTO> sipList = svrDAO.sipExel(SIP, response);
		
		try {
		
			//Excel Down 시작
			Workbook workbook = new HSSFWorkbook();
			
			//시트생성
			Sheet sheet = workbook.createSheet("SIP목록");
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"번호", "ID", "IP", "PORT", "타입", "RPT_PORT"};
			
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(SipDTO excelData : sipList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getSvr_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getSvr_id());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getSvr_ip());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getSvr_port());
				
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getSvr_type());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getSvr_rpt_start_port());
			}

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("SIP목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void mqttExel(MqttDTO MQTT, HttpServletResponse response) {
		List<MqttDTO> mqttList = svrDAO.mqttExel(MQTT, response);
		
		try {
			//Excel Down 시작
			Workbook workbook = new HSSFWorkbook();
			
			//시트생성
			Sheet sheet = workbook.createSheet("MQTT목록");
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"번호", "ID", "IP", "PORT", "타입"};
			
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(MqttDTO excelData : mqttList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getMqtt_svr_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getMqtt_svr_id());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getMqtt_svr_ip());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getMqtt_svr_port());
				
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getMqtt_svr_type());
			}

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("MQTT목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 목록
	@Override
	public List<SipDTO> listSip(SearchCriteria scri) throws Exception{
		return svrDAO.listSip(scri);
	}
	
	// 데이터 수
	@Override
	public int listCountSip(SearchCriteria scri) throws Exception{
		return svrDAO.listCountSip(scri);
	}
	
	/* --------------------------------- MQTT --------------------------------- */
	
	// Mqtt 목록
	@Override
	public List<MqttDTO> listMqtt(SearchCriteria scri) throws Exception{
		return svrDAO.listMqtt(scri);
	}
	
	// 데이터 수
	@Override
	public int listCountMqtt(SearchCriteria scri) throws Exception{
		return svrDAO.listCountMqtt(scri);
	}


	// Mqtt 상세 보기
	@Override
	public MqttDTO viewMqtt(String mqtt_svr_num) {
		return svrDAO.viewMqtt(mqtt_svr_num);
	}
}
