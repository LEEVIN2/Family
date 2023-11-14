package com.animal.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.animal.dao.MemberDAO;
import com.animal.domain.MemberDTO;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
		
		//카카오 로그인
		public String getAccessToken (String authorize_code) {
			String access_Token = "";
			String refresh_Token = "";
			String reqURL = "https://kauth.kakao.com/oauth/token";
			try {
				URL url = new URL(reqURL);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("POST");
				conn.setDoOutput(true);
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				StringBuilder sb = new StringBuilder();
				sb.append("grant_type=authorization_code");
				sb.append("&client_id=da018b782fe37e409f166154390e2391"); //본인이 발급받은 key
				sb.append("&redirect_uri=http://localhost/family/member/kakaoLogin"); // 본인이 설정한 주소
				sb.append("&code=" + authorize_code);
				bw.write(sb.toString());
				bw.flush();
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";
				while ((line = br.readLine()) != null) {
					result += line;
				}
//				JsonParser parser = new JsonParser();
//				JsonElement element = parser.parse(result);
				JsonElement element = JsonParser.parseString(result);
				access_Token = element.getAsJsonObject().get("access_token").getAsString();
				refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
				br.close();
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return access_Token;
		}
		//카카오 
		public HashMap<String, Object> getUserInfo(String access_Token) {
			HashMap<String, Object> userInfo = new HashMap<String, Object>();
			String reqURL = "https://kapi.kakao.com/v2/user/me";
			try {
				URL url = new URL(reqURL);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Authorization", "Bearer " + access_Token);
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String line = "";
				String result = "";
				while ((line = br.readLine()) != null) {
					result += line;
				}
//				JsonParser parser = new JsonParser();
//				JsonElement element = parser.parse(result);
				JsonElement element = JsonParser.parseString(result);
				JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
				JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
				String nickname = properties.getAsJsonObject().get("nickname").getAsString();
				String email = kakao_account.getAsJsonObject().get("email").getAsString();
				userInfo.put("nickname", nickname);
				userInfo.put("email", email);
				if (!memberDAO.isUserExist(nickname)) {
					memberDAO.join3(userInfo);  // 전체 데이터를 join2 메소드에 전달
			    }
			} catch (IOException e) {
				e.printStackTrace();
			}
			return userInfo;
		}




}
