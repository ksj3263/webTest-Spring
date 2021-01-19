package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Reply;

@Mapper
public interface ReplyMapper {
	public void writeReply(Reply reply);
	
	public List<Reply> getReply(int bId);
}
