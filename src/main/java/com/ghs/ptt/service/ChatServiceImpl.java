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

import com.ghs.ptt.dao.ChatDAO;
import com.ghs.ptt.dto.ChatDTO;
import com.ghs.ptt.dto.ChatUserDTO;
import com.ghs.ptt.dto.MsgDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.ResponseDTO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Inject
	ChatDAO chatDao;

	// 목록
	public List<ChatDTO> listChat(SearchCriteria scri) throws Exception {
		return chatDao.listChat(scri);
	}

	// 데이터 수
	public int listCount(SearchCriteria scri) throws Exception{
		return chatDao.listCount(scri);
	}

	// 채팅방 상세 보기
	@Override
	public ChatDTO viewChat(int chat_room_num) {
		return chatDao.viewChat(chat_room_num);
	}
	
	@Override
	public List<MsgDTO> getMsg(int chat_room_num){
		//메세지 수
		int msgCnt = chatDao.msgCount();
		return chatDao.getMsg(chat_room_num);
	}

	
	// 대화 참여자 정보
	@Override
	public List<ChatUserDTO> getChatUser(int chat_room_num){
		// 대화자 수
		int cuserCnt = chatDao.cuserCount();
		return chatDao.getChatUser(chat_room_num);
	}
	
	@Override
	public List<UserDTO> findUserInfo(int user_num){
		return chatDao.findUserInfo(user_num);
	}
	
	// 엑셀
	@Override
	public void downloadExel(ChatDTO CHAT, HttpServletResponse response) {
		List<ChatDTO> chatList = chatDao.downloadExel(CHAT);

		try {
		
			//Excel Down 시작
			Workbook workbook = new HSSFWorkbook();
			
			//시트생성
			Sheet sheet = workbook.createSheet("채팅방목록");
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"방번호", "방이름", "접속번호"};
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(ChatDTO excelData : chatList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getChat_room_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getChat_room_nm());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getChat_room_conn_num());			
			}

						

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("채팅방목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	
}
