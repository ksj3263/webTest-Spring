package com.webTest2.example.domain;

public class PaginationPlayer {
	int page;
	int pageNum;
	int startPage;
	int endPage;
	int lastPage;
	int prevPage;
	int nextPage;
	int playerCount;
	public static final int pageUnit=5;
	public static final int perPage=10;
	
	public PaginationPlayer() {
		
	}
	
	public PaginationPlayer(int page, int playerCount) {
		this.page = page;
		startPage = ((page-1)/pageUnit) * pageUnit + 1;
		this.playerCount = playerCount;		
		lastPage = (int)Math.ceil(playerCount / (float)perPage);
		endPage = startPage + pageUnit-1;
		endPage = endPage < lastPage ? endPage : lastPage;
		prevPage=startPage-1;
		nextPage = (startPage+pageUnit);
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getPlayerCount() {
		return playerCount;
	}

	public void setPlayerCount(int playerCount) {
		this.playerCount = playerCount;
	}

	public static int getPageunit() {
		return pageUnit;
	}

	public static int getPerpage() {
		return perPage;
	}	
}