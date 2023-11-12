package com.animal.service;

import java.util.HashMap;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.animal.dao.MemberDAO;
import com.animal.domain.MemberDTO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberService {
	
	@Inject
	private MemberDAO memberDAO;
	
	// 회원 한명의 정보를 추가하는 메소드
	public boolean join(MemberDTO memberDTO) {
	    // 가입시 입력한 비밀번호를 읽어와서
	    String pwd = memberDTO.getPass();
	    
	    // 암호화 한 후에
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    String encodedPwd = encoder.encode(pwd);
	    // dto에 다시 넣어준다.
	    memberDTO.setPass(encodedPwd);
	    // 암호화된 비밀번호가 들어 있는 dto를 dao에 전달해서 새로운 회원 정보를 추가한다.
	    memberDTO.setNickname("익명");
	    try {
	        memberDAO.join(memberDTO);
	        return true;  // 회원 정보 추가가 성공하면 true를 반환
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;  // 회원 정보 추가가 실패하면 false를 반환
	    }
	}

		public MemberDTO checklogin(MemberDTO memberDTO) {
			return memberDAO.checklogin(memberDTO);
		}

		public void join2(JSONObject response_obj) {
			memberDAO.join2(response_obj);
		}

		public boolean isUserExist(String nickname) {
			return memberDAO.isUserExist(nickname);
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

		public MemberDTO checkemail(MemberDTO memberDTO) {
			return memberDAO.checkemail(memberDTO);
		}

		public MemberDTO checkmobile(MemberDTO memberDTO) {
			return memberDAO.checkmobile(memberDTO);
		}

		public MemberDTO checkid(MemberDTO memberDTO) {
			return memberDAO.checkid(memberDTO);
		}

		public MemberDTO checkeidmail(MemberDTO memberDTO) {
			return memberDAO.checkeidmail(memberDTO);
		}

		public boolean findpassPro(MemberDTO memberDTO) {
		    String pwd = memberDTO.getPass();
		    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		    String encodedPwd = encoder.encode(pwd);
		    memberDTO.setPass(encodedPwd);
		    try {
		        memberDAO.findpassPro(memberDTO);
		        return true;  // 회원 정보 추가가 성공하면 true를 반환
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false;  // 회원 정보 추가가 실패하면 false를 반환
		    }
		}

		public MemberDTO checkeidmobile(MemberDTO memberDTO) {
			return memberDAO.checkeidmobile(memberDTO);
		}




}
