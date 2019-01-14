package com.spring.service;

import java.util.Date;

import com.spring.domain.LoginDTO;
import com.spring.domain.UserVO;

public interface UserService {
	public UserVO login(LoginDTO dto) throws Exception;

	public void keepLogin(String uid, String sessionId, Date next) throws Exception;
	
	public UserVO checkLoginBefore(String value);
}
