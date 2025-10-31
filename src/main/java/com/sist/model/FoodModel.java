package com.sist.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.FoodDAO;
import com.sist.vo.FoodVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/*
 *    화면 변경
 *      => request 전송 : forward
 *         return "파일명";
 *      => request 초기화 : sendRedirect
 *         return "redirect:~.do"
 *    데이터 전송
 *      => request/session이용 => request.setAttribute()
 *         : String
 *      => json
 *         : void
 *           => out.write(데이터)
 */
@Controller
public class FoodModel {
	
	@RequestMapping("food/list.do")
	public String food_list(HttpServletRequest request, HttpServletResponse response) {
		// 사용자가 요청 (페이지를 보여달라)
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
		
		List<FoodVO> list = FoodDAO.foodListData(map);
		for (FoodVO vo : list) {
			String addr = vo.getAddress();
			addr = addr.substring(0, addr.indexOf(" "));
			vo.setAddress(addr.trim());
		}
		// 총페이지
		int totalpage = FoodDAO.foodTotalPage();
		
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
		
		request.setAttribute("main_jsp", "../food/list.jsp");
		return "../main/main.jsp";
	}

}
