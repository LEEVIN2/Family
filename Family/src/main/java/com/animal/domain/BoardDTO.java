package com.animal.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardDTO {
	
	private String boardNum;
	private String title;
	private String content;
	private String nickname;
	private String submitTime;
	private String filePath;
	private int viewCnt;
	private int commentCnt;
	private int board_like;
	private int board_likeCnt;
	
	private String search;
	
}
