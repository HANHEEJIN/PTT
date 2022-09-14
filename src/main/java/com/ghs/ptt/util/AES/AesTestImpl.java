package com.ghs.ptt.util.AES;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ghs.ptt.responseDto.AesResDTO;


@Repository
public class AesTestImpl {

	@Inject SqlSession SqlSession;
	// sip 추가
	public int aesInsert(AesResDTO AES) {
		return SqlSession.insert("Aes.aesInsert", AES);
		//return SqlSession.insert("Svr.sipInsert", SIP); 
	}
	public AesResDTO getAes(int user_no) {
		// TODO Auto-generated method stub
		return SqlSession.selectOne("Aes.getAes", user_no);
	}
		

}
