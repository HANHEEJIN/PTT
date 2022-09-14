package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class EqpDTO {
	private int equip_num; 		// 장비 번호;
	private String eqp_id; 		// 장비 아이디;
	private String eqp_nm; 		// 장비 이름;
	private String eqp_typ;		// 장비 유형;
	private String co_num; 		// 장비 부서코드;
	private String editor; 		// 장비 작성자;
	private String crt_ymdt; 	// 장비 생성_일시;
	private String mdfy_ymdt; 	// 장비 수정_일시;
	private int rnum;

}
