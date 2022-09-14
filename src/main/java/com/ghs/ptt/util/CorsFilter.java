package com.ghs.ptt.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;


//@Component
/*
public class CorsFilter implements Filter {
	
	private Logger logger = LoggerFactory.getLogger(CorsFilter.class);
	
	  @Override
	  public void init(FilterConfig filterConfig) throws ServletException {

	  }

	  @Override
	    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		  
		  
	        HttpServletRequest request = (HttpServletRequest) req;
	        HttpServletResponse response = (HttpServletResponse) res;

//	        response.setHeader("Access-Control-Allow-Origin", "*");	//허용할 Origin(요청 url) *은 모두 허용
//	        response.addHeader("Access-Control-Allow-Origin", "");	//허용할 Origin(요청 url) *은 모두 허용
	        //response.addHeader("Access-Control-Allow-Origin", "*");	//허용할 Origin(요청 url) *은 모두 허용
	        //response.addHeader("Access-Control-Allow-Origin", "*");	//허용할 Origin(요청 url) *은 모두 허용
//	        response.setHeader("Access-Control-Allow-Credentials", "true");		//
//	        response.setHeader("Access-Control-Allow-Methods","GET, OPTIONS, HEAD, PUT, POST");	//허용할 request  http METHOD : POST, GET, DELETE, PUT
//	        response.setHeader("Access-Control-Max-Age", "3600");	// 브라우저 캐시 시간(단위:초) : "3600"시간, 최소 1시간 안에는 서버로 재 요청
//	        response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization"); // 요청 허용 헤더 (AJAX:X-Requested-With)

	        chain.doFilter(req, res);
	    }

	    @Override
	    public void destroy() {

	    }

}
*/