package com.ghs.ptt.util;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

// 어노테이션 사용 안할 시에 web.xml 설정
// <listener> <listener-class>패키지경로.SessionConfig</listener-class> </listener>
//@WebListener
public class SessionConfig implements HttpSessionListener {

	// ConcurrentHashMap key, value 값이 null이 허용되지 않는 컬렉션
	// 고유 생성 아이디값, value : HttpSession
	// 로그인 성공시 WebListener에 의해 세션값이 session 에 저장, 로그아웃이나 브라우저 종료시 세션 사라지면 Destroyed에 의해 제거됨
	private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();
	
	//중복로그인 지우기
	public synchronized static String getSessionidCheck(String type, String compareId){
		System.out.println("[1] type : " + type + " compareId : " + compareId);
		String result = "";
		for( String key : sessions.keySet() ){
			HttpSession hs = sessions.get(key);
			if(hs != null &&  hs.getAttribute(type) != null && hs.getAttribute(type).toString().equals(compareId) ){
				result =  key.toString();
			}
		}
		
		System.out.println("[1] result : " + result);
		removeSessionForDoubleLogin(result);
		return result;
	}
	
	private static void removeSessionForDoubleLogin(String userId){    	
		System.out.println("[ 종료 세션 ID ] : " + userId);
		if(userId != null && userId.length() > 0){
			//sessions.get(userId).invalidate();
			sessions.remove(userId);    		
		}
	}
	
	// 세션 생성
	@Override
	public void sessionCreated(HttpSessionEvent se) {
		//System.out.println(se);
		System.out.println("[ 생성 세션 ID ] : " +  se);
		//System.out.println("[ 생성된 SESSION_ID ] : " +  se.getSession().getId());
	    sessions.put(se.getSession().getId(), se.getSession());
	}
	
	// 세션 삭제
	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		if(sessions.get(se.getSession().getId()) != null){
			sessions.get(se.getSession().getId()).invalidate();
			sessions.remove(se.getSession().getId());	
		}
	}
}