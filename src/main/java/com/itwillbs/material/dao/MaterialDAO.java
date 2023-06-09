package com.itwillbs.material.dao;

import java.util.List;
import java.util.Map;

import com.itwillbs.material.domain.ClientDTO;
import com.itwillbs.material.domain.InmaterialDTO;
import com.itwillbs.material.domain.OutmaterialDTO;
import com.itwillbs.material.domain.PageDTO;
import com.itwillbs.material.domain.StockDTO;
import com.itwillbs.work.domain.ItemDTO;


public interface MaterialDAO {
	
	public List<Map<String, Object>> inmaterList();
	
	public List<Map<String, Object>> getInmaterLiMap(Map<String, Object> search);

	public List<Map<String, Object>> getInmaterLiMap(PageDTO pageDTO);
		
	public Integer countMtrlLi(Map<String,Object> search);
	
	public List<Map<String, Object>> outmaterList();

	public List<Map<String, Object>> getOutmaterLiMap(PageDTO pageDTO);

	public List<Map<String, Object>> getOutmaterLiMap(Map<String, Object> search);
	
	public Integer countOutLi(Map<String,Object> search);

	public List<ItemDTO> getItemlist(Map<String, Object> search);

	public Integer countItemlist(Map<String, Object> search);

	public List<ClientDTO> getClientlist(Map<String, Object> search);

	public Integer countClientlist(Map<String, Object> search);

	public List<Map<String, Object>> mtrlStateList(Map<String, Object> search);

	public List<Map<String, Object>> mtrlStateList(PageDTO pageDTO);

	public List<Map<String, Object>> materialState();
	
	public Integer countStateLi(Map<String, Object> search);

//	public Map<String, Object> getInmtrlMap(int inmtrlId);

	public void insertInmtrl(InmaterialDTO inmaterialDTO);

	public void deleteInmtrl(int inmtrlId);

	public void deleteOutmtrl(int outmtrlId);

	public void insertOutmtrl(OutmaterialDTO outmaterialDTO);

	public InmaterialDTO getInmtrlList(int inmtrlId);

	public void updateInmtrl(InmaterialDTO inmaterialDTO);

	public InmaterialDTO getInmtrl(int inmtrlId);

	public Map<String, Object> getInmtrlMap(int inmtrlId);
	
	public OutmaterialDTO getOutmtrl(int outmtrlId);

	public Map<String, Object> getOutmtrlMap(int outmtrlId);

	public void updateOutmtrl(OutmaterialDTO outmaterialDTO);

	public StockDTO getStock(int stockId);
	
	public void updateStock(StockDTO stockDTO);
	
	public Integer getinStock(int itemId);
	
	public void updateinStock(InmaterialDTO inmaterialDTO);
	
	public void updateinStorage(InmaterialDTO inmaterialDTO);
	
	public void delinStock(InmaterialDTO inmaterialDTO);
	
	public void delinStorage(InmaterialDTO inmaterialDTO);
	
	public void editinStock(InmaterialDTO inmaterialDTO);
	
	public void editinStorage(InmaterialDTO inmaterialDTO);
	
	public void updateoutStock(OutmaterialDTO outmaterialDTO);
	
	public void updateoutStorage(OutmaterialDTO outmaterialDTO);
	
	public void deloutStock(OutmaterialDTO outmaterialDTO);
	
	public void deloutStorage(OutmaterialDTO outmaterialDTO);
	
	public void editoutStock(OutmaterialDTO outmaterialDTO);
	
	public void editoutStorage(OutmaterialDTO outmaterialDTO);

	public Integer getoutStock(int itemId);

	public void updateIncurStock(InmaterialDTO inmaterialDTO);
	
	public void updateOutcurStock(OutmaterialDTO outmaterialDTO);
}
