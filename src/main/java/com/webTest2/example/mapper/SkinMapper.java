package com.webTest2.example.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.webTest2.example.domain.Search;
import com.webTest2.example.domain.Skin;

@Mapper
public interface SkinMapper {
	public List<Skin> getSkinList(Search search);
	
	public int getSkinCount(Search search);
	
	public void writeSkin(Skin skin);
	
	public List<Skin> getSkinListName(String name);
	
	public Skin findSkin(int s_num);
	
	public void editSkin(Skin skin);
}
