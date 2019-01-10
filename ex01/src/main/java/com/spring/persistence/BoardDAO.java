package com.spring.persistence;

import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SearchCriteria;

public interface BoardDAO {
	public void create(BoardVO vo) throws Exception;
	public BoardVO read(Integer bno) throws Exception;
	public void update(BoardVO vo) throws Exception;
	public void delete(Integer bno) throws Exception;
	public List<BoardVO> listAll() throws Exception;
	public List<BoardVO> listPage(int page) throws Exception;
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	public int countPaging(Criteria cri) throws Exception;
	
	// 검색과 페이징을 위한 함수
	public List<BoardVO> listSearch(SearchCriteria cri) throws Exception;
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	// 댓글의 숫자를 변경
	public void updateReplycnt(Integer bno, int amount) throws Exception;
	
	// 조회 숫자 처리
	public void updateViewCnt(Integer bno) throws Exception;
	
	// 파일 업로드 추가 후 attach 테이블 관련, 매개변수 : 파일명
	public void addAttach(String fullName) throws Exception;
	
	// 조회페이지 파일 업로드
	public List<String> getAttach(Integer bno) throws Exception;
	// 게시물 수정, 삭제 작업의 파일 업로드
	public void deleteAttach(Integer bno) throws Exception;
	public void replaceAttach(String fullName, Integer bno) throws Exception;
}
