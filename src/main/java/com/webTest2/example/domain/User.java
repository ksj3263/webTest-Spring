package com.webTest2.example.domain;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class User implements UserDetails{
	private static final long serialVersionUID = 1L;
	
	private String username;
	private String password;
	private String uName;
	private String uDateTime;
	private int rowNum;
	
	private Collection<? extends GrantedAuthority> authorities;
	
	private boolean isAccountNonExpired;
	private boolean isAccountNonLocked;
	private boolean isCredentialsNonExpired;
	private boolean isEnabled;
	
	private String ANE;
	private String ANL;
	private String CNE;
	private String E;
	
	public String getANE() {
		return ANE;
	}

	public void setANE(String aNE) {
		ANE = aNE;
	}

	public String getANL() {
		return ANL;
	}

	public void setANL(String aNL) {
		ANL = aNL;
	}

	public String getCNE() {
		return CNE;
	}

	public void setCNE(String cNE) {
		CNE = cNE;
	}

	public String getE() {
		return E;
	}

	public void setE(String e) {
		E = e;
	}

	public String getuName() {
		return uName;
	}
	
	public void setuName(String uName) {
		this.uName = uName;
	}
	
	public void setuDateTime(String uDateTime) {
		this.uDateTime = uDateTime;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public void setAccountNonExpired(boolean isAccountNonExpired) {
		this.isAccountNonExpired = isAccountNonExpired;
	}
	
	public void setAccountNonLocked(boolean isAccountNonLocked) {
		this.isAccountNonLocked = isAccountNonLocked; 
	}
	
	public void setCredentialsNonExpired(boolean isCredentialsNonExpired) {
		this.isCredentialsNonExpired = isCredentialsNonExpired;
	}
	
	public void setEnabled(boolean isEnabled) {
		this.isEnabled = isEnabled;
	}
	
	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}
	
	@Override
	public String getPassword() {
		return password;
	}
	
	@Override
	public String getUsername() {
		return username;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return isAccountNonExpired;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return isAccountNonLocked;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return isCredentialsNonExpired;
	}
	
	@Override
	public boolean isEnabled() {
		return isEnabled;
	}

	public int getRowNum() {
		return rowNum;
	}

	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}

	public String getuDateTime() {
		return uDateTime;
	}	
	
	public boolean getisAccountNonExpired() {
		return isAccountNonExpired();
	}
	
	public boolean getisAccountNonLocked() {
		return isAccountNonLocked();
	}
	
	public boolean getisCredentialsNonExpired() {
		return isCredentialsNonExpired;
	}
	
	public boolean getisEnabled() {
		return isEnabled;
	}

	@Override
	public String toString() {
		return "User [username=" + username + ", password=" + password + ", uName=" + uName + ", uDateTime=" + uDateTime
				+ ", rowNum=" + rowNum + ", authorities=" + authorities + ", isAccountNonExpired=" + isAccountNonExpired
				+ ", isAccountNonLocked=" + isAccountNonLocked + ", isCredentialsNonExpired=" + isCredentialsNonExpired
				+ ", isEnabled=" + isEnabled + ", ANE=" + ANE + ", ANL=" + ANL + ", CNE=" + CNE + ", E=" + E + "]";
	}	
}
