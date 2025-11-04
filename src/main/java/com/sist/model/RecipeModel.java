package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.FoodDAO;
import com.sist.dao.RecipeDAO;
import com.sist.vo.ChefVO;
import com.sist.vo.FoodVO;
import com.sist.vo.RecipeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class RecipeModel {
	
	// 쉐프 출력
	@RequestMapping("recipe/chef_list.do")
	public String recipe_chef_list(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		Map<String, Integer> map = new HashMap<>();
		int rowSize = 12;
		int start = (curpage - 1) * rowSize + 1;
		int end = curpage * rowSize;
		
		map.put("start", start);
		map.put("end", end);

		List<ChefVO> list = RecipeDAO.chefListData(map);
		// 총페이지
		int totalpage = RecipeDAO.chefTotalPage();
		
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
		
		// 화면 변경
		request.setAttribute("main_jsp", "../recipe/chef_list.jsp");
		return "../main/main.jsp";
	}
	
	// 레시피 목록
	@RequestMapping("recipe/list.do")
	public String recipe_list(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		Map<String, Integer> map = new HashMap<>();
		int rowSize = 12;
		int start = (curpage - 1) * rowSize + 1;
		int end = curpage * rowSize;
		
		map.put("start", start);
		map.put("end", end);

		List<RecipeVO> list = RecipeDAO.recipeListData(map);
		// 총페이지
		int totalpage = RecipeDAO.recipeTotalPage();
		
		// 블록별 페이지 처리
		final int BLOCK = 10;
		int startPage = (curpage - 1) / BLOCK * BLOCK + 1;
		// curpage => 1~10 : 1 , 11~20 : 11
		int endPage = (curpage - 1) / BLOCK * BLOCK + BLOCK;
		if (endPage > totalpage)
			endPage = totalpage;
		
		int count = RecipeDAO.recipeCount();
		
		// 브라우저 전송
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		// 화면 변경
		request.setAttribute("main_jsp", "../recipe/list.jsp");
		return "../main/main.jsp";
	}
	
	// 상세보기

}
