package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class PositionDTO {
	private int pst_num;	// 직책 번호
	private String pst;		// 직책 명
}
