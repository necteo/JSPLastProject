package com.sist.model;

import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.AdminDAO;
import com.sist.vo.ReserveVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AdminModel {
	
	@RequestMapping("admin/admin_main.do")
	public String admin_main(HttpServletRequest request,HttpServletResponse response) {
		request.setAttribute("admin_jsp", "../admin/admin_home.jsp");
		return "../admin/admin_main.jsp";
	}
	
	@RequestMapping("admin/admin_reserve.do")
	public String admin_reserve(HttpServletRequest request,HttpServletResponse response) {
		List<ReserveVO> rList = AdminDAO.reserveAdminListData();
		request.setAttribute("rList", rList);
		request.setAttribute("admin_jsp", "../admin/admin_reserve.jsp");
		return "../admin/admin_main.jsp";
	}
	
	@RequestMapping("admin/reserve_ok.do")
	public String admin_reserve_ok(HttpServletRequest request,HttpServletResponse response) {
		String no = request.getParameter("no");
		// => DB 연동
		AdminDAO.reserveOk(Integer.parseInt(no));
		return "redirect:../admin/admin_reserve.do";
	}
	
}