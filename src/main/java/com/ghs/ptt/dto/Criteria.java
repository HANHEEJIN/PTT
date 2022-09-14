package com.ghs.ptt.dto;

public class Criteria {
	
	private int page;		// 현재페이지
	private int perPageNum;	// 한 페이지에 보여줄 게시글 갯수
	private int rowStart;	// 데이터 베이스 limit start
	private int rowEnd;		// 데이터 베이스 limit end
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}
	
	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	public int getRowStart() {
		//rowStart = ((page - 1) * perPageNum) + 1;
		 if(page == 1) { rowStart = 0; } else { rowStart = (page-1) * 10; }
		
		return rowStart;
	}
	
	public int getRowEnd() {
		//rowEnd = rowStart + perPageNum - 1;
		rowEnd = 10;
		return rowEnd;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	
	
}