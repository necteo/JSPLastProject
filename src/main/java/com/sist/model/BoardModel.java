package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class BoardModel {
	
	@RequestMapping("board/list.do")
	public String board_list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/insert.do")
	public String board_insert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/insert.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/detail.do")
	public String board_detail(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/detail.jsp");
		return "../main/main.jsp";
	}

}
