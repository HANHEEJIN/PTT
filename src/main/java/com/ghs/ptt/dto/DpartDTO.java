package com.ghs.ptt.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor 
public class DpartDTO {
	
	// 기존  DpartDTO DPART
	// 		DpartDTO.Dpart topDTO

	private String co_num;			// 부서 회사명
	private String dpart_num; 		// 부서 번호;
	private String dpart_nm; 		// 부서 이름;
	private String dpart_typ; 		// 부서 유형;
	private String uppr_dpart_num;	// 부서 상위부서;
	
	private String editor; 			// 부서 작성자;
	private String crt_ymdt; 		// 부서 생성_일시;
	private String mdfy_ymdt; 		// 부서 수정_일시;
	private int dpart_index;		// 부서 번호
	private int parent_id;			// 부서 상위 번호 매핑

	

}
