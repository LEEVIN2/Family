package com.animal.service;

import java.util.HashMap;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.animal.dao.DAO;
import com.animal.domain.DTO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@org.springframework.stereotype.Service
public class Service {
	
	@Inject
	private DAO DAO;
	
	// 회원 한명의 정보를 추가하는 메소드
		public void insert(DTO dto) {
			// 가입시 입력한 비밀번호를 읽어와서
			String pwd = dto.getPass();
			
			// 암호화 한 후에
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodedPwd = encoder.encode(pwd);
			// dto에 다시 넣어준다.
			dto.setPass(encodedPwd);
			// 암호화된 비밀번호가 들어 있는 dto를 dao에 전달해서 새로운 회원 정보를 추가한다.
			DAO.insert(dto);
		}

		public DTO checklogin(DTO dTO) {
			return DAO.checklogin(dTO);
		}

		public void insert2(JSONObject response_obj) {
			DAO.insert2(response_obj);
		}

		public boolean isUserExist(String nickname) {
			return DAO.isUserExist(nickname);
		}
		
		public void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
			String api_key = "NCSICNJDRIDGG2VB";
		    String api_secret = "KHVXI9CJYHJCN7AOWX4NFTTFYE6XRAFO";
		    Message coolsms = new Message(api_key, api_secret);

		    // 4 params(to, from, type, text) are mandatory. must be filled
		    HashMap<String, String> params = new HashMap<String, String>();
		    params.put("to", userPhoneNumber);    // 수신전화번호
		    params.put("from", "01077683677");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		    params.put("type", "SMS");
		    params.put("text", "[TEST] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
		    params.put("app_version", "test app 1.2"); // application name and version

		    try {
		        JSONObject obj = (JSONObject) coolsms.send(params);
		        System.out.println(obj.toString());
		      } catch (CoolsmsException e) {
		        System.out.println(e.getMessage());
		        System.out.println(e.getCode());
		      }
		    
		}



}
