package com.webTest2.example.domain;

import java.util.List;

public class Search {
	private List<String> positions;
	private List<String> attributes;
	private List<String> tiers;
	private String content;
	private int page;
	private boolean checkPositions;
	private boolean checkAttributes;
	private boolean checkTiers;
	private int searchType;
			
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
	@Override
	public String toString() {
		return "Search [positions=" + positions + ", attributes=" + attributes + ", tiers=" + tiers + ", content="
				+ content + ", page=" + page + ", checkPositions=" + checkPositions + ", checkAttributes="
				+ checkAttributes + ", checkTiers=" + checkTiers + ", searchType=" + searchType + "]";
	}	
}
