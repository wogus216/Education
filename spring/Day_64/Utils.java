package com.spring.sample.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.lang.RandomStringUtils;

import com.spring.sample.common.CommonProperties;

public class Utils {
	/**
	 * Primary Key 생성
	 * 
	 * @return String
	 */
	public static String getPrimaryKey() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		return formatter.format(new java.util.Date()) + RandomStringUtils.randomNumeric(6);
	}
	
	/**
	 * 문자열을 key를 통해 암호화 하고 base64 로 인코딩
	 * 
	 * @return String
	 * @throws Throwable
	 */

	public static String encryptAES128(String value) throws Throwable {
		SecretKeySpec keySpec 
				= new SecretKeySpec(CommonProperties.SECURE_KEY.getBytes("UTF-8"), "AES");

		// getBytes : 문자열을 byte 배열로 변환
		// SecretKeySpec : 암호화 키 생성
		// 기본 암호화 키 생성
		SecretKeySpec skeySpec = new SecretKeySpec(
				DatatypeConverter.parseBase64Binary(
		// DatatypeConverter: 데이터형태로 변환
		// printBase64Binary: base64형태로 String으로 변환
		// parseBase64Binary:  base64형태로 byte으로 변환
		// base64(base64(기본키)) => AES 방식 추가 암호화 키 생성
		//  => 기본암호화키(바이트배열) -> base64(문자열) -> base64(바이트배열) - > 암호화키 생성 
		// 기본 암호화키를 base64로 변환하여 암호화된 암호화키 생성
						(String) DatatypeConverter.printBase64Binary(keySpec.getEncoded())), "AES");
		//자물쇠 만드는 과정
		// AES방식의 암호화객체(Cipher) 취득
		Cipher cipher = Cipher.getInstance("AES");
		// 초기화 설정(객체 동작모드, 암호화키)
		cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
		// 암호화
		byte[] encrypted = cipher.doFinal(value.getBytes()); 
		// 바이트 타입의 배열을 base64 문자열로 변환
		String encodeString = DatatypeConverter.printBase64Binary(encrypted); 
		return encodeString;
	}

	/**
	 * key 를 통해 문자열 base64 디코딩
	 * 
	 * @return String
	 * @throws Throwable
	 */
	public static String decryptAES128(String value) throws Throwable {
	
		SecretKeySpec keySpec 
						= new SecretKeySpec(CommonProperties.SECURE_KEY.getBytes("UTF-8"), "AES");
		SecretKeySpec sKeySpec = new SecretKeySpec(
				DatatypeConverter.parseBase64Binary
				(DatatypeConverter.printBase64Binary(keySpec.getEncoded())), "AES");

		Cipher cipher = Cipher.getInstance("AES");
		// 복호화모드 설정
		cipher.init(Cipher.DECRYPT_MODE, sKeySpec);
		 //문자열 형태의 파라메터를 배열에 바이트 변환 후 삽입
		byte[] decodeBytes = DatatypeConverter.parseBase64Binary(value);
		
		// 복호화
		byte[] decryptBytes = cipher.doFinal(decodeBytes); 
		
		// 문자열 변환
		return new String(decryptBytes);
	}
	
	/**
	 * MAP의 Key를 소문자로 변환
	 * 
	 * @return HashMap<String, String>
	 */
	public static HashMap<String, String> toLowerMapKey(HashMap<String, String> oldMap) throws Throwable {
		Set<String> keySet = oldMap.keySet();
		
		Iterator<String> keys = keySet.iterator();
		
		HashMap<String, String> newMap = new HashMap<String, String>();
		
		while(keys.hasNext()) {
			String key = keys.next();
			newMap.put(key.toLowerCase(), String.valueOf(oldMap.get(key)));
		}
		
		return newMap;
	}
	
	/**
	 * List의 MAP Key를 소문자로 변환
	 * 
	 * @return HashMap<String, String>
	 */
	public static List<HashMap<String, String>> toLowerListMapKey(List<HashMap<String, String>> oldList) {
		List<HashMap<String, String>> newList = new ArrayList<HashMap<String, String>>();
		
		for(HashMap<String, String> oldMap : oldList) {
			Set<String> keySet = oldMap.keySet();
			
			Iterator<String> keys = keySet.iterator();
			
			HashMap<String, String> newMap = new HashMap<String, String>();
			
			while(keys.hasNext()) {
				String key = keys.next();
				newMap.put(key.toLowerCase(), String.valueOf(oldMap.get(key)));
			}
			
			newList.add(newMap);
		}
		
		return newList;
	}
}
