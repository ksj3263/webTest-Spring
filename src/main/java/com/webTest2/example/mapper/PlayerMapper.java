package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Player;
import com.webTest2.example.domain.Search;

@Mapper
public interface PlayerMapper {
	public Player findPlayer(int p_num);
	
	public Player findPlayerName(String name);
	
	public void writePlayer(Player player);
	
	public List<Player> searchPlayer(Search search);
	
	public int getPlayerCount(Search search);
	
	public void editPlayer(Player player);	
}
