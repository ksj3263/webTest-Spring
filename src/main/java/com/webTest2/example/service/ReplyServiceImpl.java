package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Reply;
import com.webTest2.example.domain.Search;
import com.webTest2.example.mapper.ReplyMapper;

@Service("ReplyServiceImpl")
public class ReplyServiceImpl implements ReplyService {
	@Autowired ReplyMapper replymapper;
	
	@Override
	public void writeReply(Reply reply) {
		replymapper.writeReply(reply);
	}
	
	@Override
	public List<Reply> getReply(Search search) {
		return replymapper.getReply(search);
	}
	
	@Override
	public void deleteReply(int rId) {
		replymapper.deleteReply(rId);
	}
	
	@Override
	public Reply findReply(int rId) {
		return replymapper.findReply(rId);
	}
	
	@Override
	public void editReply(Reply reply) {
		replymapper.editReply(reply);
	}
	
	@Override
	public void deleteAllReply(int bId) {
		replymapper.deleteAllReply(bId);
	}
	
	@Override
	public int getReplyCount(Search search) {
		return replymapper.getReplyCount(search);
	}
}
