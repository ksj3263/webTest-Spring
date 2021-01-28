package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Player;
import com.webTest2.example.domain.Search;

public interface PlayerService {
	public List<Player> getPlayerList(int page);
	
	public Player findPlayer(int p_num);
	
	public void writePlayer(Player player);
	
	public List<Player> searchPlayer(Search search);
	
	public int getPlayerCount();
	
	public void editPlayer(Player player);
}
