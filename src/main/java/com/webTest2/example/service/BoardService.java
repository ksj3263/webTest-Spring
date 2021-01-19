package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Board;

public interface BoardService {
	public List<Board> selectBoardList(int page);
	
	public void writeBoard(Board board);
	
	public Board findBoard(int id);
	
	public int getBoardCount();
	
	public void updateBase();
}
