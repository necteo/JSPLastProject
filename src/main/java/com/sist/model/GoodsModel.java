package com.sist.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.GoodsDAO;
import com.sist.dao.MemberDAO;
import com.sist.vo.GoodsVO;
import com.sist.vo.MemberVO;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

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
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		List<GoodsVO> cList = new ArrayList<>();
		if (id != null) { // 로그인된 상태
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = cookies.length - 1; i >= 0; i--) {
					if (cookies[i].getName().startsWith("goods_" + id)) {
						String etc = cookies[i].getValue();
						
						// 테이블명 / no
						StringTokenizer st = new StringTokenizer(etc, "_");
						String no = st.nextToken();
						String c = st.nextToken();
						Map<String, String> map1 = new HashMap<>();
						map1.put("no", no);
						map1.put("goods", table_name[Integer.parseInt(c)]);
						GoodsVO vo = GoodsDAO.goodsCookieData(map1);
						cList.add(vo);
					}
				}
				request.setAttribute("cList", cList);
			}
		}
		
		// 화면 출력		
		request.setAttribute("main_jsp", "../goods/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("goods/detail_before.do")
	public String goods_detail_before(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String page = request.getParameter("page");
		String cno = request.getParameter("cno");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		if (id != null) {
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
					if (cookies[i].getName().equals("goods_" + id + "_" + no + "_" + cno)) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			Cookie cookie = new Cookie("goods_" + id + "_" + no + "_" + cno, no + "_" + cno);
			cookie.setMaxAge(60 * 60 * 24);
			response.addCookie(cookie);
		}
		
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
		
		String price = vo.getGoods_price();
		price = price.replaceAll("[^0-9]", ""); // , 원
		vo.setPrice(Integer.parseInt(price));
		
		request.setAttribute("vo", vo);
		request.setAttribute("cno", cno);
		request.setAttribute("page", page);
		
		request.setAttribute("main_jsp", "../goods/detail.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("goods/buy.do")
	public String goods_buy(HttpServletRequest request, HttpServletResponse response) {
		String gno = request.getParameter("gno");
		String account = request.getParameter("account");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		Map<String, Object> map = new HashMap<>();
		map.put("no", gno);
		map.put("goods", "goods_all");
		GoodsVO gvo = GoodsDAO.goodsDetailData(map);
		MemberVO mvo = MemberDAO.memberInfoData(id);
		
		// cart.jsp에 데이터 전송
		// Model => return에 있는 jsp가 받는다
		// => include => 공유가 가능
		request.setAttribute("mvo", mvo);
		request.setAttribute("gvo", gvo);
		request.setAttribute("account", account);
		String strPrice = gvo.getGoods_price();
		strPrice = strPrice.replaceAll("[^0~9]", "");
		// 30,000원 30000  
		int price = Integer.parseInt(strPrice);
		int total = price * Integer.parseInt(account);
		request.setAttribute("total", total);
		return "../goods/cart.jsp";
	}

}
