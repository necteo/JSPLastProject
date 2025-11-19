package com.sist.model;

import java.io.File;
import java.net.URL;
import java.nio.file.Paths;
import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.AdminDAO;
import com.sist.dao.NoticeDAO;
import com.sist.vo.NoticeVO;
import com.sist.vo.ReserveVO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

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
	
	@RequestMapping("admin/notice_list.do")
	public String admin_notice_list(HttpServletRequest request,HttpServletResponse response) {
		String page = request.getParameter("page");
		if (page == null)
			page = "1";
		int curpage = Integer.parseInt(page);
		int start = (curpage - 1) * 10;
		List<NoticeVO> list = NoticeDAO.noticeListData(start);
		int totalpage = NoticeDAO.noticeTotalPage();
		
		request.setAttribute("list", list);
		request.setAttribute("curpage", curpage);
		request.setAttribute("totalpage", totalpage);

		request.setAttribute("admin_jsp", "../admin/notice_list.jsp");
		return "../admin/admin_main.jsp";
		// forward => request를 유지
		// => Spring / Spring - Boot
	}
	/*
	 *  NO       NOT NULL NUMBER  (X)       
		STATE    NOT NULL VARCHAR2(20)   
		NAME              VARCHAR2(51)  (X)   
		SUBJECT  NOT NULL VARCHAR2(2000) 
		CONTENT  NOT NULL CLOB           
		REGDATE           DATE  (*)
		HIT               NUMBER   (*)      
		FILENAME          VARCHAR2(260)  
		FILESIZE          VARCHAR2(200)
	 */
	@RequestMapping("admin/notice_insert_ok.do")
	public String admin_notice_insert_ok(HttpServletRequest request,HttpServletResponse response) {
		// 관리자 전송 데이터
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String state = request.getParameter("state");
		NoticeVO vo = new NoticeVO();
		vo.setState(state);
		vo.setContent(content);
		vo.setSubject(subject);
		vo.setName("관리자");
		
		try {
			// 파일 업로드
			URL url = this.getClass().getClassLoader().getResource(".");
			File file = new File(url.toURI());
			System.out.println(file.getPath());
			String path = file.getPath();
			path = path.replace("\\", File.separator);
			// 우분투 => /  윈도우 => \\
			path = path.substring(0, path.lastIndexOf(File.separator));
			path = path.substring(0, path.lastIndexOf(File.separator));
			// C:\webDev\webStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPLastProject
			// 저장 공간
			path = path + File.separator + "uploads";
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdir();
			}
			// => realpath
			// 업로드 파일 읽기 => uploads에 저장
			ServletContext context = request.getServletContext();
			// JSP => application객체 => getRealPath
			String uploadPath = context.getRealPath("/uploads");
			boolean bCheck = false;
			/*
			 *   Part
			 *   -----
			 *     Part : text input(name="subject")
			 *     Part : text textarea(name="content")
			 *     Part : file input(file="images")
			 */
			String fn = "";
			String fs = "";
			int count = 0;
			for (Part part : request.getParts()) {
				if ("images".equals(part.getName()) && part.getSize() > 0) {
					bCheck = true;
					// 사용자가 올려준 실제 이미지 이름
					String ofileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
					System.out.println(ofileName);
					String fileName = System.currentTimeMillis() + "_" + ofileName;
					System.out.println(fileName);
					String savePath = uploadPath + File.separator + fileName;
					part.write(savePath);
					
					// DB에 설정
					File dbFile = new File(savePath);
					fn += fileName + ",";
					fs += dbFile.length() + ",";
					count++;
				}
			}
			
			if (bCheck == false) {
				System.out.println("파일 업로드가 없습니다");
			} else {
				fn = fn.substring(0, fn.lastIndexOf(","));
				fs = fs.substring(0, fs.lastIndexOf(","));
			}
			vo.setFilename(fn);
			vo.setFilesize(fs);
			vo.setFilecount(count);
			System.out.println(fn);
			System.out.println(fs);
			
			NoticeDAO.noticeInsert(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:../admin/notice_list.do";
		// sendRedirect => request가 초기화 => 이미 실행된 화면 재수행
	}

	@RequestMapping("admin/notice_insert.do")
	public String admin_notice_insert(HttpServletRequest request,HttpServletResponse response) {

		request.setAttribute("admin_jsp", "../admin/notice_insert.jsp");
		return "../admin/admin_main.jsp";
	}
	
	@RequestMapping("admin/notice_detail.do")
	public String admin_notice_detail(HttpServletRequest request,HttpServletResponse response) {
		// <form> <a> , ajax
		/*
		 *   <a href=".do?no=1">
		 *   <form action="">
		 *   			 ---- 값을 받는다
		 *   => input / select / textarea
		 *   	| hidden 포함
		 *   ajax
		 *     => data:{"no":1} => ?no=1
		 *   axios : Vue / React => fetch
		 *     => params:{"no":1}
		 */
		String no = request.getParameter("no");
		// DB 연동
		NoticeVO vo = NoticeDAO.noticeDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);

		request.setAttribute("admin_jsp", "../admin/notice_detail.jsp");
		return "../admin/admin_main.jsp";
	}
	
}