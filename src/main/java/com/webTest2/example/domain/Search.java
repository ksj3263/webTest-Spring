package com.webTest2.example.domain;

import java.util.List;

public class Search {
	private List<String> attributes;
	private List<String> positions;
	private List<String> tiers;
	private Boolean checkAttributes;
	private Boolean checkPositions;
	private Boolean checkTiers;
	private String content;
	
	public Boolean getCheckAttributes() {
		return checkAttributes;
	}
	public void setCheckAttributes(Boolean checkAttributes) {
		this.checkAttributes = checkAttributes;
	}
	public Boolean getCheckPositions() {
		return checkPositions;
	}
	public void setCheckPositions(Boolean checkPositions) {
		this.checkPositions = checkPositions;
	}
	public Boolean getCheckTiers() {
		return checkTiers;
	}
	public void setCheckTiers(Boolean checkTiers) {
		this.checkTiers = checkTiers;
	}
	public List<String> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<String> attributes) {
		this.attributes = attributes;
	}
	public List<String> getPositions() {
		return positions;
	}
	public void setPositions(List<String> positions) {
		this.positions = positions;
	}
	public List<String> getTiers() {
		return tiers;
	}
	public void setTiers(List<String> tiers) {
		this.tiers = tiers;
	}
	@Override
	public String toString() {
		return "Search [attributes=" + attributes + ", positions=" + positions + ", tiers=" + tiers
				+ ", checkAttributes=" + checkAttributes + ", checkPositions=" + checkPositions + ", checkTiers="
				+ checkTiers + "]";
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}	
}
