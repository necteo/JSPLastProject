package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsDAO;
import com.sist.vo.GoodsVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class GoodsModel {
	private String[] table_name = {
		"",
		"goods_all",
		"goods_best",
		"goods_new",
		"goods_special"
	};
	private String[] titles = {
		"",
		"상품 전체 목록",
		"베스트 상품 목록",
		"신상품 목록",
		"특가 상품 목록"
	};
	
	@RequestMapping("goods/list.do")
	public String goods_list(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		String cno = request.getParameter("cno");
		Map<String, Object> map = new HashMap<>();
		int rowSize = 12;
		int start = (curpage - 1) * rowSize;
		int end = curpage * rowSize;
		map.put("goods", table_name[Integer.parseInt(cno)]);
		map.put("start", start);
		map.put("end", end);
		
		List<GoodsVO> list = GoodsDAO.goodsListData(map);
		int totalpage = GoodsDAO.goodsTotalPage(map);
		
		// 블록별 처리		
		// 블록별 페이지 처리
		final int BLOCK = 10;
		int startPage = (curpage - 1) / BLOCK * BLOCK + 1;
		// curpage => 1~10 : 1 , 11~20 : 11
		int endPage = (curpage - 1) / BLOCK * BLOCK + BLOCK;
		if (endPage > totalpage)
			endPage = totalpage;
		
		// 브라우저 전송
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("cno", cno);
		request.setAttribute("title", titles[Integer.parseInt(cno)]);
		
		// 화면 출력		
		request.setAttribute("main_jsp", "../goods/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("goods/detail_before.do")
	public String goods_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String page = request.getParameter("page");
		String cno = request.getParameter("cno");
		return "redirect:../goods/detail.do?no=" + no + "&page=" + page + "&cno=" + cno;
	}
	
	@RequestMapping("goods/detail.do")
	public String goods_detail(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String page = request.getParameter("page");
		String cno = request.getParameter("cno");
		
		Map<String, Object> map = new HashMap<>();
		map.put("no", no);
		// #{no} ${goods}
		map.put("goods", table_name[Integer.parseInt(cno)]);
		
		GoodsVO vo = GoodsDAO.goodsDetailData(map);
		
		request.setAttribute("vo", vo);
		request.setAttribute("cno", cno);
		request.setAttribute("page", page);
		
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}

}
