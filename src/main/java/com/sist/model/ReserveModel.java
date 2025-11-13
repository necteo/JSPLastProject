package com.sist.model;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.ReserveDAO;
import com.sist.vo.FoodVO;
import com.sist.vo.ReserveVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReserveModel {
	
	@RequestMapping("reserve/reserve_main.do")
    public String reserve_main(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../reserve/reserve_main.jsp");
	    return "../main/main.jsp";
    }
	
	@RequestMapping("reserve/reserve_food.do")
	public String reserve_food(HttpServletRequest request, HttpServletResponse response) {
		String type = request.getParameter("type");
		List<FoodVO> list = ReserveDAO.reserveFoodListData(type);
		request.setAttribute("list", list);
		return "../reserve/reserve_food.jsp";
	}
	
	@RequestMapping("reserve/reserve_date.do")
	public String reserve_date(HttpServletRequest request, HttpServletResponse response) {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
		String today = sdf.format(date);
		StringTokenizer st = new StringTokenizer(today, "-");
		int year = Integer.parseInt(st.nextToken());
		int month = Integer.parseInt(st.nextToken());
		int day = Integer.parseInt(st.nextToken());
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.DATE, 1);
		int week = cal.get(Calendar.DAY_OF_WEEK); // 요일 구하기
		week = week - 1;
		int lastday = cal.getActualMaximum(Calendar.DATE);
		
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("day", day);
		request.setAttribute("week", week);
		request.setAttribute("lastday", lastday);
		String[] weeks = {"일", "월", "화", "수", "목", "금", "토"};
		request.setAttribute("weeks", weeks);
		return "../reserve/reserve_date.jsp";
	}
	
	@RequestMapping("reserve/reserve_time.do")
	public String reserve_time(HttpServletRequest request, HttpServletResponse response) {
		String day = request.getParameter("day");
		String times = ReserveDAO.reserveDateTimes(Integer.parseInt(day));
		
		List<String> tList = new ArrayList<>();
		StringTokenizer st = new StringTokenizer(times, ",");
		while (st.hasMoreTokens()) {
			String time = ReserveDAO.reserveTime(Integer.parseInt(st.nextToken()));
			tList.add(time);
		}
		request.setAttribute("tList", tList);
		return "../reserve/reserve_time.jsp";
	}
	
	@RequestMapping("reserve/reserve_inwon.do")
	public String reserve_inwon(HttpServletRequest request, HttpServletResponse response) {
		return "../reserve/reserve_inwon.jsp";
	}
	
	@RequestMapping("reserve/reserve_insert.do")
	public String reserve_insert(HttpServletRequest request, HttpServletResponse response) {
		String fno = request.getParameter("fno");
		String day = request.getParameter("day");
		String time = request.getParameter("time");
		String inwon = request.getParameter("inwon");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		ReserveVO vo = new ReserveVO();
		vo.setId(id);
		vo.setFno(Integer.parseInt(fno));
		vo.setRday(day);
		vo.setTime(time);
		vo.setInwon(inwon);
		vo.setOk(0);
		// DB 연동
		ReserveDAO.reserveInsert(vo);
		return "redirect:../mypage/mypage_reserve.do";
	}
	
}