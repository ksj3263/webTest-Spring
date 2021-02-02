package com.webTest2.example.domain;

import org.springframework.web.multipart.MultipartFile;

public class Skin {
	private int s_num;
	private String s_name;
	private String s_property;
	private String s_tier;
	private MultipartFile s_image;
	private String s_full;
	private String s_thumb;
	private String s_date;
	private String s_ill;
	private String s_cv;
	private String p_name;
			
	public String getS_date() {
		return s_date;
	}
	public void setS_date(String s_date) {
		this.s_date = s_date;
	}
	public String getS_ill() {
		return s_ill;
	}
	public void setS_ill(String s_ill) {
		this.s_ill = s_ill;
	}
	public String getS_cv() {
		return s_cv;
	}
	public void setS_cv(String s_cv) {
		this.s_cv = s_cv;
	}
	public MultipartFile getS_image() {
		return s_image;
	}
	public void setS_image(MultipartFile s_image) {
		this.s_image = s_image;
	}
	public String getS_full() {
		return s_full;
	}
	public void setS_full(String s_full) {
		this.s_full = s_full;
	}
	public String getS_thumb() {
		return s_thumb;
	}
	public void setS_thumb(String s_thumb) {
		this.s_thumb = s_thumb;
	}
	public int getS_num() {
		return s_num;
	}
	public void setS_num(int s_num) {
		this.s_num = s_num;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_property() {
		return s_property;
	}
	public void setS_property(String s_property) {
		this.s_property = s_property;
	}
	public String getS_tier() {
		return s_tier;
	}
	public void setS_tier(String s_tier) {
		this.s_tier = s_tier;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	@Override
	public String toString() {
		return "Skin [s_num=" + s_num + ", s_name=" + s_name + ", s_property=" + s_property + ", s_tier=" + s_tier
				+ ", s_image=" + s_image + ", s_full=" + s_full + ", s_thumb=" + s_thumb + ", s_date=" + s_date
				+ ", s_ill=" + s_ill + ", s_cv=" + s_cv + ", p_name=" + p_name + "]";
	}
}
