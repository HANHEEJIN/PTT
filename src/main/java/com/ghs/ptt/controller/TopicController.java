package com.ghs.ptt.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ghs.ptt.dto.TopicDTO;
import com.ghs.ptt.service.TopicService;


@Controller
@RequestMapping("/topic")
public class TopicController {

	
	@Inject private TopicService topicService;


	
	/* **********  **********  ********** 토픽 JSON **********  **********  **********  */
	
	// viewDpart.jsp 이동
	@GetMapping(value = "/getTopic/{topic_nm}/num/{topic_num}")
	@ResponseBody
	public ResponseEntity<List<TopicDTO>> getTopic(@PathVariable("topic_num") int topic_num, @PathVariable("topic_nm") String topic_nm) {
		ResponseEntity<List<TopicDTO>> entity = null;
		try {
			entity = new ResponseEntity<>(topicService.getTopic(topic_nm, topic_num), HttpStatus.OK);
		} catch (Exception e){
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
}
