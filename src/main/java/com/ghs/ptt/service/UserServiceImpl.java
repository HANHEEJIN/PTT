package com.ghs.ptt.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ghs.ptt.dao.UserDAO;
import com.ghs.ptt.dto.LoginDTO;
import com.ghs.ptt.dto.SearchCriteria;
import com.ghs.ptt.dto.UserDTO;
import com.ghs.ptt.responseDto.UserResDTO;

@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDAO userDao;
	UserDTO USER;
	
	@Autowired
	HttpSession session;
	HttpServletRequest request;
	
	// 아이디 중복
	@Override
	public int insertIdCheck(Map<String, String> params) throws Exception{
		int idCheck = userDao.insertIdCheck(params);
		return idCheck;
	}
	

	// 사용자 상세 보기
	@Override
	public UserResDTO getViewUser(int user_num)throws Exception {
		return userDao.getViewUser(user_num);
	}
	
	// 사용자 로그인
	@Override
	public UserDTO login(UserDTO USER) throws Exception{
		return userDao.login(USER);
		
		
		//return LoginDTO login = userDao.login(LOGIN);
		
		/* Controller
		if(login != null) {
			//세션 변수 등록 session.setAttribute("설정한 세션 아이디", 세션에 넣을 값);
			session.setAttribute("LOGIN", login);
			//session.setAttribute("USER_LELVEL", USER.getUser_id());
		} 
		*/
		
		//System.out.println("[SERVICE SESSION ID]... " + session.getAttribute("LOGIN_ID"));

		// return login;
	}

	// 사용자 로그아웃
	/*
	@Override
	public void logOut() throws Exception{
		//session.removeAttribute(login); //세션값 삭제
		session.invalidate();	//세션 전체 제고, 무효화
	}
	*/
	
	// 사용자 레벨 구분
	public String userLvl() {
		return userDao.userLvl();
	}
	

	
	// e164 조회
	@Override
	public UserDTO getE164(UserDTO USER) throws Exception {
		return userDao.getE164(USER);
	}
	
	@Override
	public void downloadExel(UserDTO USER, HttpServletResponse response) throws Exception {
		List<UserDTO> userList = userDao.downloadExel(USER);
		try {
			Workbook workbook = new HSSFWorkbook();			//Excel Down 시작			
			Sheet sheet = workbook.createSheet("사용자목록");	//시트생성
			
			//행, 열, 열번호
			Row row = null;
			Cell cell = null;
			int rowNo = 0;	// 0번째 행
			
			
			// 헤더명 설정( 행 이름 설정)
			String[] headerArray = {"NO", "이름","ID","LVL", "회사", "상위부서", "하위부서", "E164", "SIP", "MQTT"};
			row = sheet.createRow(rowNo++); //0번째 행부터 1씩 증가
			for(int i=0; i<headerArray.length; i++) {
				cell = row.createCell(i); //행번호 0부터
				cell.setCellValue(headerArray[i]); // 행 이름 차례대로 순서 출력
			}
				      
			// 받아온 데이터 LIST 크기 만큼 출력
			for(UserDTO excelData : userList ) {
				row = sheet.createRow(rowNo++); // 1번째 행부터 출력
				int cellCount=0; //열 번호 초기화
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getUser_num());
				
				cell = row.createCell(cellCount++); //cellCount 대신 숫자로 지정 가능 
				cell.setCellValue(excelData.getUser_nm());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getUser_id());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getUser_lvl());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getCo_num());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getDpart_num());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getUser_pst());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getE164_no());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getSip_svr_id());
			
				cell = row.createCell(cellCount++); 
				cell.setCellValue(excelData.getMqtt_svr_id());
			
			}

			// 컨텐츠 타입과 파일명 지정
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("사용자목록.xls", "UTF8"));

			
			// 엑셀 출력
			workbook.write(response.getOutputStream());
			workbook.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 엑셀 업로드
	/*
	public List<UserDTO> insertExcel(MultipartFile excelFile) throws Exception{
		List<UserDTO> list = new ArrayList<UserDTO>();
        try {
            OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream());
            XSSFWorkbook workbook = new XSSFWorkbook(opcPackage);
            
            // 첫번째 시트 불러오기
            XSSFSheet sheet = workbook.getSheetAt(0);
            
            for(int i=1; i<sheet.getLastRowNum() + 1; i++) {
            	UserDTO USER = new UserDTO();
                XSSFRow row = sheet.getRow(i);
                
                // 행이 존재하기 않으면 패스
                if(null == row) { continue; }
                
                // 행의 1번째 열(아이디) 
                XSSFCell cell = row.getCell(0);
                
                if(null != cell)
                USER.setUser_id(cell.getStringCellValue());
                // 행의 2번째 열(이름)
                cell = row.getCell(1);
                if(null != cell) 
                	USER.setUser_name(cell.getStringCellValue());
                // 행의 3번째 열(사용 만료일)
                cell = row.getCell(2);
                if(null != cell) 
                	USER.setExpire(cell.getStringCellValue());
                // 행의 4번째 열(부서명)
                cell = row.getCell(3);
                if(null != cell) 
                	USER.setDeptname(cell.getStringCellValue());
                // 행의 5번째 열(휴대전화 번호)
                cell = row.getCell(4);
                if(null != cell) 
                	USER.setPhone(cell.getStringCellValue());
                // 행의 6번째 열(이메일)
                cell = row.getCell(5);
                if(null != cell) 
                	USER.setEmail(cell.getStringCellValue());
                // 행의 7번째 열(설명)
                cell = row.getCell(6);
                if(null != cell) 
                	USER.setDesc(cell.getStringCellValue());
                // 행의 8번째 열(사무실 코드)
                cell = row.getCell(7);
                if(null != cell) 
                	USER.setOffice_code(cell.getStringCellValue());

                list.add(USER);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
	}
	*/

	
	public int listCount(SearchCriteria scri) throws Exception{
		//int userCnt = userDao.listUserCount(); // 사용자수 
		return userDao.listCount(scri);
	}

	public List<UserDTO> listUser(SearchCriteria scri)throws Exception{
		return userDao.listUser(scri);
	}


}
