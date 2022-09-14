package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class PageDTO {
	
	private int listCount;	// 전체 게시글 수
	
	// [이전] 1 2 3 4 5 [다음]
	// [이전] startPage ...page... endPagep [다음]
	private int page;		// 현재페이지
	private int maxPage;	// 전체 페이지에서 가장 마지막 페이지
	private int startPage;	// 페이징바 시작 페이지 번호
	private int endPage;	// 페이징바 끝 페이지 번호
	private int startRow;	// 쿼리문 limit 시작 
	private int endRow;		// 쿼리문 limit 끝
	private int numPage;	// 업데이트 화면 글 번호
	
	//@JsonIgnore //Getter에서 사용, 특정 변수를 json 변환에서 제외
	public int getListCount() {
		return listCount;
	}
}