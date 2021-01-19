package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Board;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoardList(int pageNum);
	
	public void writeBoard(Board board);
	
	public Board findBoard(int id);
	
	public int getBoardCount();
	
	public void updateBase();
}
