package com.sist.model;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;
import com.sist.dao.NoticeDAO;
import com.sist.vo.NoticeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class NoticeModel {
	
	@RequestMapping("notice/list.do")
	public String notice_list(HttpServletRequest request, HttpServletResponse response) {
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
		
		request.setAttribute("main_jsp", "../notice/notice_list.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("notice/detail.do")
	public String notice_detail(HttpServletRequest request, HttpServletResponse response) {
		String no = request.getParameter("no");
		// DB 연동
		NoticeVO vo = NoticeDAO.noticeDetailData(Integer.parseInt(no));
		request.setAttribute("vo", vo);
		
		request.setAttribute("main_jsp", "../notice/notice_detail.jsp");
		return "../main/main.jsp";
	}
	
	@RequestMapping("notice/download.do")
	public void notice_download(HttpServletRequest request, HttpServletResponse response) {
		// 한글 디코딩 => 한글파일일 경우
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) { }
		
		try {
			// 사용자가 보내준 값 받기
			String fn = request.getParameter("fn");
			URL url = this.getClass().getClassLoader().getResource(".");
			File file = new File(url.toURI());
			String path = file.getPath();
			path = path.replace("\\", File.separator);
			// 우분투 => /  윈도우 => \\
			path = path.substring(0, path.lastIndexOf(File.separator));
			path = path.substring(0, path.lastIndexOf(File.separator));
			// C:\webDev\webStudy\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\JSPLastProject
			// 저장 공간
			path = path + File.separator + "uploads";
			File dFile = new File(path + File.separator + fn);
			// header => filename,length
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fn, "UTF-8"));
			response.setContentLength((int) dFile.length());
			// 다운로드 시작
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(dFile));
			// 서버에 존재하는 파일
			BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			// 사용자의 브라우저
			int i = 0;
			byte[] buffer = new byte[1024];
			while ((i = bis.read(buffer, 0, 1024)) != -1) {
				bos.write(buffer, 0, i);
			}
			bis.close();
			bos.close();
		} catch (Exception e) { }
	}

}
