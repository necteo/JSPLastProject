package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AdminModel {
  @RequestMapping("admin/admin_main.do")
  public String mypage_main(HttpServletRequest request,HttpServletResponse response)
  {
	  //request.setAttribute("main_jsp", "../admin/admin_main.jsp");
	  return /*"../main/main.jsp"*/ "../admin/admin_main.jsp";
  }
}