package com.webTest2.example.domain;

import org.springframework.web.multipart.MultipartFile;

public class Player {
	private int p_num;
	private String p_name;
	private String p_position;
	private int p_power;
	private int p_technique;
	private int p_physical;
	private int p_speed;
	private String p_attribute;
	private String p_tier;
	private String p_active;
	private String p_passive1;
	private String p_passive2;
	private String p_passive3;
	private MultipartFile p_image;
	private String p_thumb;
	private String p_full;
	private String p_stone1;
	private String p_stone2;
	private String p_stone3;
	private String p_date;
	private String p_coop;
	private String p_coop1;
	private String p_coop2;
	private String p_coop3;	
	private String p_story;
			
	public String getP_full() {
		return p_full;
	}
	public void setP_full(String p_full) {
		this.p_full = p_full;
	}
	public String getP_stone1() {
		return p_stone1;
	}
	public void setP_stone1(String p_stone1) {
		this.p_stone1 = p_stone1;
	}
	public String getP_stone2() {
		return p_stone2;
	}
	public void setP_stone2(String p_stone2) {
		this.p_stone2 = p_stone2;
	}
	public String getP_stone3() {
		return p_stone3;
	}
	public void setP_stone3(String p_stone3) {
		this.p_stone3 = p_stone3;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public String getP_coop() {
		return p_coop;
	}
	public void setP_coop(String p_coop) {
		this.p_coop = p_coop;
	}
	public String getP_coop1() {
		return p_coop1;
	}
	public void setP_coop1(String p_coop1) {
		this.p_coop1 = p_coop1;
	}
	public String getP_coop2() {
		return p_coop2;
	}
	public void setP_coop2(String p_coop2) {
		this.p_coop2 = p_coop2;
	}
	public String getP_coop3() {
		return p_coop3;
	}
	public void setP_coop3(String p_coop3) {
		this.p_coop3 = p_coop3;
	}
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public String getP_position() {
		return p_position;
	}
	public void setP_position(String p_position) {
		this.p_position = p_position;
	}
	public int getP_power() {
		return p_power;
	}
	public void setP_power(int p_power) {
		this.p_power = p_power;
	}
	public int getP_technique() {
		return p_technique;
	}
	public void setP_technique(int p_technique) {
		this.p_technique = p_technique;
	}
	public int getP_physical() {
		return p_physical;
	}
	public void setP_physical(int p_physical) {
		this.p_physical = p_physical;
	}
	public int getP_speed() {
		return p_speed;
	}
	public void setP_speed(int p_speed) {
		this.p_speed = p_speed;
	}
	public String getP_attribute() {
		return p_attribute;
	}
	public void setP_attribute(String p_attribute) {
		this.p_attribute = p_attribute;
	}
	public String getP_tier() {
		return p_tier;
	}
	public void setP_tier(String p_tier) {
		this.p_tier = p_tier;
	}
	public String getP_active() {
		return p_active;
	}
	public void setP_active(String p_active) {
		this.p_active = p_active;
	}
	public String getP_passive1() {
		return p_passive1;
	}
	public void setP_passive1(String p_passive1) {
		this.p_passive1 = p_passive1;
	}
	public String getP_passive2() {
		return p_passive2;
	}
	public void setP_passive2(String p_passive2) {
		this.p_passive2 = p_passive2;
	}
	public String getP_passive3() {
		return p_passive3;
	}
	public void setP_passive3(String p_passive3) {
		this.p_passive3 = p_passive3;
	}
	@Override
	public String toString() {
		return "Player [p_num=" + p_num + ", p_name=" + p_name + ", p_position=" + p_position + ", p_power=" + p_power
				+ ", p_technique=" + p_technique + ", p_physical=" + p_physical + ", p_speed=" + p_speed
				+ ", p_attribute=" + p_attribute + ", p_tier=" + p_tier + ", p_active=" + p_active + ", p_passive1="
				+ p_passive1 + ", p_passive2=" + p_passive2 + ", p_passive3=" + p_passive3 + ", p_image=" + p_image
				+ ", p_stone1=" + p_stone1 + ", p_stone2=" + p_stone2 + ", p_stone3=" + p_stone3 + ", p_date=" + p_date
				+ ", p_coop=" + p_coop + ", p_coop1=" + p_coop1 + ", p_coop2=" + p_coop2 + ", p_coop3=" + p_coop3 + "]";
	}
	public String getP_story() {
		return p_story;
	}
	public void setP_story(String p_story) {
		this.p_story = p_story;
	}
	public String getP_thumb() {
		return p_thumb;
	}
	public void setP_thumb(String p_thumb) {
		this.p_thumb = p_thumb;
	}
	public MultipartFile getP_image() {
		return p_image;
	}
	public void setP_image(MultipartFile p_image) {
		this.p_image = p_image;
	}
}
