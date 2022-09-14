package com.ghs.ptt;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sun.tools.sjavac.Log;

@Controller
public class InterceptorTest {
	private Logger logger = LoggerFactory.getLogger(InterceptorTest.class);
	
	@RequestMapping(value="interceptorTest", method = RequestMethod.GET)
	public ModelAndView interceptorTest() throws Exception {
		  
		ModelAndView mv = new ModelAndView();
		logger.debug("인터셉터 테스트");
		System.out.println("인터셉터 테스트");
		
		return mv;
	   

	}
	
	@RequestMapping(value = "/inter", method = RequestMethod.GET)
	public String home() {
		logger.info("Welcome home!");
		System.out.println("후후후");
		return "home";
	}
}
