package com.itwillbs.material.service;

import java.util.List;
import java.util.Map;

import com.itwillbs.material.domain.InmaterialDTO;
import com.itwillbs.material.domain.PageDTO;

public interface InmaterialService {

	public List<Map<String, Object>> inmaterList();

	public List<InmaterialDTO> getInmaterList(PageDTO pageDTO);

	public int getInmaterCount();

	public List<Map<String, Object>> getInmaterLiMap(String instock, String pcd, String sdate, String edate, String ccd, String cnm);
}

