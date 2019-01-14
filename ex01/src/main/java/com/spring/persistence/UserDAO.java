package com.spring.persistence;

import java.util.Date;

import com.spring.domain.LoginDTO;
import com.spring.domain.UserVO;

public interface UserDAO {
	public UserVO login(LoginDTO dto) throws Exception;
	// 로그인한 사용자의 sessionKey와 sessionLimit를 업데이트하는 기능
	public void keepLogin(String uid, String sessionId, Date next);
	// loginCookie에 기록된 값으로 사용자의 정보 조회 
	public UserVO checkUserWithSessionKey(String value);
	
}
