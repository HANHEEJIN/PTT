package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class SearchDTO {
	private String keyword;		// 검색어
	private String searchType; 	// 검색타입
	
	//검색후 삭제, 등록, 수정, 조회 이후에도 url유지 위해
	//private int page;
	//private int perPageNum
}
