package com.sist.model;

import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.JjimDAO;
import com.sist.vo.FoodVO;
import com.sist.vo.JjimVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class JjimModel {
	private String[] urls = {"", "../food/detail.do?fno=", "../recipe/detail.do?no=", "../goods/detail.do?no="};
	
	@RequestMapping("jjim/jjim_insert.do")
	public String jjim_insert(HttpServletRequest request, HttpServletResponse response) {
		String rno = request.getParameter("rno");
		String type = request.getParameter("type");
		String page = request.getParameter("page");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		// DB 연동
		JjimVO vo = new JjimVO();
		vo.setId(id);
		vo.setRno(Integer.parseInt(rno));
		vo.setType(Integer.parseInt(type));
		JjimDAO.jjimInsert(vo);
		
		return "redirect:" + urls[Integer.parseInt(type)] + rno + "&page=" + page;
	}
	
	@RequestMapping("jjim/jjim_list.do")
	public String jjim_list(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		List<JjimVO> list = JjimDAO.jjimFoodListData(id);
		request.setAttribute("list", list);
		request.setAttribute("mypage_jsp", "../mypage/jjim_list.jsp");
		request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("jjim/jjim_cancel.do")
	public String jjim_cancel(HttpServletRequest request, HttpServletResponse response) {
		String jno = request.getParameter("jno");
		// DB연동
		JjimDAO.jjimCancel(Integer.parseInt(jno));
		return "redirect:../jjim/jjim_list.do";
	}
	
	@RequestMapping("jjim/food_detail.do")
	public void jjim_food_detail(HttpServletRequest request, HttpServletResponse response) {
		String fno = request.getParameter("fno");
		FoodVO vo = JjimDAO.foodDetailData(Integer.parseInt(fno));
		JSONObject obj = new JSONObject();
		obj.put("name", vo.getName());
		obj.put("poster", vo.getPoster());
		obj.put("address", vo.getAddress());
		obj.put("phone", vo.getPhone());
		obj.put("price", vo.getPrice());
		obj.put("parking", vo.getParking());
		obj.put("type", vo.getType());
		obj.put("theme", vo.getTheme());
		obj.put("content", vo.getContent());
		obj.put("time", vo.getTime());
		obj.put("score", vo.getScore());
		
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(obj.toJSONString());
		} catch (Exception e) { }
	}
	
}
