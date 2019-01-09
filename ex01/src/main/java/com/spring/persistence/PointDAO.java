package com.spring.persistence;

// 메시지 읽음, 받음 에 따른 포인트 적용
public interface PointDAO {
	public void updatePoint(String uid,int point) throws Exception;
}
