package com.animal.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	
	private String id;
	private String email;
	private String pass;
	private String nickname;
	private String mobile;
	private String profile;

}
