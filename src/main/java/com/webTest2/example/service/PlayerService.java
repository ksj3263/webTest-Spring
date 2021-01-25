package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Player;

public interface PlayerService {
	public List<Player> getPlayerList();
	
	public Player findPlayer(int p_num);
	
	public void writePlayer(Player player);
}
