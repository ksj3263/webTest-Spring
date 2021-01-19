package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Board;
import com.webTest2.example.mapper.BoardMapper;

@Service("BoardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired BoardMapper boardmapper;
	@Override
	public List<Board> selectBoardList(int page) {
		return boardmapper.selectBoardList((page-1)*10);
	}
	
	@Override
	public void writeBoard(Board board) {
		boardmapper.writeBoard(board);
	}
	
	@Override
	public Board findBoard(int id) {
		return boardmapper.findBoard(id);
	}
	
	@Override
	public int getBoardCount() {
		return boardmapper.getBoardCount();
	}
	
	@Override
	public void updateBase() {
		boardmapper.updateBase();
	}
	
	@Override
	public int getMaxOrder(int id) {
		return boardmapper.getMaxOrder(id);
	}
	
	@Override
	public void addBoard(Board board) {
		boardmapper.addBoard(board);
	}
}
