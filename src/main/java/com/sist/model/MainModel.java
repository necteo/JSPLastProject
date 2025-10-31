package com.sist.model;

import com.sist.controller.Controller;
import com.sist.controller.RequestMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/*
 *    JSP(Java Server Pages)
 *    JSP
 *     1) 자바기반의 서버사이드 웹 기술
 *     2) HTML내부에 자바코드를 첨부해서 동적페이지 생성
 *     3) Servlet을 쉽게 작성하기 위한 표현 언어
 *     4) JSP 파일은 _jspService()메소드 영역
 *    1. JSP 구성요소
 *     1) 선언문
 *     	  <%! %> : 멤버변수 , 메소드 선언
 *     2) 스크립트릿
 *     	  <%  %> : 실행 코드 => _jspService(){여기에 첨부}
 *     3) 표현식
 *        <%= %> : 데이터를 화면에 출력
 *        => 변경 : out.println(<%=%>) => ;을 사용할 수 없다
 *     4) 주석 : <%-- --%> 사라진다 <!-- -->는 남아있다
 *     				| 자바 포함	   | HTML만 주석
 *    2. JSP의 지시자
 *       <%@ page %> : JSP파일에 대한 정보
 *       			   속성
 *        				= contentType : 변환
 *        				   => 브라우저 실행
 *        				   => HTML : text/html;charset=UTF-8
 *        				   => XML : text/xml;charset=UTF-8
 *        				   => JSON text/plain;charset=UTF-8
 *        				= import : 필요한 라이브러리 읽기
 *        				  <%@ page import="java.util.*"%>
 *        				  <%@ page import="java.util.*,java.io.*"%>
 *        				= errorPage : 에러발생시 이동하는 파일을 설정
 *        				  errorPage="error.jsp"
 *        				  => 기본 : forward를 사용하고 있다
 *        				  *** URL주소 (request를 가지고 있다)
 *        				= a.jsp ==> b.jsp
 *        						 | request 초기화
 *        				= a.jsp
 *        				   => b.jsp포함
 *       ***<%@ taglib %> : JSP에서 자바를 제거하기 위해 사용
 *       						--------
 *       						| 자바 기능을 가지고 있어야 한다
 *       						  -------
 *       						  제어문 / 변환 / 함수
 *       						  -----	 ----  ---
 *       									   | functions
 *       								 | format
 *       						  | core
 *       
 *       			   <%@ taglib prefix="c" uri="jakarta.tags.core"%>
 *       									 | 라이브러리 읽기
 *       						  | 사용자 지정 => 시작태그
 *       						  <c:set> : 변수 선언
 *       						   | request.setAttribute
 *       						  <c:forEach> : 반복문
 *       						  <c:if> : 조건문 (<c:else>존재하지 않는다)
 *       						  <c:redirect> : sendRedirect
 *       						  <c:choose> : 다중 조건문
 *       			   <%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
 *       						  <%= ((MemberVO) request.getAttribute("vo")).getName()%>
 *       						  ${vo.name}
 *       						  <fmt:formatDate pettern="yyyy-MM-dd"/>
 *       						  <fmt:formatNumber pettern="#,###,###"/>
 *       						  => toLocalString() : JavaScript
 *       			   <%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
 *       						  ${fn:substring()} => String메소드 (문자열 제어)
 *       <%@ include %> : 특정 JSP부분에 다른 JSP를 첨부
 *       				  <%@ include file="파일명"%>
 *       							  ------------
 *       							  | 변수를 사용할 수 없다
 *       							  | 파일 고정
 *       				  => 정적페이지
 *       				  => 소스+소스 = 컴파일
 *       				  => 동적
 *       					 <jsp:include page="">
 *       					 ---------------------
 *       					 소스  소스
 *       					  |    |
 *       					 컴파일 컴파일
 *        					  |	    |
 *        					  -------
 *        						 |
 *        						HTML
 *    3. JSP 동작
 *    	 1) 클라이언트(사용자)가 .jsp요청
 *    		.jsp 파일 제작
 *    	 2) 톰캣 => 서블릿으로 변경
 *    		a.jsp => a_jsp.java
 *       3) 컴파일 => a_jsp.class
 *       4) 실행 => 메모리에 HTML만 출력
 *       5) 브라우저에서 한줄씩 읽어서 출력
 *       ----------------- 자동 처리
 *    4. 내장 객체
 *       request => HttpServletRequest
 *         = 사용자 요청정보를 가지고 있다
 *         		 | 사용자가 보내주는 모든 데이터를 가지고 있다
 *         = session / cookie 읽기
 *         => 주요메소드
 *         	  사용자 요청값 받기
 *         	  getParameter() => getParameterValues()
 *            getSession()
 *            getCookies()
 *            데이터 추가
 *            setAttribute() / getAttribute()
 *       response => HttpServletResponse
 *         = 응답 정보 => 브라우저 전송
 *           | HTML / Cookie
 *           		  | addCookie()
 *             | setContentType("text/html")
 *         = 화면 서버에서 이동
 *           sendRedirect()
 *         = 사전에 데이터 전송
 *           setHeader() => 다운로드
 *       session => HttpSession
 *         = 상태 유지 (데이터 유지 => JSP전체에서 공유)
 *         = 서버에 저장
 *         = 저장 : setAttribute()
 *         = 읽기 : getAttribute()
 *         = 삭제 : removeAttribute() : 일부 삭제
 *         		     => 장바구니
 *         		   invalidate() : 전체 삭제
 *         			 => 로그아웃
 *         = 저장 기간 : setMaxactiveInterval(초단위)
 *         			 => 1800초 : 30분
 *         			 => 경매
 *       pageContext => PageContext
 *         = include() , forward()
 *         = 웹 흐름 제어 => request => 공유
 *         = <jsp:include> <jsp:forward>
 *       application => ServletContext
 *         = 서버 정보
 *         = getResource() / getRealPath()
 *       out => JspWriter
 *         = <%= %> , ${}
 *    5. Cookie
 *       => 브라우저에 저장
 *       => 문자열만 저장이 가능
 *       => 보안이 취약하다 => 최신방문 / 장바구니
 *       => 생성
 *          Cookie cookie=new Cookie(키,값)
 *       => 저장 기간
 *       	cookie.setMaxAge(초) => 60*60*24
 *       	** setMaxAge(0) => 삭제
 *       => 브라우저 전송
 *       	response.addCookie(cookie)
 *       => 쿠키 읽기
 *          Cookie[] cookies=request.getCookies()
 *          ** 키 읽기 : getName()
 *          ** 값 읽기 : getValue()
 *    6. EL (화면에 데이터 출력)
 *       ${} : 형식
 *       ${param.키} => request.getParameter("name")
 *         => ${param.name}
 *       ${requestScope.키} => request.getAttribute("no")
 *         => ${requestScope.no}
 *         => ${no} => requestScope.는 생략이 가능
 *       ${sessionScope.키} => session.getAttribute("id")
 *         => ${sessionScope.id}
 *       => 연산자 : 숫자 / 문자 / 날짜
 *       	산술 : + , - , * , / , %
 *       		 ===================
 *       		 1) null값이 있는 경우 => null+1 => null값은 자동으로 0으로 취급
 *       		 2) + 는 순수하게 더하기 기능만 있다
 *        			** 문자열 결합 +=
 *        		 3) /는 정수/정수=실수
 *          비교연산자 : == , !- , < , > , <= , >=
 *          		  한글 / 알파벳
 *          				| ABCD...
 *          		  | 가나다라...
 *          논리연산자 : && , ||
 *    ----------------------------------- Model 1방식
 *    JSP = JSP : Java + HTML
 *    --------- 1. 확장이 어렵다
 *    			2. 재사용을 할 수 없다
 *    			3. 보안에 취약 : 소스 노출
 *    			   *** Front-End (화면 출력용)
 *    			4. 자바가 포함 => 디자인 / 출력
 *    			--------------- 보완 (MVC) => Model 2
 *    => 확장석 / 재사용 / 전문성 => MVC
 *    MVC => 스트럿츠 / 스프링
 *    				 | 모든 언어가 가능
 *    		 | 자바 전용
 *     | 역할 분리 => 유지보수와 확장성을 높이는 설계 패턴
 *       MV => MVC
 *       	   -- Model + View + Controller
 *       						 ---------- 자바/HTML매칭
 *       						 | Servlet으로 제작 : 요청 = Model = 응답 = View
 *       				  | Model에서 보낸값을 출력 : JSP/HTML
 *       										---------
 *       										ThymeLeaf
 *       		  | 비지니스 로직 => VO , DAO , Manager , Service
 *       		  | 요청 => 처리 => 응답
 *       -- Model + View
 *    실행 순서
 *    사용자 요청 (브라우저)
 *    	  | list.do
 *     **Controller
 *     	  | 1. Model찾기 (class , method)
 *     	  | 2. 사용자 요청값 전송 => request
 *     해당 Model
 *     	  | 요청값 받기
 *     	  | 데이터 연동
 *     	  | 결과값을 request(session)에 담는다
 *     		=> request.setAttribute()
 *     **Controller
 *     	  | Model에서 보내준 request를 가지고 온다
 *     View (JSP)
 *     	  | Controller가 보내준 request를 이용해 화면 출력
 *     
 *     ** Controller 제어 => .xml
 *        => DI / AOP
 */
@Controller
public class MainModel {
	
  @RequestMapping("main/main.do")
  public String main_main(HttpServletRequest request, HttpServletResponse response) {
	  // main_jsp => 화면 
	  request.setAttribute("main_jsp", "../main/home.jsp");
	  return "../main/main.jsp";
  }
  
}
