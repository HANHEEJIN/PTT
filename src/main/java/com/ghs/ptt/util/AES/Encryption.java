package com.ghs.ptt.util.AES;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ghs.ptt.responseDto.AesResDTO;
import com.ghs.ptt.util.Response.DefaultRes;
import com.ghs.ptt.util.Response.ResponseMessage;
import com.ghs.ptt.util.Response.StatusCode;


@Controller
@RequestMapping("/aes")
public class Encryption {
	
	
	@Autowired private AesTestImpl aesDao;
	String key = "ghs2022lab000000";					// KEY(16Byte)
	AES128 aes = new AES128(key); 						// AES128클래스 객체 선언(인스턴스화)
	String txt = "ghs";									// 평문
	
	

	
	// produces 읍답 값 형식 지정: json, xml 
		// 1) MediaType.APPLICATION_XML_VALUE
		// 2) MediaType.APPLICATION_JSON_VALUE , consumes="application/json"
		@PostMapping(value = "/encrypt", produces = MediaType.APPLICATION_JSON_VALUE, consumes="application/json")
		@ResponseBody
		public ResponseEntity<String> encrypt (@RequestBody AesResDTO AES) throws Exception {		
			ResponseEntity<String> entity = null;
			
			System.out.println("[  평문 암호 ]  " + AES.getUser_pw());
			
			String enc = aes.encrypt(AES.getUser_pw());		// 암호화
			


			AES.setUser_pw(enc);
			
			//System.out.println("[ 암호화된 암호 ] ... " + AES);
			
			int is_sus = aesDao.aesInsert(AES);
			
			if(is_sus == 1) {
				try {
					entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_SUS, ResponseMessage.ENCODE_SUS, AES), HttpStatus.OK);
					System.out.println("[암호화된 암호] " + AES.getUser_pw());
				} catch (Exception e){
					e.printStackTrace();
					entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_FAIL, ResponseMessage.ENCODE_FAIL, AES), HttpStatus.BAD_REQUEST);
				}
			} else {
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
			return entity;
		}
		
		// JSON ->  데이터 확인 시, /getAes/{user_no}.json
		@GetMapping(value = "/decrypt/{textDec}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody // json ->문자열 객체로 변환
		public ResponseEntity<String> decrypt(@PathVariable("textDec") String textDec) {
			
			ResponseEntity<String> entity = null;
			String dec = aes.decrypt(textDec);
			
			if(dec != null) {
				try {	
					entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_SUS, ResponseMessage.ENCODE_SUS, dec), HttpStatus.OK);
					
				} catch (Exception e){
					e.printStackTrace();
					entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_FAIL, ResponseMessage.ENCODE_FAIL, dec), HttpStatus.BAD_REQUEST);
				
				}
			}
			
			return entity;
			//return new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
		}
		
		// JSON ->  데이터 확인 시, /getAes/{user_no}.json
		@GetMapping(value = "/getAes/{user_no}")
		@ResponseBody // json ->문자열 객체로 변환
		public ResponseEntity<AesResDTO> getAes(@PathVariable("user_no") int user_no) {
			
			ResponseEntity<AesResDTO> entity = null;
			try {
				//String mySqDEnc = aes.MySQLDecrypt(AES.getUser_pw(), key);	// 복호화
				AesResDTO is_sus = aesDao.getAes(user_no);
				String pw = is_sus.getUser_pw();
				String pwEnc = aes.MySQLDecrypt(pw, key);
				is_sus.setUser_pw(pwEnc);
				
				entity = new ResponseEntity<>(is_sus, HttpStatus.OK);
				
	
				System.out.println("[복호화된 암호] " + pwEnc);
				
			} catch (Exception e){
				e.printStackTrace();
				entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			}
			
			return entity;
			//return new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
		}
		
		/*
		// produces 읍답 값 형식 지정: json, xml 
				// 1) MediaType.APPLICATION_XML_VALUE
				// 2) MediaType.APPLICATION_JSON_VALUE , consumes="application/json"
				@PostMapping(value = "/new", produces = MediaType.APPLICATION_JSON_VALUE, consumes="application/json")
				@ResponseBody
				public ResponseEntity<String> aesInsert (@RequestBody AesResDTO AES) throws Exception {		
					ResponseEntity<String> entity = null;
					
					System.out.println("[  평문 암호 ]  " + AES.getUser_pw());
					
					String mySqlEnc = aes.MySQLEncrypt(AES.getUser_pw(), key);		// 암호화
					


					AES.setUser_pw(mySqlEnc);
					
					//System.out.println("[ 암호화된 암호 ] ... " + AES);
					
					int is_sus = aesDao.aesInsert(AES);
					
					if(is_sus == 1) {
						try {
							entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_SUS, ResponseMessage.ENCODE_SUS, AES), HttpStatus.OK);
							System.out.println("[암호화된 암호] " + AES.getUser_pw());
						} catch (Exception e){
							e.printStackTrace();
							entity = new ResponseEntity(DefaultRes.res(StatusCode.ENCODE_FAIL, ResponseMessage.ENCODE_FAIL, AES), HttpStatus.BAD_REQUEST);
						}
					} else {
						entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
					}
					return entity;
				}
				
				
				// JSON ->  데이터 확인 시, /getAes/{user_no}.json
				@GetMapping(value = "/getAes/{user_no}")
				@ResponseBody // json ->문자열 객체로 변환
				public ResponseEntity<AesResDTO> getAes(@PathVariable("user_no") int user_no) {
					
					ResponseEntity<AesResDTO> entity = null;
					try {
						//String mySqDEnc = aes.MySQLDecrypt(AES.getUser_pw(), key);	// 복호화
						AesResDTO is_sus = aesDao.getAes(user_no);
						String pw = is_sus.getUser_pw();
						String pwEnc = aes.MySQLDecrypt(pw, key);
						is_sus.setUser_pw(pwEnc);
						
						entity = new ResponseEntity<>(is_sus, HttpStatus.OK);
						
			
						System.out.println("[복호화된 암호] " + pwEnc);
						
					} catch (Exception e){
						e.printStackTrace();
						entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
					}
					
					return entity;
					//return new ResponseEntity<>(svrService.viewSip(svr_num), HttpStatus.OK);
				}
		
  
	/*
	public static void main(String[] args) throws Exception{
      
		String key = "ghs2022lab000000";		// KEY(16Byte)
		AES128 aes = new AES128(key); 			// AES128클래스 객체 선언(인스턴스화)
		String txt = "ghs";						// 평문
		String encrypt = aes.encrypt(txt);		// 인코딩(암호화)
		String decrypt = aes.decrypt(encrypt);  // 디코딩(복호화)
		
		System.out.println("********** ********** Java 암 복호와 ********** **********");
		System.out.println("평문 : " + txt);
		System.out.println("암호화 : " + encrypt);
		System.out.println("복호화 : " + decrypt);
		
		
		
		
		
		String mySqlEnc = aes.MySQLEncrypt(txt, key);
		String mySqDEnc = aes.MySQLDecrypt(mySqlEnc, key);

		System.out.println("********** ********** Mysql 암 복호와 ********** **********");
		System.out.println("평문 : " + txt);
		System.out.println("암호화 : " + mySqlEnc);
		System.out.println("복호화 : " + mySqDEnc);
  	
  } */
}
