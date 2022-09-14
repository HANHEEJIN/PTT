package com.ghs.ptt;

import java.io.File;
import java.io.IOException;

import javax.inject.Inject;

import org.springframework.http.MediaType;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;



public class FileAjaxController {
	/*
	@Inject
	private BoardService boardService;
	private ModelAndView mav = new ModelAndView();
	
	// ajaxTest_file.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "ajaxTest_file", method = RequestMethod.GET)
	public String ajaxTest_file() {

		return "board/ajaxTest_file"; // writeBoard.jsp로 이동
	}

	// produces=MediaType.APPLICATION_JSON_UTF8_VALUE
	@RequestMapping(value = "insertFile", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ModelAndView insertFile(@RequestBody MultipartFile uploadfile) throws IllegalStateException, IOException {

		System.out.println("파일이름 ajax : " + uploadfile.getOriginalFilename());
		System.out.println("파일크기 ajax : " + uploadfile.getSize());
		System.out.println("파일타입 ajax : " + uploadfile.getContentType());

		String saveName = uploadfile.getOriginalFilename();
		String uploadPath = "C:/Users/HAN/git/BOARD/board/src/main/webapp/resources/fileUpload/";

		File target = new File(uploadPath, saveName);

		FileCopyUtils.copy(uploadfile.getBytes(), target);
		mav.setViewName("board/ajaxTest_file");
		mav.addObject(saveName, saveName);
		return mav;
	}

	// ajaxTest.jsp 글쓰기 페이지 이동
	@RequestMapping(value = "ajaxTest", method = RequestMethod.GET)
	public String testBoard() {

		return "board/ajaxTest"; // writeBoard.jsp로 이동
	}

	// 글쓰기 처리
	// produces=MediaType.APPLICATION_JSON_UTF8_VALUE ,consumes =
	// "multipart/form-data
	// , produces = "application/json", consumes = "multipart/form-data"
	// @ModelAttribute
	@RequestMapping(value = "insertBoard2", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE, consumes = "multipart/form-data")
	public void insertBoard2(@ModelAttribute BoardDTO BOARD) throws IllegalStateException, IOException {
		System.out.println("1_CONTROLELR");

		// System.out.println("파일 ajax : " + uploadfile);

		boardService.insertBoard2(BOARD); // SEVICE클래스이름.서비스메소드이름(DTO이름)

		System.out.println("2_CONTROLELR");
		// return "redirect:/board/listBoard.do";
	}
	*/
}
