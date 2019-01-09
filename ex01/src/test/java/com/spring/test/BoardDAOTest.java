package com.spring.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SearchCriteria;
import com.spring.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class BoardDAOTest {
	
	@Inject
	private BoardDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);

	@Test
	public void testDynamic1() throws Exception {
		SearchCriteria cri = new SearchCriteria();
		cri.setPage(1);
		cri.setKeyword("ttt");
		cri.setSearchType("t");
		logger.info("=======================================");
		List<BoardVO> list = dao.listSearch(cri);
		for(BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}
		logger.info("=======================================");
		logger.info("COUNT: " + dao.listSearchCount(cri));
	}
	
//	@Test
//	public void testURI2() throws Exception {
//		UriComponents uriComponents = 
//				UriComponentsBuilder.newInstance()
//				.path("/{module}/{page}")
//				.queryParam("bno", 12)
//				.queryParam("perPageNum", 20)
//				.build()
//				.expand("board","read")
//				.encode();
//		
//		logger.info("/board/read?bno=12&perPageNum=20");
//		logger.info(uriComponents.toString());
//	}
	
//	@Test
//	public void testURI() throws Exception {
//		UriComponents uriComponents = 
//				UriComponentsBuilder.newInstance()
//				.path("/board/read")
//				.queryParam("bno", 12)
//				.queryParam("perPageNum", 20)
//				.build();
//		
//		logger.info("/board/read?bno=12&perPageNum=20");
//		logger.info(uriComponents.toString());
//	}
	
//	@Test	// 페이징 > 페이지 번호지정, 게시글 수
//	public void testListCriteria() throws Exception {
//		Criteria cri = new Criteria();
//		cri.setPage(2);
//		cri.setPerPageNum(20);
//		
//		List<BoardVO> list = dao.listCriteria(cri);
//		
//		for(BoardVO boardVO : list) {
//			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
//		}
//	}
	
//	@Test	// 페이징 처리의 SQL 테스트
//	public void testListPage() throws Exception {
//		int page = 3;
//		List<BoardVO> list = dao.listPage(page);
//		
//		for ( BoardVO boardVO : list) {
//			logger.info(boardVO.getBno() + ":" + boardVO.getTitle());
//		}
//	}
	
//	@Test
//	public void testCreate() throws Exception {
//		BoardVO board = new BoardVO();
//		board.setTitle("새로운 글을 넣습니다.");
//		board.setContent("새로운 글을 넣습니다.");
//		board.setWriter("user00");
//		dao.create(board);
//	}
//	
//	@Test
//	public void testRead() throws Exception {
//		logger.info(dao.read(2).toString());
//	}
//	
//	@Test
//	public void testUpdate() throws Exception {
//		BoardVO board = new BoardVO();
//		board.setBno(2);
//		board.setTitle("수정된 글입니다.");
//		board.setContent("수정 테스트");
//		dao.update(board);
//	}
//	
//	@Test
//	public void testDelete() throws Exception {
//		dao.delete(2);
//	}
}
