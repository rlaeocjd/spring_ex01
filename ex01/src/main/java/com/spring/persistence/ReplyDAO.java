package com.spring.persistence;

import java.util.List;

import com.spring.domain.Criteria;
import com.spring.domain.ReplyVO;

public interface ReplyDAO {
	public List<ReplyVO> list(Integer bno) throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void update(ReplyVO vo) throws Exception;
	
	public void delete(Integer rno) throws Exception;
	
	// 댓글 페이징 처리
	// 기존 페이징처리를 위한  "Criteria", 추가로 게시물 번호에 맞는 데어터 검색용 "bno"
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception;
	// 화면 페이징 처리를 위한 댓글수 계산
	public int count(Integer bno) throws Exception;
}
