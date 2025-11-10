package com.sist.model;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.FoodDAO;
import com.sist.vo.FoodVO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		List<FoodVO> cList = new ArrayList<>();
		if (id != null) { // 로그인된 상태
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = cookies.length - 1; i >= 0; i--) {
					if (cookies[i].getName().startsWith("food_" + id)) {
						String fno = cookies[i].getValue();
						FoodVO vo = FoodDAO.foodCookieData(Integer.parseInt(fno));
						cList.add(vo);
					}
				}
				request.setAttribute("cList", cList);
			}
		}
		
		request.setAttribute("main_jsp", "../food/list.jsp");
		return "../main/main.jsp";
	}
	
	/*
	 *   Spring => JSP
	 *   | include / forward => request를 공유
	 *   | sendRedirect => request가 초기화
	 *   | MVC => 모든 화면 DispatcherServlet이다
	 *   				 ------------------
	 *   				  => .do
	 *   				  => 화면 변경 => HTML만 덮어쓰고 있다
	 */
	@RequestMapping("food/detail.do")
	public String food_detail(HttpServletRequest request, HttpServletResponse response) {
		String fno = request.getParameter("fno");
		String page = request.getParameter("page");
		String link = request.getParameter("link");
		FoodVO vo = FoodDAO.foodDetailData(Integer.parseInt(fno));
		request.setAttribute("vo", vo);
		request.setAttribute("page", page);
		request.setAttribute("link", link);
		// => 스프링 : 전송 객체 / 사용자 요청값
		// => request는 사용하지 않는다
		request.setAttribute("main_jsp", "../food/detail.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("food/detail_before.do")
	public String food_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String fno = request.getParameter("fno");
		String page = request.getParameter("page");
		// cookie
		// 1. 로그인된 상태
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		if (id != null) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("food_" + id + "_" + fno)) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			Cookie cookie = new Cookie("food_" + id + "_" + fno, fno);
			cookie.setMaxAge(60 * 60 * 24);
			response.addCookie(cookie);
		}
		// 2. 쿠키 저장
		
		return "redirect:../food/detail.do?fno=" + fno + "&page=" + page;
	}
	
	@RequestMapping("food/find.do")
	public String food_find(HttpServletRequest request, HttpServletResponse response) {
		// 검색어 / 컬럼명 / type 여러개 / 페이지
		/*String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		String[] types = request.getParameterValues("type");
		String column = request.getParameter("column");
		String fd = request.getParameter("fd");
		Map<String, Object> map = new HashMap<>();
		int rowSize = 12;
		int start = (curpage - 1) * rowSize;
		int end = curpage * rowSize;
		map.put("start", start);
		map.put("end", end);
		map.put("fdArr", types);
		map.put("ss", fd);
		map.put("column", column);
		List<FoodVO> list = FoodDAO.foodFindData(map);
		int count = FoodDAO.foodFindCount(map);
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		*/
		request.setAttribute("main_jsp", "../food/find.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("food/find_ajax.do")
	public void food_find_ajax(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		String[] types = request.getParameterValues("type");
		String column = request.getParameter("column");
		String fd = request.getParameter("fd");
		Map<String, Object> map = new HashMap<>();
		int rowSize = 12;
		int start = (curpage - 1) * rowSize + 1;
		int end = curpage * rowSize;
		map.put("start", start);
		map.put("end", end);
		map.put("fdArr", types);
		map.put("ss", fd);
		map.put("column", column);
		List<FoodVO> list = FoodDAO.foodFindData(map);
		for (FoodVO vo : list) {
			String s = vo.getAddress();
			s = s.substring(0, s.indexOf(" "));
			vo.setAddress(s.trim());
		}
		int count = FoodDAO.foodFindCount(map);
		int totalpage = (int) (Math.ceil(count / 12.0));
		
		final int BLOCK = 10;
		int startPage = (curpage - 1) / BLOCK * BLOCK + 1;
		int endPage = (curpage - 1) / BLOCK * BLOCK + BLOCK;
		if (endPage > totalpage) {
			endPage = totalpage;
		}
		int i = 0;
		JSONArray arr = new JSONArray();
		// list = [] JSONArray
		// vo = {} JSONObject
		// fno, name, type, address, poster, likecount, replycount
		for (FoodVO vo : list) {
			JSONObject obj = new JSONObject();
			obj.put("fno", vo.getFno());
			obj.put("name", vo.getName());
			obj.put("type", vo.getType());
			obj.put("address", vo.getAddress());
			obj.put("poster", vo.getPoster());
			obj.put("likecount", vo.getLikecount());
			obj.put("replycount", vo.getReplycount());
			if (i == 0) {
				obj.put("curpage", curpage);
				obj.put("totalpage", totalpage);
				obj.put("startPage", startPage);
				obj.put("endPage", endPage);
				obj.put("count", count);
			}
			arr.add(obj);
		}
		System.out.println(arr.toJSONString());
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(arr.toJSONString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
