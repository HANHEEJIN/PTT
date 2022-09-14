package com.ghs.ptt.util.interceptor;

// 사용자 로그인 인증후 전 페이지로 이동

public class AuthInterceptor /* extends HandlerInterceptorAdapter */{

	/*
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
    
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

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession httpSession = request.getSession();

        if (httpSession.getAttribute("login") == null) {
            logger.info("current user is not logged");
            saveDestination(request);
            response.sendRedirect("/user/login");
            return false;
        }

        return true;
    }
    
    @Override
public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    HttpSession httpSession = request.getSession();
    ModelMap modelMap = modelAndView.getModelMap();
    Object userVO =  modelMap.get("user");

    if (userVO != null) {
        logger.info("new login success");
        httpSession.setAttribute(LOGIN, userVO);
        //response.sendRedirect("/");
        Object destination = httpSession.getAttribute("destination");
        response.sendRedirect(destination != null ? (String) destination : "/");
    }
    */
}
