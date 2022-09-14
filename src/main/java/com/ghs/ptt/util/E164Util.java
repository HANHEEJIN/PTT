 package com.ghs.ptt.util;

import org.springframework.stereotype.Component;



@Component("E164Util")
public class E164Util {
	
	public String getE164Util(int num)  {

		// E164 총 11자리
		String baseSeq = "00000000"; // 나머지 8자리
		int intSeq  = 1;		 	 // 시퀀스 -> 9 자리 입력시 맨 왼쪽의 값이 사라지고 8자리 
		
		// 1) num 비교
		if ( num > 0) { intSeq = num +1; }

		String strSeq = baseSeq + Integer.toString(intSeq); // "0000 0000" + "1" = 0000 0000 1
		
		System.out.println("strSeq length : " + strSeq.length());
		System.out.println("baseSeq length : " + baseSeq.length());


		// 8자리 추출, ((8+1) ~ (8+8) - 8) = (?, ?)
		strSeq = strSeq.substring(strSeq.length() - baseSeq.length(), strSeq.length()); // 
		
		System.out.println("[strSeq] " + strSeq);
		//String e164 = "090" + strSeq;
		
		String strE164 = "090" + strSeq;
		System.out.println("[E164] " + strE164);

		return strE164;
	}
	
}
