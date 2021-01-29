package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.Search;

@Mapper
public interface BoardMapper {
	public List<Board> selectBoardList(Search search);
	
	public void writeBoard(Board board);
	
	public Board findBoard(int id);
	
	public int getBoardCount();
	
	public void updateBase();
	
	public int getMaxOrder(int id);
	
	public void addBoard(Board board);
	
	public void deleteBoard(int id);
	
	public void editBoard(Board board);
	
	public int lastBoard();
}
