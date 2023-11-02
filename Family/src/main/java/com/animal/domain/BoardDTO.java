package com.animal.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	
	private String title;
	private String content;
	private String nickname;
	private String submitTime;
	private String filePath; // 새로운 필드

}
