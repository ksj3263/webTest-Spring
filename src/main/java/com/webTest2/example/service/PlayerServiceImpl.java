package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Player;
import com.webTest2.example.domain.Search;
import com.webTest2.example.mapper.PlayerMapper;

@Service("PlayerServiceImpl")
public class PlayerServiceImpl implements PlayerService {
	@Autowired PlayerMapper playermapper;
	
	@Override
	public List<Player> getPlayerList(int page) {
		return playermapper.getPlayerList((page-1)*10);
	}
	
	@Override
	public Player findPlayer(int p_num) {
		return playermapper.findPlayer(p_num);
	}
	
	@Override
	public void writePlayer(Player player) {
		playermapper.writePlayer(player);
	}
	
	@Override
	public List<Player> searchPlayer(Search search) {
		return playermapper.searchPlayer(search);
	}
	
	@Override
	public int getPlayerCount() {
		return playermapper.getPlayerCount();
	}
	
	@Override
	public void editPlayer(Player player) {
		playermapper.editPlayer(player);
	}
}
