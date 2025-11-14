package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.ReviewDAO;
import com.sist.vo.ReviewVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 *   ReviewVO
 *     |
 *   ReviewDAO / review-mapper.xml => 오라클 연동
 *   ReviewModel => 브라우저 전송
 *     |
 *   ReviewVO
 *   
 *   => Spring Framework
 *      Spring-Boot
 *         |=> ~VO => Vue,React ({}:JSON)
 *    --------------
 *    |			   |
 *   JSP		  ThymeLeaf
 */
@Controller
public class ReviewModel {
	
	@RequestMapping("review/review_insert.do")
	public String review_insert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) { }
		String msg = request.getParameter("msg");
		String cno = request.getParameter("cno");
		String page = request.getParameter("page");
		String type = request.getParameter("type");
		ReviewVO vo = new ReviewVO();
		vo.setCno(Integer.parseInt(cno));
		vo.setMsg(msg);
		vo.setType(Integer.parseInt(type));
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		vo.setId(id);
		vo.setName(name);
		ReviewDAO.reviewInsert(vo);
		String url = "";
		if (Integer.parseInt(type) == 1) {
			url = "redirect:../food/detail.do?fno=" + cno + "&page=" + page;
		} else {
			url = "redirect:../recipe/detail.do?no=" + cno + "&page=" + page;
		}
		return url;
	}
	
	@RequestMapping("review/review_delete.do")
	public String review_delete(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) { }
		String cno = request.getParameter("cno");
		String page = request.getParameter("page");
		String type = request.getParameter("type");
		String no = request.getParameter("no");
		
		ReviewDAO.reviewDelete(Integer.parseInt(no));
		String url = "";
		if (Integer.parseInt(type) == 1) {
			url = "redirect:../food/detail.do?fno=" + cno + "&page=" + page;
		} else {
			url = "redirect:../recipe/detail.do?no=" + cno + "&page=" + page;
		}
		return url;
	}
	
	@RequestMapping("review/review_update.do")
	public String review_update(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) { }
		String msg = request.getParameter("msg");
		String cno = request.getParameter("cno");
		String page = request.getParameter("page");
		String type = request.getParameter("type");
		String no = request.getParameter("no");
		ReviewVO vo = new ReviewVO();
		vo.setMsg(msg);
		vo.setNo(Integer.parseInt(no));
		ReviewDAO.reviewUpdate(vo);
		// DB 연동
		String url = "";
		if (Integer.parseInt(type) == 1) {
			url = "redirect:../food/detail.do?fno=" + cno + "&page=" + page;
		} else {
			url = "redirect:../recipe/detail.do?no=" + cno + "&page=" + page;
		}
		return url;
	}

}
