package com.ghs.ptt.service;

import java.util.List;

import com.ghs.ptt.dto.TopicDTO;

public interface TopicService  {

	// TOPIC 조회
	public List<TopicDTO> getTopic(String topic_nm, int topic_num);
}
