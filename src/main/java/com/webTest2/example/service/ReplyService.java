package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Reply;

public interface ReplyService {
	public void writeReply(Reply reply);
	
	public List<Reply> getReply(int bId);
}
