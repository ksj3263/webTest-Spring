package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Reply;
import com.webTest2.example.mapper.ReplyMapper;

@Service("ReplyServiceImpl")
public class ReplyServiceImpl implements ReplyService {
	@Autowired ReplyMapper replymapper;
	
	public void writeReply(Reply reply) {
		replymapper.writeReply(reply);
	}
	
	public List<Reply> getReply(int bId) {
		return replymapper.getReply(bId);
	}
}
