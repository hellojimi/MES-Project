package com.itwillbs.work.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.work.domain.PageDTO;
import com.itwillbs.auth.domain.AuthDTO;
import com.itwillbs.auth.service.AuthService;
import com.itwillbs.line.domain.LineDTO;
import com.itwillbs.line.service.LineService;
import com.itwillbs.login.service.LoginService;
import com.itwillbs.member.domain.MemberDTO;
import com.itwillbs.work.domain.ItemDTO;
import com.itwillbs.work.domain.PerformDTO;
import com.itwillbs.work.service.PerformService;



@Controller
public class PerformController {
	
	@Inject
	private PerformService performService;
	
	@Inject
	private LineService lineService;
	
	@Inject
	private LoginService loginService;
	
	@Inject
	private AuthService authService;
	
	@RequestMapping(value = "/work/performRegist", method = RequestMethod.GET)
	public String performRegist(Model model, HttpServletRequest request, PageDTO pageDTO) {

		// 조회 값들
		String line = request.getParameter("line");
		String pcd = request.getParameter("pcd");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		String ists1 = request.getParameter("ists1");
		String ists2 = request.getParameter("ists2");
		String ists3 = request.getParameter("ists3");
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize = 3; // sql문에 들어가는 항목
		
		// 현페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1; // sql문에 들어가는 항목
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow-1); // limit startRow (0이 1열이기 때문 1을 뺌)
		pageDTO.setEndRow(endRow);

		Map<String,Object> search = new HashMap<>(); // sql에 들어가야할 서치 항목 및 pageDTO 항목 map에 담기
		search.put("line", line);
		search.put("pcd", pcd);
		search.put("sdate", sdate);
		search.put("edate", edate);
		search.put("ists1", ists1);
		search.put("ists2", ists2);
		search.put("ists3", ists3);
		search.put("startRow", pageDTO.getStartRow());
		search.put("pageSize", pageDTO.getPageSize());
 
		
		List<Map<String,Object>> instrList;
		if(line == null && pcd == null && sdate == null && edate == null && ists1 == null && ists2 == null && ists3 == null) {
		// 조회 안한 경우
			instrList = performService.getInstrLiMap(pageDTO); // page만 필요해서
		
		}else { // 조회값 넣은 경우
			instrList = performService.getInstrLiMap(search);
			
		}
				
