package com.webTest2.example.domain;

import java.util.List;

public class Search {
	private List<String> positions;
	private List<String> attributes;
	private List<String> tiers;
	private List<String> properties;
	private String content;
	private int page;
	private int bId;
	private boolean checkPositions;
	private boolean checkAttributes;
	private boolean checkTiers;
	private boolean checkProperties;
	private int searchType;
				
	public int getbId() {
		return bId;
	}
	public void setbId(int bId) {
		this.bId = bId;
	}
	public int getSearchType() {
		return searchType;
	}
	public void setSearchType(int searchType) {
		this.searchType = searchType;
	}
	public boolean isCheckPositions() {
		return checkPositions;
	}
	public void setCheckPositions(boolean checkPositions) {
		this.checkPositions = checkPositions;
	}
	public boolean isCheckAttributes() {
		return checkAttributes;
	}
	public void setCheckAttributes(boolean checkAttributes) {
		this.checkAttributes = checkAttributes;
	}
	public boolean isCheckTiers() {
		return checkTiers;
	}
	public void setCheckTiers(boolean checkTiers) {
		this.checkTiers = checkTiers;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public List<String> getPositions() {
		return positions;
	}
	public void setPositions(List<String> positions) {
		this.positions = positions;
	}
	public List<String> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<String> attributes) {
		this.attributes = attributes;
	}
	public List<String> getTiers() {
		return tiers;
	}
	public void setTiers(List<String> tiers) {
		this.tiers = tiers;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<String> getProperties() {
		return properties;
	}
	public void setProperties(List<String> properties) {
		this.properties = properties;
	}
	public boolean isCheckProperties() {
		return checkProperties;
	}
	public void setCheckProperties(boolean checkProperties) {
		this.checkProperties = checkProperties;
	}
	@Override
	public String toString() {
		return "Search [positions=" + positions + ", attributes=" + attributes + ", tiers=" + tiers + ", properties="
				+ properties + ", content=" + content + ", page=" + page + ", checkPositions=" + checkPositions
				+ ", checkAttributes=" + checkAttributes + ", checkTiers=" + checkTiers + ", checkProperties="
				+ checkProperties + ", searchType=" + searchType + "]";
	}	
}
