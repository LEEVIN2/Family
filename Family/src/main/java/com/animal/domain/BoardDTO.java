package com.animal.domain;

import com.google.inject.internal.util.Objects;

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
	private String id;
	private String nickname;
	private String submitTime;
	private String filePath;
	private int viewCnt;
	private int commentCnt;
	private int board_like;
	private int board_likeCnt;
	
	private String search;
	
//	페이징
	private int startPage;
	private int endPage;
	private String pageNum;
	
	private int pageSize; 
	private int currentPage;
	private int count;
	private int pageBlock;
	private int pageCount;
	
	private int startRow;
	private int endRow;
	
	// 뒤로가기시 이전페이지 저장
	private String prevPage;
	private String fixedPrevPage;
	
	// notice에서 읽었는지 안 읽었는지 판별하는 컬럼
	private String read;
	
	
	// notice 컨트롤러에서 소식내용 중복제거에 쓰임 (아래두개)
	@Override
	public boolean equals(Object o) {
	    if (this == o) return true;
	    if (o == null || getClass() != o.getClass()) return false;
	    BoardDTO boardDTO = (BoardDTO) o;
	    return Objects.equal(boardNum, boardDTO.boardNum);
	}

	@Override
	public int hashCode() {
	    return Objects.hashCode(boardNum);
	}

	
}
