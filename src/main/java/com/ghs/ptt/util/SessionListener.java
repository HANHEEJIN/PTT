package com.ghs.ptt.util;

import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/* 
 리스너 등록
 1) @WebListener 어노테이션 사용
 2) web.xml 추가
	<web-app ...>
		<listener> <listener-class>com.srctree.session.MySessionManager</listener-class> </listener>
	</web-app>
*/

//@WebListener

//HttpSessionBindingListener의 경우 리스너를 구현한 클래스의 인스턴스를 원하는 시점마다 new 연산자를 통해 직접 생성하고 세션에 바인딩되거나 언바인딩 되는 시점에 메서드를 호출하기에 따로 등록이 필요 없습니다.
public class SessionListener implements HttpSessionBindingListener{
	public static int SESSION_TIME = 20*60;//20분
	
	
	
	private static SessionListener sessionListener = null; 		// 싱글톤 객체를 담을 변수
	private static Hashtable loginUsers = new Hashtable();	// 로그인한 접속자 저장한 해시 테이블
	// Hashtable 1:1 키와 값을 가짐, 동기화, null 불가능, 키 중복x 값 중복 가능
	// 데이터를 해시하여 테이블 내의 주소를 계산하고 데이터를 담음
	
	// 싱글톤 처리(단 하나의 인스턴스를 생성해 사용하는 디자인 패턴)
	public static synchronized SessionListener getInstance() {
		if(sessionListener == null) {
			sessionListener = new SessionListener();
		}
		return sessionListener;    
	}
	
	/*
	1. 세션 연결되었을 때 호출
	2. HttpSessionBindingListener 클래스의 인스턴스가 세션에 attribute로 등록될 때 호출
	   - session.serAttribute(플래그, 값)
	3. 해쉬테이블에 세션과 접속자 아이디를 저장
	*/
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		// session 값을 put
		loginUsers.put(event.getSession(), event.getName());
		System.out.println(event.getName() + "님이 로그인 하셨습니다.");
		System.out.println("현재 접속자 수 : " + getUserCount() );
	}

	/*
	 1. 세션이 끊어질 때 호출
	 2. session.removeAttribute(플래그), session.invalidate()
	 3. Hashtable에 저장된 로그인한 정보를 제거	  
	 */
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		// session 값 찾아서 없애줌
		loginUsers.remove(event.getSession());
		System.out.println("  " + event.getName() + "님이 로그아웃 하셨습니다.");
		System.out.println("현재 접속자 수 : " + getUserCount());
	
	}
	
	// 입력받은 아이디를 해시테이블에서 삭제
	public void removeSession(String id) {		
		System.out.println("========== ========== 제거한 사용자 ========== ============");
		Enumeration e = loginUsers.keys();
		HttpSession session = null;
		while(e.hasMoreElements()){
			session = (HttpSession)e.nextElement();
			if(loginUsers.get(session).equals(id)){
				//세션이 invalidate될때 HttpSessionBindingListener를
				//구현하는 클레스의 valueUnbound()함수가 호출된다.
				System.out.println( " 사용자 제거 : " + session.getId());
				System.out.println( " 사용자 제거 : " + id);
				//session.removeAttribute();
				//session.removeAttribute(id);
				
				session.invalidate();
			}
		}
		System.out.println("========== ========== ========== ============");
	}

	/*
	 * 해당 아이디의 동시 사용을 막기위해서 사용중인 아이디인지를 확인한다.
	 * @param id 사용자 아이디
	 * @return boolean 이미 사용 중인 경우 true, 사용중이 아니면 false
	 */
	public boolean isUsing(String id) {
		System.out.println("========== ========== 중복 로그인 ========== ============");
		System.out.println(id);
		System.out.println(loginUsers.containsValue(id));
		System.out.println("========== ========== ========== ============");
		
		return loginUsers.containsValue(id);
		
		
	}

	// 현재 접속중인 모든 아이디 사용자 출력 return void
	public void printloginUsers() {
		Enumeration e = loginUsers.keys(); 
		HttpSession session = null;
		System.out.println("========== ========== 현재 접속중인 사용자 ========== ============");
		int i = 0;
		while(e.hasMoreElements()){
			session = (HttpSession)e.nextElement();
			System.out.println( (++i) + ". 접속자 : " + loginUsers.get(session));
		}
		System.out.println("========== ========== ========== ============");
	
	}

	// 로그인 완료한 사용자 아이디 세션에 저장하는 메소드
	public void setSession(HttpSession session, String id) {
		System.out.println("========== ========== 로그인 ID ========== ============");
		
		//이순간에 Session Binding이벤트가 일어나는 시점
		//name값으로 userId, value값으로 자기자신(HttpSessionBindingListener를 구현하는 Object)
		session.setAttribute(id, this);//login에 자기자신을 집어넣는다.
		
		System.out.println("ID  : " + id);
		System.out.println("세션 : " + session.getId());
		System.out.println("세션 : " +  this.getInstance() );
		
		System.out.println("========== ========== ========== ============");
		
	}
	
	/* 	* 입력받은 세션Object로 아이디를 리턴한다. 
	 * 	* @param session : 접속한 사용자의 session Object 
	 *  * @return String : 접속자 아이디    */
	public String getUserID(HttpSession session){
		return (String)loginUsers.get(session);
	}

	
	// 현재 접속중인 총 사용자 수, return int
	public int getUserCount() {
		return loginUsers.size(); 
	}
	
	// 현재 접속중인 사용자 리스트 return list
	public Collection getUserlist() {
		Collection collection = loginUsers.values();
		return collection;
	}
	
}
