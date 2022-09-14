package com.ghs.ptt.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.ghs.ptt.dto.UserDTO;



public class LoginInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	// preHandel이 true이면 controller 실행, flase이면 진행이 멈춤
	 
	// 1. 컨트롤러 시작 전, 매개변수 Object는 핸들러 정보를 의미(RequestMapping, DefaultServletHandler)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		
		HttpSession session = request.getSession();
		
		// String id = request.getParameter("user_id"); id == null
		// System.out.println("[id ]" + id);
		// 미 로그인 시 로그인 페이지 redirect
	
		UserDTO USER = (UserDTO) session.getAttribute("sessionId");
		 
		if (USER == null) {
			
			// 로그인 폼으로 이동
			response.sendRedirect("/");	
			System.out.println("[CONTROLLER 전] 로그인 정보 입력창으로 이동합니다.");
			return false;	// Controller 으로 요청 가지 않도록 false로 지정
		}
		// else if(id != null){ session.removeAttribute(id); // 기존 로그인 정보 지우기}
		
		// 로그인 사용자일 경우 Controller 호출
		return true;
		
		
		
		/*
        // 기존의 로그인 정보 제거
        if (session.getAttribute(LOGIN) == null) {
        	saveDestination(request);
        	response.sendRedirect("/");	
			System.out.println("[CONTROLLER 전] 로그인 정보 입력창으로 이동합니다.");
			return false;
        }

        return true;
        */
		
	}
	
	// 2. 컨트롤러 실행 후 ~ view 호출 전 (contorller의 handler가 끝난후 )
	// Controller에서 exception 발생시, postHandle로 요청이 넘어오지 않음
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav) throws Exception {
		
		 HttpSession session = request.getSession();
		 
		 String id = request.getParameter("user_id");
		 
		 if(session.getAttribute(id) != null) {
			 System.out.println("기존 로그인 정보를 지웁니다.");
			 // session.removeAttribute(id);
			 session.invalidate();
		 }
		
		 
		 /*
		 ModelMap modelMap = mav.getModelMap();
		 Object user =  modelMap.get("user");

		if (user != null) {
		    logger.info("new login success");
		    session.setAttribute(LOGIN, user);
		    response.sendRedirect("/dashBoard");
		    
		    
		    Object destination = session.getAttribute("destination");
	        response.sendRedirect(destination != null ? (String) destination : "/");
		}

		  */
	}
	
	
	// 3. afterCompletion의 경우 Exception이 발생하여도 뷰단은 실행
	@Override /* view 호출 */
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object obj, Exception e) throws Exception {
		 	System.out.println("InterCeptor - afterCompletion");
	}
	
	
	// 페이지 요청 정보 저장
    private void saveDestination(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String query = request.getQueryString();
        if (query == null || query.equals("null")) {
            query = "";
        } else {
            query = "?" + query;
        }

        if (request.getMethod().equals("GET")) {
            logger.info("destination : " + (uri + query));
            request.getSession().setAttribute("destination", uri + query);
        }
    }
}
