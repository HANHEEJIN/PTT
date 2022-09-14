package com.ghs.ptt.dto;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class PageMaker {

	private int totalCount;				// 데이터 수
	private int startPage;				// 시작페이지
	private int endPage;				// 끝 페이지
	private boolean prev;				// 이전 false(비활성화), true(활성화)
	private boolean next;				// 다음
	private int displayPageNum = 10;	// 화면에 보여줄 페이지 번호 갯수
	private Criteria cri;				// 페이지 객체
	private int tempEndPage;			// 페이지 총 번호
	
	

	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}

	
	public boolean isPrev() {
		return prev;
	}
	
	public boolean isNext() {
		return next;
	} 

	private void calcData() {
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		startPage = (endPage - displayPageNum) + 1;
		
		//startPage = (((int) (Math.ceil((double)cri.getPage() / displayPageNum))) - 1) * displayPageNum + 1;
		//endPage = (int) (Math.ceil((double)totalCount / cri.getPerPageNum()));
	
		tempEndPage = (int) (Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		
		// 마지막 페이지 번호가 총 페이지 번호보다 클 경우
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		prev = startPage == 1 ? false : true;
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
	}
	
	
	// 파라미터를 조합해 동적으로  url 생성 해줌
	public String makeQuery(int page) {
		UriComponents uriComponents =
		UriComponentsBuilder.newInstance()
						    .queryParam("page", page)
							.queryParam("perPageNum", cri.getPerPageNum())
							.build();
		   
		return uriComponents.toUriString();
	}
	
	public String makeSearch(int page)
	{
	  
	 UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
	            .queryParam("keyword", encoding(((SearchCriteria)cri).getKeyword()))
	            .build(); 
	    return uriComponents.toUriString();  
	}

	private String encoding(String keyword) {
		if(keyword == null || keyword.trim().length() == 0) { 
			return "";
		}
		 
		try {
			return URLEncoder.encode(keyword, "UTF-8");
		} catch(UnsupportedEncodingException e) { 
			return ""; 
		}
	}
}