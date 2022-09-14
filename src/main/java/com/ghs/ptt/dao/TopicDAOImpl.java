package com.ghs.ptt.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.dto.TopicDTO;

@Repository
public class TopicDAOImpl implements TopicDAO{

	@Inject
	SqlSession SqlSession;

	// 직책 조회
	@Override
	public List<TopicDTO> getTopic(String topic_nm, int topic_num) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		// map.put("PAGE", PAGE);
		map.put("topic_nm", topic_nm);
		map.put("topic_num", topic_num);
		
		return SqlSession.selectList("Topic.getTopic", map);
	}
	
}
