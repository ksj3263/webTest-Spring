package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Board;
import com.webTest2.example.domain.Search;
import com.webTest2.example.mapper.BoardMapper;

@Service("BoardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired BoardMapper boardmapper;
	@Override
	public List<Board> selectBoardList(Search search) {
		return boardmapper.selectBoardList(search);
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
	public int getBoardCount(Search search) {
		return boardmapper.getBoardCount(search);
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
	
	@Override
	public void deleteBoard(int id) {
		boardmapper.deleteBoard(id);
	}
	
	@Override
	public void editBoard(Board board) {
		boardmapper.editBoard(board);
	}
	
	@Override
	public int lastBoard() {
		return boardmapper.lastBoard();
	}
}
