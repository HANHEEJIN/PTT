package com.ghs.ptt.responseDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// Controller와 view사이에서 데이터 주고 받기 위한 용도
// VO를 Back-End 내에서 (비즈니스 로직 등) 매핑처리가 필요한 경우에 반환하여 사용하는 객체


@Data				// getter, setter, toString
@NoArgsConstructor 	// 비어있는 생성자 만듬
@AllArgsConstructor // 생성자, 모든 속성 사용, RequestBody에서는 기본 생성자 필요, setter는 불 필요
@Builder
public class CompanyDTO {

	private int co_index; 	// 회사 번호
	private String co_name;	// 회사 이름
	private String co_num;	// 회사 코드
}
