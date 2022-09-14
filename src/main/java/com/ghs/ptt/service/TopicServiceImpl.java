package com.ghs.ptt.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ghs.ptt.dao.TopicDAO;
import com.ghs.ptt.dto.TopicDTO;

@Service
public class TopicServiceImpl implements TopicService{

	@Inject private TopicDAO topicDao;
	
	// 직책 조회
	@Override
	public List<TopicDTO> getTopic(String topic_nm, int topic_num) {
		return topicDao.getTopic(topic_nm, topic_num);
	}
}
