package com.ghs.ptt.dao;

import java.util.List;

import com.ghs.ptt.dto.TopicDTO;


public interface TopicDAO {
	
	// 직책 조회
	public List<TopicDTO> getTopic(String topic_nm, int topic_num);
		

}
