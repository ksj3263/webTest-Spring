package com.webTest2.example.service;

import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.User;
import com.webTest2.example.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userMapper.readUser(username);
		user.setAuthorities(getAuthorities(username));
		
		return user;
	}
	
	@Override
	public Collection<GrantedAuthority> getAuthorities(String username) {
		List<GrantedAuthority> authorities = userMapper.readAuthorities(username);
		return authorities;
	}
	
	@Override
	public void createUser(User user) {
		userMapper.createUser(user);
	}
	
	@Override
	public void createAuthorities(User user) {
		userMapper.createAuthority(user);
	}
	
	@Override
	public User readUser(String username) {
		return userMapper.readUser(username);
	}
	
	@Override
	public List<User> selectUserList(int page) {
		return userMapper.selectUserList((page-1)*10);
	}
	
	public int getUserCount() {
		return userMapper.getUserCount();
	}
	
	@Override
	public User findUser(String username) {
		return userMapper.findUser(username);
	}
	
	@Override
	public void editUser(User user) {
		userMapper.editUser(user);
	}
	
	@Override
	public void delUser(String username) {
		userMapper.delUser(username);
	}
}
