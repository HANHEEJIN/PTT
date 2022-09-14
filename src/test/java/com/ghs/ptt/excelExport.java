package com.ghs.ptt;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class excelExport {

	@GetMapping("/downloadExel1")
	public void downloadExel(HttpServletResponse response) throws IOException {
		// 엑셀에 들어갈 데이터 생성
		collegeStudent[] list = {
				new collegeStudent(2022032401L,"김학생",2,"M","경영학"),
				new collegeStudent(2022032402L,"이학생",1,"F","컴퓨터공학"),
				new collegeStudent(2022032403L,"박학생",2,"M","통계학"),
				new collegeStudent(2022032404L,"최학생",1,"F","식품영양학"),
				new collegeStudent(2022032405L,"정학생",1,"M","영화예술학"),
				new collegeStudent(2022032406L,"강학생",4,"M","디자인학"),
				new collegeStudent(2022032407L,"조학생",1,"F","심리학"),
				new collegeStudent(2022032408L,"윤학생",1,"F","경제학"),
				new collegeStudent(2022032409L,"장학생",3,"M","체육학"),
				new collegeStudent(2022032410L,"임학생",2,"M","화학"),
				new collegeStudent(2022032411L,"한학생",1,"M","기계공학"),
				new collegeStudent(2022032412L,"오학생",4,"F","의예"),
				new collegeStudent(2022032413L,"서학생",1,"F","조경학"),
				new collegeStudent(2022032414L,"신학생",1,"M","수학"),
				new collegeStudent(2022032415L,"권학생",3,"M","물리"),
				new collegeStudent(2022032416L,"황학생",2,"M","미술"),
				new collegeStudent(2022032417L,"안학생",3,"M","제약"),
				new collegeStudent(2022032418L,"송학생",4,"F","철학"),
				new collegeStudent(2022032419L,"전학생",2,"M","의상학"),
				new collegeStudent(2022032420L,"홍학생",1,"M","반도체")
		};
		
		Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("학생부 명단");
        int rowNo = 0;
 
        Row headerRow = sheet.createRow(rowNo++);
        headerRow.createCell(0).setCellValue("학번");
        headerRow.createCell(1).setCellValue("이름");
        headerRow.createCell(2).setCellValue("학년");
        headerRow.createCell(3).setCellValue("성별");
        headerRow.createCell(4).setCellValue("전공");
        
        
        
        
        for (collegeStudent s : list) {
            Row row = sheet.createRow(rowNo++);
            row.createCell(0).setCellValue(s.getStudentId());
            row.createCell(1).setCellValue(s.getName());
            row.createCell(2).setCellValue(s.getGrade());
            row.createCell(3).setCellValue(s.getGender());
            row.createCell(4).setCellValue(s.getMajor());
        }
        
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=studentList.xls");
        
        workbook.write(response.getOutputStream());
        workbook.close();
        
	}
}

class collegeStudent {
	Long studentId;
	String name;
	int grade;
	String gender;
	String major;
	
	public collegeStudent(Long studentId, String name,int grade,String gender,String major){
		this.studentId = studentId;
		this.name      = name;
		this.grade     = grade;
		this.gender	   = gender;
		this.major	   = major;
	}
	
	@Override
	public String toString() {
		return "student [studentId=" + studentId + ", name=" + name + ", grade=" + grade + ", gender=" + gender
				+ ", major=" + major + "]";
	}

	public Long getStudentId() {
		return studentId;
	}
	public void setStudentId(Long studentId) {
		this.studentId = studentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
}