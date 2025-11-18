package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class NoticeModel {
	
	@RequestMapping("notice/list.do")
	public String notice_list(HttpServletRequest request, HttpServletResponse httpServletResponse) {
		request.setAttribute("main_jsp", "../notice/notice_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("notice/detail.do")
	public String notice_detail(HttpServletRequest request, HttpServletResponse httpServletResponse) {
		request.setAttribute("main_jsp", "../notice/notice_detail.jsp");
		return "../main/main.jsp";
	}

}
