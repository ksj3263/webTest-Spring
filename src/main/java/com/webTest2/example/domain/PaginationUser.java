package com.webTest2.example.domain;

public class PaginationUser {
	int page;
	int pageNum;
	int startPage;
	int endPage;
	int lastPage;
	int prevPage;
	int nextPage;
	int userCount;
	public static final int pageUnit=5;
	public static final int perPage=10;
	
	public PaginationUser() {
		
	}
	
	public PaginationUser(int page, int userCount) {
		this.page = page;
		startPage = ((page-1)/pageUnit) * pageUnit + 1;
		this.userCount = userCount;		
		lastPage = (int)Math.ceil(userCount / (float)perPage);
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

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public static int getPageunit() {
		return pageUnit;
	}

	public static int getPerpage() {
		return perPage;
	}	
}

