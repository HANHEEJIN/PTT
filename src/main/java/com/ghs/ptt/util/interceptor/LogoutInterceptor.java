package com.ghs.ptt.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 로그인 상태에서 로그인 페이지 접근 막기

public class LogoutInterceptor extends HandlerInterceptorAdapter  {

	
	private static final Logger logger = LoggerFactory.getLogger(LogoutInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	//System.out.println("[CONTROLLER 전] 로그인 후");
        // 로그인 처리후 로그인페이지 or 회원가입 페이지로 이동할 경우
        HttpSession session = request.getSession();
        if (session.getAttribute("sessionId") == null) {
        	System.out.println("[CONTROLLER 전] 로그아웃 후에는 다른 페이지로 이동할 수 없습니다.");
        	response.sendRedirect("/");
            return false;
        } else {
        	System.out.println("[CONTROLLER 전] 로그아웃되어있습니다.");
        	//response.sendRedirect("/");
        }
        return true;
    }
    
    @Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav) throws Exception {
    	logger.info("post handle 로그인 후..."); 

		 
		 
	}
    
}
