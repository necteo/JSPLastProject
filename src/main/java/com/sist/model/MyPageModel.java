package com.sist.model;

import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.JjimDAO;
import com.sist.dao.MyPageDAO;
import com.sist.dao.ReserveDAO;
import com.sist.vo.FoodVO;
import com.sist.vo.ReserveVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MyPageModel {
	
    @RequestMapping("mypage/mypage_main.do")
    public String mypage_main(HttpServletRequest request,HttpServletResponse response) {
    	request.setAttribute("mypage_jsp", "../mypage/mypage_home.jsp");
    	request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
    	return "../main/main.jsp";
    }
    
    @RequestMapping("mypage/mypage_reserve.do")
    public String mypage_reserve(HttpServletRequest request,HttpServletResponse response) {
    	HttpSession session = request.getSession();
    	String id = (String) session.getAttribute("id");
    	List<ReserveVO> rList = MyPageDAO.reserveMyPageListData(id);
    	request.setAttribute("rList", rList);
    	
    	request.setAttribute("mypage_jsp", "../mypage/mypage_reserve.jsp");
    	request.setAttribute("main_jsp", "../mypage/mypage_main.jsp");
    	return "../main/main.jsp";
    }
    
    @RequestMapping("mypage/reserve_cancel.do")
    public String mypage_cancel(HttpServletRequest request,HttpServletResponse response) {
    	String no = request.getParameter("no");
    	// DB 연동
    	MyPageDAO.reserveCancel(Integer.parseInt(no));
    	return "redirect:../mypage/mypage_reserve.do";
    }
    
    @RequestMapping("mypage/reserve_detail.do")
	public void reserve_detail(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		ReserveVO vo = MyPageDAO.reserveOkData(Integer.parseInt(no));
		JSONObject obj = new JSONObject();
		obj.put("name", vo.getFvo().getName());
		obj.put("poster", vo.getFvo().getPoster());
		obj.put("address", vo.getFvo().getAddress());
		obj.put("phone", vo.getFvo().getPhone());
		obj.put("parking", vo.getFvo().getParking());
		obj.put("type", vo.getFvo().getType());
		obj.put("score", vo.getFvo().getScore());
		obj.put("no", vo.getNo());
		obj.put("rday", vo.getRday());
		obj.put("dbday", vo.getDbday());
		obj.put("time", vo.getTime());
		obj.put("inwon", vo.getInwon());
		
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(obj.toJSONString());
		} catch (Exception e) { }
	}
    
}