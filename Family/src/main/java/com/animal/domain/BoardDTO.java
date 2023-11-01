package com.animal.domain;

import java.time.LocalDateTime;

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
	private LocalDateTime submitTime;

}
