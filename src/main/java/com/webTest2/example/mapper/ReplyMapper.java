package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Reply;

@Mapper
public interface ReplyMapper {
	public void writeReply(Reply reply);
	
	public List<Reply> getReply(int bId);
	
	public void deleteReply(int rId);
	
	public Reply findReply(int rId);
	
	public void editReply(Reply reply);
	
	public void deleteAllReply(int bId);	
	
	public List<Reply> getReplyP(int p_num);
	
	public List<Reply> getReplyS(int s_num);
}
