package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Reply;
import com.webTest2.example.domain.Search;

@Mapper
public interface ReplyMapper {
	public void writeReply(Reply reply);
	
	public List<Reply> getReply(Search search);
	
	public void deleteReply(int rId);
	
	public Reply findReply(int rId);
	
	public void editReply(Reply reply);
	
	public void deleteAllReply(int bId);	
		
	public int getReplyCount(Search search);
}
