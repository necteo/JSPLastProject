<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%--
	session.setAttribute("id", "admin");
	session.setAttribute("name", "박문수");
	session.setAttribute("admin", "n");
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	// vue => mounted()
	$('#logBtn').click(function() {
		let id = $('#id').val()
		let pwd = $('#pwd').val()
		if (id.trim() === '') {
			$('#id').focus()
			return
		}
		// 서버로 전송 => 결과값 받기 => Ajax (Vue,React)
		// JSON => XML을 대체
		// 자바 => XML을 대체 (어노테이션)
		$.ajax({
			type: 'post',
			url: '../member/login.do',
			data: {
				'id': id,
				'pwd': pwd
			},
			success: function(result) {
				if (result === 'NOID') {
					alert('아이디가 존재하지 않습니다')
					$('#id').val('')
					$('#pwd').val('')
					$('#id').focus()
				} else if (result === 'NOPWD') {
					alert('비밀번호가 틀립니다')
					$('#pwd').val('')
					$('#pwd').focus()
				} else if (result == 'OK') {
					location.href = '../main/main.do'
				}
			},
			error: function(error) {
				console.log(error)
			}
		})
	})
})
</script>
</head>
<body>
<!-- ****** Top Header Area Start ****** -->
    <div class="top_header_area">
        <div class="container">
            <div class="row">
                <div class="col-5 col-sm-6">
                    <!--  Top Social bar start -->
                    <div class="top_social_bar">
                        <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                        <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                        <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                        <a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a>
                        <a href="#"><i class="fa fa-dribbble" aria-hidden="true"></i></a>
                    </div>
                </div>
                <!--  Login Register Area -->
                <div class="col-7 col-sm-6">
                    <div class="signup-search-area d-flex align-items-center justify-content-end">
                        <div class="login_register_area d-flex">
                          <%-- session.getAttribute("id") --%>
                          <c:if test="${sessionScope.id == null}">
                            <div class="login">
	                              <input type="text" name="id" id="id" placeholder="아이디 입력" class="input-sm">
	                              <input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력" class="input-sm">
	                              <input type="submit" value="로그인" class="btn-sm btn-danger" id="logBtn">
                            </div>
                          </c:if>
                          <c:if test="${sessionScope.id != null}">
                            <div class="login">
                                <form action="../member/logout.do" method="post">
                                	${sessionScope.name}(${sessionScope.admin == 'y' ? '관리자' : '일반사용자'})님 로그인되었습니다
	                              <input type="submit" value="로그아웃" class="btn-sm btn-danger">
                                </form>
                            </div>
                          </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Top Header Area End ****** -->

    <!-- ****** Header Area Start ****** -->
    <header class="header_area">
        <div class="container">
            <div class="row">
                <!-- Logo Area Start -->
                <div class="col-12">
                    <div class="logo_area text-center">
                        <a href="../main/main.do" class="yummy-logo">Food & Recipe & Goods</a>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <nav class="navbar navbar-expand-lg">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#yummyfood-nav" aria-controls="yummyfood-nav" aria-expanded="false" aria-label="Toggle navigation"><i class="fa fa-bars" aria-hidden="true"></i> Menu</button>
                        <!-- Menu Area Start -->
                        <div class="collapse navbar-collapse justify-content-center" id="yummyfood-nav">
                            <ul class="navbar-nav" id="yummy-nav">
                                <li class="nav-item active">
                                    <a class="nav-link" href="../main/main.do">Home <span class="sr-only">(current)</span></a>
                                </li>
                                <c:if test="${sessionScope.id == null}">
	                                <li class="nav-item dropdown">
	                                    <a class="nav-link dropdown-toggle" href="#" id="yummyDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">회원</a>
	                                    <div class="dropdown-menu" aria-labelledby="yummyDropdown">
	                                        <a class="dropdown-item" href="../member/join.do">회원가입</a>
	                                        <%-- 아이디 찾기 : RPAD --%>
	                                        <a class="dropdown-item" href="archive.html">아이디찾기</a>
	                                        <%-- JavaMail 라이브러리 --%>
	                                        <a class="dropdown-item" href="single.html">비밀번호찾기</a>
	                                    </div>
	                                </li>
                                </c:if>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="yummyDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">맛집</a>
                                    <div class="dropdown-menu" aria-labelledby="yummyDropdown">
                                        <a class="dropdown-item" href="../food/list.do">맛집 목록</a>
                                        <%-- 지도 이용 --%>
                                        <a class="dropdown-item" href="../food/find.do">맛집 찾기</a>
                                        <c:if test="${sessionScope.id != null && sessionScope.admin == 'n'}">
	                                        <a class="dropdown-item" href="single.html">맛집 예약</a>
	                                        <%-- 네이버 카페 / 블로그 : 형태소 분석 --%>
	                                        <a class="dropdown-item" href="single.html">맛집 추천</a>
                                        </c:if>
                                    </div>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="yummyDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">레시피</a>
                                    <div class="dropdown-menu" aria-labelledby="yummyDropdown">
                                        <a class="dropdown-item" href="../recipe/list.do">레시피 목록</a>
                                        <a class="dropdown-item" href="../recipe/chef_list.do">쉐프</a>
                                        <c:if test="${sessionScope.id != null && sessionScope.admin == 'n'}">
                                        	<a class="dropdown-item" href="single.html">레시피 등록</a>
                                        </c:if>
                                        <a class="dropdown-item" href="single.html">레시피 검색</a>
                                    </div>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="yummyDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">스토어</a>
                                    <div class="dropdown-menu" aria-labelledby="yummyDropdown">
                                        <a class="dropdown-item" href="../goods/list.do?cno=1">전체 상품</a>
                                        <a class="dropdown-item" href="../goods/list.do?cno=3">신상품</a>
                                        <a class="dropdown-item" href="../goods/list.do?cno=2">베스트 상품</a>
                                        <a class="dropdown-item" href="../goods/list.do?cno=4">특가 상품</a>
                                    </div>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="yummyDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">커뮤니티</a>
                                    <div class="dropdown-menu" aria-labelledby="yummyDropdown">
                                        <a class="dropdown-item" href="index.html">공지사항</a>
                                        <a class="dropdown-item" href="../board/list.do">자유게시판</a>
                                        <c:if test="${sessionScope.id != null && sessionScope.admin == 'n'}">
                                        <a class="dropdown-item" href="single.html">묻고답하기</a>
                                        <a class="dropdown-item" href="single.html">후기게시판</a>
                                        </c:if>
                                    </div>
                                </li>
                                <c:if test="${sessionScope.id!=null && sessionScope.admin=='n' }">
                                <li class="nav-item">
                                    <a class="nav-link" href="#">빠른 예약</a>
                                </li>
                                </c:if>
                                <c:if test="${sessionScope.id!=null && sessionScope.admin=='n' }">
                                <li class="nav-item">
                                    <a class="nav-link" href="../chat/chat.do">실시간채팅</a>
                                </li>
                                </c:if>
                                <c:if test="${sessionScope.id!=null && sessionScope.admin=='n' }">
                                <li class="nav-item">
                                    <a class="nav-link" href="../mypage/mypage_main.do">마이페이지</a>
                                </li>
                                </c:if>
                                <c:if test="${sessionScope.id!=null && sessionScope.admin=='y' }">
                                <li class="nav-item">
                                    <a class="nav-link" href="../admin/admin_main.do">관리자페이지</a>
                                </li>
                                </c:if>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ****** Header Area End ****** -->
</body>
</html>