package com.ghs.ptt.util.Response;

public class ResponseMessage {
	public static final String LOGIN_SUCCESS = "로그인 성공";
	public static final String LOGIN_FAIL = "로그인 실패";
	
	
	public static final String READ = "정보 조회 성공";
	public static final String NOT_FOUND = "정보를 찾을 수 없습니다.";
	public static final String CREATED = "정보 등록 성공";
	public static final String UPDATE = "정보 수정 성공";
	public static final String DELETE = "정보 삭제 성공";
	public static final String INTERNAL_SERVER_ERROR = "서버 내부 에러";
	public static final String DB_ERROR = "데이터베이스 에러";
	
	public static final String ENCODE_SUS = "암호화 성공";
	public static final String ENCODE_FAIL = "암호화 실패";
	public static final String ENCODE_NOT_FOUND = "암호화 정보 조회 실패";
	public static final String ENCODE_READ = "암호화 정보 조회 성공";
}
