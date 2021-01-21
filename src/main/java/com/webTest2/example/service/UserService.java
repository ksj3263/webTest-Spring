package com.webTest2.example.service;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.webTest2.example.domain.User;

public interface UserService extends UserDetailsService {
	
	public User readUser(String username);
	
	public void createUser(User user);
	
	public void createAuthorities(User user);
	
	Collection<GrantedAuthority> getAuthorities(String username);

	public List<User> selectUserList(int page);
	
	public int getUserCount();
	
	public User findUser(String username);
	
	public void editUser(User user);
}
