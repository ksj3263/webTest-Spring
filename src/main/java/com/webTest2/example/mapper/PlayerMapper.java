package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Player;

@Mapper
public interface PlayerMapper {
	public List<Player> getPlayerList();
	
	public Player findPlayer(int p_num);
	
	public void writePlayer(Player player);
}