		//페이징 처리
		int count = performService.countInstrLi(search);

		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		 }
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		System.out.println("endPage :"+pageDTO.getEndPage());
		System.out.println("count :"+pageDTO.getCount());
		model.addAttribute("instrList", instrList); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("search", search);

		// 라인 목록 불러오기
		List<LineDTO> linelist = lineService.lineList();	
		model.addAttribute("linelist", linelist);

		return "work/performRegist";
	}
	
	@RequestMapping(value = "/work/itemList", method = RequestMethod.GET)
	public String itemList(Model model, HttpServletRequest request, PageDTO pageDTO) { // 품목 리스트
		String itemNum = request.getParameter("itemNum");
		String itemName = request.getParameter("itemName");
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize = 5; // sql문에 들어가는 항목
		
		// 현페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1; // sql문에 들어가는 항목
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow-1); // limit startRow (0이 1열이기 때문 1을 뺌)
		pageDTO.setEndRow(endRow);

		Map<String,Object> search = new HashMap<>(); // sql에 들어가야할 서치 항목 및 pageDTO 항목 map에 담기
		search.put("itemNum", itemNum);
		search.put("itemName", itemName);
		search.put("startRow", pageDTO.getStartRow());
		search.put("pageSize", pageDTO.getPageSize());
 
		List<ItemDTO> itemList = performService.getItemlist(search);
			
		//페이징 처리
		int count = performService.countItemlist(search);

		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		 }
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
				
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("search", search);
		model.addAttribute("itemList", itemList);
		return "work/itemList";
	}
	
	@RequestMapping(value = "/work/performList", method = RequestMethod.GET)
	public String performList(Model model, HttpServletRequest request, PageDTO pageDTO) {  // 생산실적 현황 페이지
		// 조회 값들
		String line = request.getParameter("line");
		String pcd = request.getParameter("pcd");
		String sdate = request.getParameter("sdate");
		String edate = request.getParameter("edate");
		String worknum = request.getParameter("worknum");
		
		// 한 화면에 보여줄 글 개수 설정
		int pageSize = 3; // sql문에 들어가는 항목
		
		// 현페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1; // sql문에 들어가는 항목
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow-1); // limit startRow (0이 1열이기 때문 1을 뺌)
		pageDTO.setEndRow(endRow);

		Map<String,Object> search = new HashMap<>(); // sql에 들어가야할 서치 항목 및 pageDTO 항목 map에 담기
		search.put("line", line);
		search.put("pcd", pcd);
		search.put("sdate", sdate);
		search.put("edate", edate);
		search.put("worknum", worknum);
		search.put("startRow", pageDTO.getStartRow());
		search.put("pageSize", pageDTO.getPageSize());
 
		
		List<Map<String,Object>> performlist = performService.PerformLiMap(search);
			
				
		//페이징 처리
		int count = performService.countPerformLi(search);
		System.out.println("count : "+count);
		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		 }
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		System.out.println("endPage :"+pageDTO.getEndPage());
		System.out.println("count :"+pageDTO.getCount());
		model.addAttribute("performlist", performlist); 
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("search", search);
		
		// 라인 목록 불러오기
		List<LineDTO> linelist = lineService.lineList();	
		model.addAttribute("linelist", linelist);

		return "work/performList";
	}
	
		
	@RequestMapping(value = "/work/pfInsert", method = RequestMethod.GET)
	public String pfInsert(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException { // 실적 등록 창
		int instrId = Integer.parseInt(request.getParameter("instrId"));
		
		Map<String, Object> getInstr = performService.getInstrMap(instrId);
		
		if(getInstr.get("workSts").equals("마감")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('마감된 지시는 실적을 등록할 수 없습니다.');");
			out.println("window.close();");
			out.println("</script>");
			out.close();
			return null;
		}else {
		
		model.addAttribute("getInstr", getInstr);
		return "work/pfInsert";
		}
	}
	

	@RequestMapping(value = "/common/offwindow", method = RequestMethod.GET)
	public String offwindow(HttpServletRequest request, Model model) { // 팝업창 닫기(폼에서 다른 페이지로 넘어가고 닫아야하는 경우 사용)
		return "common/offwindow";
	}
	
	
	@RequestMapping(value = "/work/PinsertPro", method = RequestMethod.GET)
	public String PinserPro (HttpServletRequest request, HttpSession session){ // 실적 등록 실행

		PerformDTO performDTO = new PerformDTO();
		String id = (String)session.getAttribute("id");
		performDTO.setInsertId(id);
		performDTO.setInstrId(Integer.parseInt(request.getParameter("instrId")));


		String date = request.getParameter("performDate");
		Date performDate = Date.valueOf(date); // String -> Date(sql)로 변환
		performDTO.setPerformDate(performDate);

		performDTO.setPerformQty(Integer.parseInt(request.getParameter("performQty")));
		performDTO.setGbYn(request.getParameter("gbYn"));
		performDTO.setDbReason(request.getParameter("dbReason"));
		performDTO.setNote(request.getParameter("note"));
		
		performService.insertPf(performDTO);
		
		
		return "redirect:/common/offwindow";
	}
	

	@RequestMapping(value = "/work/pfmodi", method = RequestMethod.GET)
	public String pfmodi(HttpServletRequest request, Model model) { // 실적 수정창
		
		int performId = Integer.parseInt(request.getParameter("performId"));
		
		PerformDTO pfDTO = performService.getPf(performId);
		
		Map<String, Object> getInstr = performService.getInstrMap(pfDTO.getInstrId()); // 품명 가져오기 위해
		
		model.addAttribute("pfDTO", pfDTO);
		model.addAttribute("getInstr", getInstr);
		
		return "work/pfmodi";
	}
	
	@RequestMapping(value = "/work/PmodiPro", method = RequestMethod.POST)
	public String PmodiPro (PerformDTO performDTO, HttpSession session, HttpServletRequest request){ // 실적 수정 실행
		PerformDTO preDTO = new PerformDTO();
		int preqty = Integer.parseInt(request.getParameter("preqty"));
		String preYn = request.getParameter("preYn");
		int preitemId = Integer.parseInt(request.getParameter("preitemId"));
		preDTO.setPerformQty(preqty);
		preDTO.setGbYn(preYn);
		preDTO.setItemId(preitemId);

		
		String id = (String)session.getAttribute("id");
		performDTO.setUpdateId(id); // 수정한 사람 id
		performDTO.setUpdateDate(new Timestamp(System.currentTimeMillis()));
		performDTO.setItemId(preitemId);
		
		performService.delqty(preDTO);
		performService.updatePf(performDTO);
		
		return "redirect:/common/offwindow";
	}
	
	@RequestMapping(value = "/work/del", method = RequestMethod.GET)
	public String del(HttpServletRequest request) { // 실적 삭제창
		int performId = Integer.parseInt(request.getParameter("performId"));
		performService.delPf(performId);
		
		
		return "redirect:/work/performRegist";
	}

	@RequestMapping(value = "/work/popPfRe", method = RequestMethod.GET)
	public String popPfRe(Model model, HttpServletRequest request, PageDTO pageDTO, HttpSession session) { // 팝 실적등록창

		if(session.getAttribute("id")!=null) {
		MemberDTO memberDTO = new MemberDTO();
		String id = (String)session.getAttribute("id");
		memberDTO.setId(id);
		MemberDTO memberDTO2 = loginService.idCheck(memberDTO);
		session.setAttribute("name", memberDTO2.getName());
		}
		// 한 화면에 보여줄 글 개수 설정
		int pageSize = 8; // sql문에 들어가는 항목
		
		// 현페이지 번호 가져오기
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) {
			pageNum="1";
		}
		// 페이지번호를 정수형 변경
		int currentPage=Integer.parseInt(pageNum);
		pageDTO.setPageSize(pageSize);
		pageDTO.setPageNum(pageNum);
		pageDTO.setCurrentPage(currentPage);
		int startRow=(pageDTO.getCurrentPage()-1)*pageDTO.getPageSize()+1; // sql문에 들어가는 항목
		int endRow = startRow+pageDTO.getPageSize()-1;
		
		pageDTO.setStartRow(startRow-1); // limit startRow (0이 1열이기 때문 1을 뺌)
		pageDTO.setEndRow(endRow);
		List<Map<String,Object>> instrList = performService.getInstrLiMap(pageDTO); 

		
		Map<String,Object> search = new HashMap<>();
		search.put("startRow", pageDTO.getStartRow());
		search.put("pageSize", pageDTO.getPageSize());

		//페이징 처리
		int count = performService.countInstrLi(search);

		int pageBlock = 10;
		int startPage=(currentPage-1)/pageBlock*pageBlock+1;
		int endPage=startPage+pageBlock-1;
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		if(endPage > pageCount){
		 	endPage = pageCount;
		 }
		
		pageDTO.setCount(count);
		pageDTO.setPageBlock(pageBlock);
		pageDTO.setStartPage(startPage);
		pageDTO.setEndPage(endPage);
		pageDTO.setPageCount(pageCount);
		
		model.addAttribute("instrList", instrList); 
		model.addAttribute("pageDTO", pageDTO);

		
		return "/work/pop_prfmRe";
	}
	
	@RequestMapping(value = "/work/popConfirm", method = RequestMethod.GET)
	public String popConfirm(HttpServletRequest request, Model model) { // 팝화면 지시 확인창
		
		
		
		int instrId = Integer.parseInt(request.getParameter("instrId"));
		
		Map<String, Object> inst = performService.getInstrMap(instrId);
		
		List<Map<String, Object>> pflist = performService.getPfLiMap(request.getParameter("instrId"));
		
		System.out.println(pflist);
		model.addAttribute("inst", inst); 
		model.addAttribute("pflist", pflist); 
		
		
		return "work/pop_confirm";
	}
	
	
	@RequestMapping(value = "/work/popInsert", method = RequestMethod.GET)
	public String popInsert(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException { // 팝화면 실적 등록창

		int instrId = Integer.parseInt(request.getParameter("instrId"));
		

		Map<String, Object> inst = performService.getInstrMap(instrId);
		
		if(inst.get("workSts").equals("마감")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type='text/javascript'>");
			out.println("alert('마감된 지시는 실적을 등록할 수 없습니다.');");
			out.println("history.back()");
			out.println("</script>");
			out.close();
			return null;
		}else {
		
		model.addAttribute("inst", inst);
		return "work/pop_insert";}
	}
	
	@RequestMapping(value = "/work/PopinsertPro", method = RequestMethod.GET)
	public String PopinserPro (HttpServletRequest request, HttpSession session){ // 팝화면 실적 등록 실행
		
		PerformDTO performDTO = new PerformDTO();
		String id = (String)session.getAttribute("id");
		performDTO.setInsertId(id);
		performDTO.setInstrId(Integer.parseInt(request.getParameter("instrId")));


		String date = request.getParameter("performDate");
		Date performDate = Date.valueOf(date); // String -> Date(sql)로 변환
		performDTO.setPerformDate(performDate);

		performDTO.setPerformQty(Integer.parseInt(request.getParameter("performQty")));
		performDTO.setGbYn(request.getParameter("gbYn"));
		performDTO.setDbReason(request.getParameter("dbReason"));
		performDTO.setNote(request.getParameter("note"));
		
		
		performService.insertPf(performDTO);
		
		return "redirect:/work/popPfRe";
	}
	
	
	
	@RequestMapping(value = "/work/logout", method = RequestMethod.GET) // 팝화면 로그아웃
	public String poplogout(HttpSession session) {

		// 세션 초기화
		session.invalidate();
		
		return "redirect:/work/poplogin";
	}
	
	@RequestMapping(value = "/work/poplogin", method = RequestMethod.GET) // 팝화면 로그인
	public String poplogin(HttpSession session, HttpServletResponse response) throws IOException {
		if(session.getAttribute("id")!=null) {
			if(session.getAttribute("menu15")!=null)
			{return "redirect:/work/popPfRe";}
			else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script type='text/javascript'>");
				out.println("alert('해당 권한이 없습니다.');");
				out.println("history.back()");
				out.println("</script>");
				out.close();
				return null;
				
			}
		}
		return "work/poplogin";
	}
	
	@RequestMapping(value = "/work/loginPro", method = RequestMethod.POST) // 팝화면 로그인pro
	public String loginPro(MemberDTO memberDTO, HttpSession session, HttpServletResponse response) throws IOException {
		System.out.println(memberDTO.getId());
		System.out.println(memberDTO.getPass());
		
		MemberDTO memberDTO2 = loginService.login(memberDTO);

		if (memberDTO2 != null) { // 아이디,비밀번호 일치
			
			
			session.setAttribute("id", memberDTO.getId());
			session.setAttribute("name", memberDTO2.getName());
			List<AuthDTO> authlist = authService.getauth(memberDTO2);
			for(int i=0;i<authlist.size();i++) {
				AuthDTO auth = authlist.get(i);
				session.setAttribute("menu"+auth.getMenuCd(), auth.getMenuCd());
			}

			if(session.getAttribute("menu15")!=null){
				return "redirect:/work/popPfRe";	
			}else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script type='text/javascript'>");
				out.println("alert('해당 권한이 없습니다.');");
				out.println("history.back()");
				out.println("</script>");
				out.close();
				return null;
				
			}
			
		} else { // 아이디,비밀번호 틀림

			// common/msg.jsp 만들어서 "아이디 비밀번호 틀림" 메시지 출력하고 뒤로이동
			return "common/msg";
		}
	}
	
	
	@RequestMapping(value = "/work/popmodi", method = RequestMethod.GET) // 팝화면 수정창
	public String popmodi(Model model, HttpServletRequest request) {
		
		int performId = Integer.parseInt(request.getParameter("performId"));
		int instrId = Integer.parseInt(request.getParameter("instrId"));
		

		Map<String, Object> inst = performService.getInstrMap(instrId);
		PerformDTO pfDTO = performService.getPf(performId);
		
	
		model.addAttribute("pfDTO", pfDTO);
		model.addAttribute("inst", inst);
		
		return "work/pop_modi";
		
	}
	
	@RequestMapping(value = "/work/popmodiPro", method = RequestMethod.POST)
	public String popmodiPro (PerformDTO performDTO, HttpSession session, HttpServletRequest request){ // 팝화면 실적 수정 실행
		PerformDTO preDTO = new PerformDTO(); // 수정전 실적 정보 담기
		int preqty = Integer.parseInt(request.getParameter("preqty"));
		String preYn = request.getParameter("preYn");
		int preitemId = Integer.parseInt(request.getParameter("preitemId"));
		preDTO.setPerformQty(preqty); // 수정전 실적량
		preDTO.setGbYn(preYn); // 수정전 양불여부
		preDTO.setItemId(preitemId); // 품목id

		
		String id = (String)session.getAttribute("id");
		performDTO.setUpdateId(id); // 수정한 사람 id
		performDTO.setUpdateDate(new Timestamp(System.currentTimeMillis()));
		performDTO.setItemId(preitemId);
		
		performService.delqty(preDTO); // 수정전 재고 삭제
		
		performService.updatePf(performDTO); // 업뎃
		
		return "redirect:/work/popPfRe";
	}
	
	
	@RequestMapping(value = "/work/popdel", method = RequestMethod.GET) // 실적 삭제창
	public String popdel(HttpServletRequest request) { 
		int performId = Integer.parseInt(request.getParameter("performId"));
		performService.delPf(performId);
		
		return "redirect:/work/popPfRe";
	}
	
	@RequestMapping(value = "/work/close", method = RequestMethod.GET) // 수동마감
	public String close(HttpServletRequest request) { 
		int instrId = Integer.parseInt(request.getParameter("instrId"));
		performService.close(instrId);
		
		return "redirect:/work/performRegist";
	}
	
	
	
	
}


