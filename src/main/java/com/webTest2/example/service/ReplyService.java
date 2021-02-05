package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Reply;
import com.webTest2.example.domain.Search;

public interface ReplyService {
	public void writeReply(Reply reply);
	
	public List<Reply> getReply(Search search);
	
	public void deleteReply(int rId);
	
	public Reply findReply(int rId);
	
	public void editReply(Reply reply);
	
	public void deleteAllReply(int bId);
		
	public int getReplyCount(Search search);
}
