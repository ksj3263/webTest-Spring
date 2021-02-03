package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Player;
import com.webTest2.example.domain.Search;

public interface PlayerService {
	public Player findPlayer(int p_num);
	
	public Player findPlayer(String name);
	
	public void writePlayer(Player player);
	
	public List<Player> searchPlayer(Search search);
	
	public int getPlayerCount(Search search);
	
	public void editPlayer(Player player);
}
