package com.sist.model;

import java.io.PrintWriter;
import java.util.*;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.LIkeDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class LikeModel {
	private String[] tables = {"", "menupan_food", "recipe", "goods_all"};
	private String[] checks = {"", "fno", "no", "no"};
	
	@RequestMapping("like/likeOn.do")
	public void like_on(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String rno = request.getParameter("rno"); // 번호
		String type = request.getParameter("type"); // 구분자
		Map<String, Object> map = new HashMap<>();
		map.put("type", Integer.parseInt(type));
		map.put("rno", Integer.parseInt(rno));
		map.put("id", id);
		map.put("table", tables[Integer.parseInt(type)]);
		map.put("checks", checks[Integer.parseInt(type)]);
		// DAO 연동
		int result = LIkeDAO.likeOn(map);
		try {
			PrintWriter out = response.getWriter();
			out.write(String.valueOf(result));
		} catch (Exception e) { }
	}
	
	@RequestMapping("like/likeOff.do")
	public void like_off(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String rno = request.getParameter("rno"); // 번호
		String type = request.getParameter("type"); // 구분자
		Map<String, Object> map = new HashMap<>();
		map.put("type", Integer.parseInt(type));
		map.put("rno", Integer.parseInt(rno));
		map.put("id", id);
		map.put("table", tables[Integer.parseInt(type)]);
		map.put("checks", checks[Integer.parseInt(type)]);
		// DAO 연동
		int result = LIkeDAO.likeOff(map);
		try {
			PrintWriter out = response.getWriter();
			out.write(String.valueOf(result));
		} catch (Exception e) { }
	}
	
	@RequestMapping("like/likeCheck.do")
	public void like_check(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String rno = request.getParameter("rno"); // 번호
		String type = request.getParameter("type"); // 구분자
		Map<String, Object> map = new HashMap<>();
		map.put("type", Integer.parseInt(type));
		map.put("rno", Integer.parseInt(rno));
		map.put("id", id);
		
		int count = LIkeDAO.likeCheck(map);
		try {
			PrintWriter out = response.getWriter();
			if (count == 0) {
				out.write("NO");
			} else {
				out.write("OK");
			}
		} catch (Exception e) { }
	}

}
