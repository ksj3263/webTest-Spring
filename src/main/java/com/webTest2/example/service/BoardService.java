package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.Search;

public interface BoardService {
	public List<Board> selectBoardList(Search search);
	
	public void writeBoard(Board board);
	
	public Board findBoard(int id);
	
	public int getBoardCount(Search search);
	
	public void updateBase();
	
	public int getMaxOrder(int id);
	
	public void addBoard(Board board);
	
	public void deleteBoard(int id);
	
	public void editBoard(Board board);
	
	public int lastBoard();
}
