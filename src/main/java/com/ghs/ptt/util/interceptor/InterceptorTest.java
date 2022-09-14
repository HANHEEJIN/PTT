package com.ghs.ptt.util.interceptor;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class InterceptorTest {
	
	private static final Logger logger = LoggerFactory.getLogger(InterceptorTest.class);
	@RequestMapping(value="/interceptorTest", method = RequestMethod.GET)
	public ModelAndView interceptorTest() throws Exception {
		  
		ModelAndView mv = new ModelAndView();
		logger.info("인터셉터 테스트");
		System.out.println("인터셉터 테스트");
		
		return mv;
	   

	}
}
