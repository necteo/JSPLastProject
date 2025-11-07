package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.BoardReplyDAO;
import com.sist.vo.BoardReplyVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
/*					request
 *   JSP ====== 전송 =======> DispatcherServlet
 *   							  |
 *   						   -------------------
 *   							@RequestMapping()
 *   							  | url이 동일
 *   							메소드 호출
 *   						   ------------------Model
 *   							  | request에 출력할 결과값을 담는다
 *   						   DispatcherServlet
 *   							  | request
 *   							 JSP => 출력
 *       <a> : ?id=admin
 *       <form> : id=admin
 *       $.ajax => data:{id:"admin"} => id=admin
 *       axios => params:{id:"admin"} => id=admin
 */
@Controller
public class BoardReplyModel {
	
	@RequestMapping("reply/reply_insert.do")
	public String reply_insert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) { }
		String bno = request.getParameter("bno");
		String page = request.getParameter("page");
		String msg = request.getParameter("msg");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		
		BoardReplyVO vo = new BoardReplyVO();
		vo.setId(id);
		vo.setName(name);
		vo.setMsg(msg);
		vo.setBno(Integer.parseInt(bno));
		
		// DB연동
		BoardReplyDAO.replyInsert(vo);
		/*
		 *  INSERT INTO mvcBoardReply(no,bno,id,name,msg,group_id)
		 *  VALUES(mr_no_seq.nextval, 1, 'hong', '홍길동', '댓글형')
		 */
		return "redirect:../board/detail.do?no=" + bno + "&page=" + page;
	}
	
	@RequestMapping("reply/reply_update.do")
	public String reply_update(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}

		String bno = request.getParameter("bno");
		String page = request.getParameter("page");
		String msg = request.getParameter("msg");
		String no = request.getParameter("no");
		
		// DB 연동
		BoardReplyVO vo = new BoardReplyVO();
		vo.setNo(Integer.parseInt(no));
		vo.setMsg(msg);
		
		BoardReplyDAO.replyUpdate(vo);
		
		return "redirect:../board/detail.do?no=" + bno + "&page=" + page;
	}
	
	@RequestMapping("reply/reply_reply_insert.do")
	public String reply_reply_insert(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {}

		String bno = request.getParameter("bno");
		String page = request.getParameter("page");
		String msg = request.getParameter("msg");
		String no = request.getParameter("pno");
		
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String name = (String) session.getAttribute("name");
		
		BoardReplyVO vo = new BoardReplyVO();
		vo.setBno(Integer.parseInt(bno));
		vo.setId(id);
		vo.setName(name);
		vo.setMsg(msg);
		
		BoardReplyDAO.replyReplyInsert(Integer.parseInt(no), vo);

		return "redirect:../board/detail.do?no=" + bno + "&page=" + page;
	}
	
	@RequestMapping("reply/reply_delete.do")
	public String reply_delete(HttpServletRequest request, HttpServletResponse response) {
		String bno = request.getParameter("bno");
		String page = request.getParameter("page");
		String no = request.getParameter("no");
		
		// DB 연동
		BoardReplyDAO.replyDelete(Integer.parseInt(no));
		
		return "redirect:../board/detail.do?no=" + bno + "&page=" + page;
	}

}
