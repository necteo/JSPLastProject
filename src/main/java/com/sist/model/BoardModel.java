package com.sist.model;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.BoardDAO;
import com.sist.dao.BoardReplyDAO;
import com.sist.vo.BoardReplyVO;
import com.sist.vo.BoardVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/*
 *    header.jsp => link
 *    mapper.xml => SQL
 *    DAO => 처리
 *    Model => 브라우저 전송
 *    해당 JSP에서 화면 출력
 *    				   DispatcherServlet(서블릿) 
 *    						  |
 *    				  ------------------
 *    				  |				   |
 *    BoardDAO   BoardModel  ======> JSP출력
 *      |			 |
 *    오라클			브라우저
 *      |			 |
 *      --------------
 *            |
 *         BoardVO : 게시물 한 개에 대한 정보
 */
@Controller
public class BoardModel {
	
	@RequestMapping("board/list.do")
	public String board_list(HttpServletRequest request, HttpServletResponse response) {
		// 사용자가 페이지 요청
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		int rowSize = 10;
		int start = (curpage - 1) * rowSize;
		
		List<BoardVO> list = BoardDAO.boardListData(start);
		int count = BoardDAO.boardTotalPage();
		int totalpage = (int) (Math.ceil(count / 10.0));
		count = count - start;
		
		final int BLOCK = 10;
		int startPage = (curpage - 1) / BLOCK * BLOCK + 1;
		int endPage = (curpage - 1) / BLOCK * BLOCK + BLOCK;
		if (endPage > totalpage)
			endPage = totalpage;
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("today", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		
		request.setAttribute("main_jsp", "../board/list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/insert.do")
	public String board_insert(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("main_jsp", "../board/insert.jsp");
		return "../main/main.jsp";
	}
	/*
	 * https://www.google.com/search?q=%EC%9E%90%EB%B0%94&rlz=1C1FKPE_koKR1170KR1170&oq=wkqk&gs_lcrp=EgZjaHJvbWUqCggBEAAYsQMYgAQyBggAEEUYOTIKCAEQABixAxiABDINCAIQABiDARixAxiABDINCAMQABiDARixAxiABDINCAQQABiDARixAxiABDIHCAUQABiABDIKCAYQABixAxiABDIHCAcQABiABDIHCAgQABiABDIHCAkQABiABNIBCDIxOTFqMGo3qAIAsAIA&sourceid=chrome&ie=UTF-8
	 */
	@RequestMapping("board/insert_ok.do")
	public String board_insert_ok(HttpServletRequest request, HttpServletResponse response) {
		// %EC%9E%90%EB%B0%94
		// 자바
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String pwd = request.getParameter("pwd");
		
		BoardVO vo = new BoardVO();
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		// DAO 연동
		BoardDAO.boardInsert(vo);
		return "redirect:../board/list.do";
	}
	
	@RequestMapping("board/detail.do")
	public String board_detail(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String page = request.getParameter("page");
		String type = request.getParameter("type");
		if (type == null)
			type = "0";
		BoardVO vo = BoardDAO.boardDetailData(Integer.parseInt(no), Integer.parseInt(type));
		
		List<BoardReplyVO> rList = BoardReplyDAO.replyListData(Integer.parseInt(no));
		int rcount = BoardReplyDAO.replyCount(Integer.parseInt(no));
		
		request.setAttribute("rList", rList);
		request.setAttribute("rcount", rcount);
		
		request.setAttribute("vo", vo);
		request.setAttribute("page", page);
		
		request.setAttribute("main_jsp", "../board/detail.jsp");
		return "../main/main.jsp";
	}
	
	/*
	 *  Spring
	 *  ------
	 *  | String : 화면 변경
	 *  		   forward / redirect
	 *    void : JSON
	 */
	@RequestMapping("board/delete.do")
	public void board_delete(HttpServletRequest request, HttpServletResponse response) {
		// 1. 사용자 전송값 {"no":no,"pwd":pwd}
		// 2. => ?no=1&pwd=1234
		// vue => axios => params:{"no":no,"pwd":pwd}
		String no = request.getParameter("no");
		String pwd = request.getParameter("pwd");
		String res = BoardDAO.boardDelete(Integer.parseInt(no), pwd);
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("board/update.do")
	public String board_update(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String page = request.getParameter("page");
		BoardVO vo = BoardDAO.boardUpdateData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		request.setAttribute("page", page);
		
		request.setAttribute("main_jsp", "../board/update.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("board/pwdcheck.do")
	public void board_pwdcheck(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		String pwd = request.getParameter("pwd");
		String res = BoardDAO.boardPwdCheck(Integer.parseInt(no), pwd);
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(res); // VO=>{} , List=>[] => JSON
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("board/update_ok.do")
	public void board_update_ok(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String pwd = request.getParameter("pwd");
		String no = request.getParameter("no");
		
		BoardVO vo = new BoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		String res = BoardDAO.boardUpdate(vo);
		
		try {
			response.setContentType("text/plain; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.write(res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
