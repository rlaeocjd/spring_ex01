package com.spring.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.MessageVO;
import com.spring.persistence.MessageDAO;
import com.spring.persistence.PointDAO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject private MessageDAO mdao;
	
	@Inject private PointDAO pdao;
	
	public static String namespace = "com.spring.mapper.MessageMapper";
	
	@Transactional
	@Override
	public void addMessage(MessageVO vo) throws Exception {
		mdao.create(vo);
		pdao.updatePoint(vo.getSender(), 10);
	}

	@Override
	public MessageVO readMessage(String uid, Integer mid) throws Exception {
		mdao.updateState(mid);
		pdao.updatePoint(uid, 5);
		return mdao.readMessage(mid);
	}

}
