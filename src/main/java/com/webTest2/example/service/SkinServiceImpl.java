package com.webTest2.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.webTest2.example.domain.Search;
import com.webTest2.example.domain.Skin;
import com.webTest2.example.mapper.SkinMapper;

@Service("SkinServiceImpl")
public class SkinServiceImpl implements SkinService {
	@Autowired SkinMapper skinmapper;
	
	@Override
	public List<Skin> getSkinList(Search search) {
		return skinmapper.getSkinList(search); 
	}
	
	@Override
	public int getSkinCount(Search search) {
		return skinmapper.getSkinCount(search);
	}
	
	@Override
	public void writeSkin(Skin skin) {
		skinmapper.writeSkin(skin);
	}
	
	@Override
	public List<Skin> getSkinListName(String name) {
		return skinmapper.getSkinListName(name);
	}
	
	@Override
	public Skin findSkin(int s_num) {
		return skinmapper.findSkin(s_num);
	}
	
	@Override
	public void editSkin(Skin skin) {
		skinmapper.editSkin(skin);
	}
}
