package com.ghs.ptt.util.AES;

import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.tomcat.util.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;


// JAVA 에서의 암호화/ 복호화
public class AES128 {
	
	private String ips;
    private Key keySpec;
    
    
    public static String secretKey = "ghs2022lab000000";
    public static byte[] ivBytes = "0000000000000000".getBytes();
    
    
 // 인코딩(암호화)
    public String encrypt(String str) {
        Cipher cipher; 
         // ENCRYPT_MODE(암호화) / DECRYPT_MODE(복호화) / WRAP_MODE(key-wrapping) / UNWRAP_MODE(key-unwrapping)
        try {
        	
        	AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
        	SecretKeySpec newKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");
        	
            cipher = Cipher.getInstance("AES/CBC/PKCS5Padding"); // 암호화, 복호화 지원 객체 선언
            cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec); // CIPHER 초기화(암호화), 암호화모드(ENCRYPT_MODE)
 
            byte[] encrypted = cipher.doFinal(str.getBytes("UTF-8")); // Encrpytion, Decryption
            String Str = new String(Base64.encodeBase64(encrypted));  // base64로 포맷해서 인코딩 실시
 
            return Str;
        } catch (Exception e) {
        	return null;
        }
    }
    
 // 디코딩(복호화)
    public String decrypt(String str) {
        try {
        	
        	AlgorithmParameterSpec ivSpec = new IvParameterSpec(ivBytes);
        	SecretKeySpec newKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");
        	
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec); // Cipher초기화(복호화), DECRYPT_MODE (복호화 모드)
  
            byte[] byteStr = Base64.decodeBase64(str.getBytes()); // base64로 포맷해서 디코딩 실시
            String Str = new String(cipher.doFinal(byteStr), "UTF-8"); //  Encrpytion, Decryption
 
            return Str;
        } catch (Exception e) {
            return null;
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // 기본 및 키 관련 설정
    public AES128(String key) {
        try {
            byte[] keyBytes = new byte[16];		// key 글자 설정 16바이트
            byte[] b = key.getBytes("UTF-8");   // 인코딩 설정
            System.arraycopy(b, 0, keyBytes, 0, keyBytes.length);
            SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");	// 비밀키 생성
            this.ips = key.substring(0, 16);	// 패팅설정(16자리 빈자리수 채우기)
            this.keySpec = keySpec; // iv
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    
    /*
    public String encrypt(String str) {
        Cipher cipher;
        try {
            cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec,
                    new IvParameterSpec(ips.getBytes()));
 
            byte[] encrypted = cipher.doFinal(str.getBytes("UTF-8"));
            String Str = new String(Base64.encodeBase64(encrypted));
 
            return Str;
        } catch (Exception e) {
        	return null;
        }
    }
 
    public String decrypt(String str) {
        try {
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(Cipher.DECRYPT_MODE, keySpec,
                    new IvParameterSpec(ips.getBytes("UTF-8")));
 
            byte[] byteStr = Base64.decodeBase64(str.getBytes());
            String Str = new String(cipher.doFinal(byteStr), "UTF-8");
 
            return Str;
        } catch (Exception e) {
            return null;
        }
    }
    */
    
    // ----------------------------------------------MySql  관련--------------------------------------------

    //import org.apache.commons.codec.binary.Hex;
    //MySql 에서 AES128 암 복호화 한 걱을 JAVA에서 비교할 때
	//MySQL Encrypt
	public String MySQLEncrypt(String str, String key) throws Exception {
		final Cipher encryptCipher = Cipher.getInstance("AES");                            
		encryptCipher.init(Cipher.ENCRYPT_MODE, MySQLSetKey(key, "UTF-8"));        
		return new String(Hex.encodeHex(encryptCipher.doFinal(str.getBytes("UTF-8")))).toUpperCase();
	}
     
    
    //MySQL Decrypt
	public String MySQLDecrypt(String str, String key) throws Exception {
		final Cipher decryptCipher = Cipher.getInstance("AES");                            
		decryptCipher.init(Cipher.DECRYPT_MODE, MySQLSetKey(key, "UTF-8"));
		return new String(decryptCipher.doFinal(Hex.decodeHex(str.toCharArray())));
	}
    
    //key Setting
    public static SecretKeySpec MySQLSetKey(final String key, final String encoding) {
		try {
			final byte[] finalKey = new byte[16];
			int i = 0;
			for(byte b : key.getBytes(encoding)) {
				finalKey[i++%16]^=b;  
			}	          
			return new SecretKeySpec(finalKey, "AES");
		} catch(Exception e) {
			throw new RuntimeException(e);	
		}
    }
}







