package com.webTest2.example.service;

import java.util.List;

import com.webTest2.example.domain.Search;
import com.webTest2.example.domain.Skin;

public interface SkinService {
	public List<Skin> getSkinList(Search search);
	
	public int getSkinCount(Search search);
	
	public void writeSkin(Skin skin);
	
	public List<Skin> getSkinListName(String name);
	
	public Skin findSkin(int s_num);
	
	public void editSkin(Skin skin);
}
