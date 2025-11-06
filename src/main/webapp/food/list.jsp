<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/cookie.css">
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>맛집 목록</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="breadcumb-nav">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                        	<%-- 검색기 --%>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ****** -->
    <section class="archive-area section_padding_80">
        <div class="container">
            <div class="row">
				<c:forEach var="vo" items="${list}">
	                <!-- Single Post -->
	                <div class="col-12 col-md-6 col-lg-4">
	                    <div class="single-post wow fadeInUp" data-wow-delay="1.2s">
	                        <!-- Post Thumb -->
	                        <div class="post-thumb">
	                          <a href="../food/detail_before.do?fno=${vo.fno}&page=${curpage}">
	                            <img src="${vo.poster}">
	                          </a>
	                        </div>
	                        <!-- Post Content -->
	                        <div class="post-content">
	                            <div class="post-meta d-flex">
	                                <div class="post-author-date-area d-flex">
	                                    <!-- Post Author -->
	                                    <div class="post-author">
	                                        <a href="#">${vo.type}</a>
	                                    </div>
	                                    <!-- Post Date -->
	                                    <div class="post-date">
	                                        <a href="#">${vo.address}</a>
	                                    </div>
	                                </div>
	                                <!-- Post Comment & Share Area -->
	                                <div class="post-comment-share-area d-flex">
	                                    <!-- Post Favourite -->
	                                    <div class="post-favourite">
	                                        <a href="#"><i class="fa fa-heart-o" aria-hidden="true"></i> ${vo.likecount}</a>
	                                    </div>
	                                    <!-- Post Comments -->
	                                    <div class="post-comments">
	                                        <a href="#"><i class="fa fa-comment-o" aria-hidden="true"></i> ${vo.replycount}</a>
	                                    </div>
	                                    <!-- Post Share -->
	                                    <div class="post-share">
	                                        <a href="#"><i class="fa fa-share-alt" aria-hidden="true"></i></a>
	                                    </div>
	                                </div>
	                            </div>
	                            <a href="../food/detail_before.do?fno=${vo.fno}&page=${curpage}">
	                                <h4 class="post-headline">${vo.name}</h4>
	                            </a>
	                        </div>
	                    </div>
	                </div>
				</c:forEach>
				<%-- end --%>
                <div class="col-12">
                    <div class="pagination-area d-sm-flex mt-15">
                        <nav aria-label="#">
                            <ul class="pagination">
                            	<c:if test="${startPage > 1}">
	                            	<li class="page-item">
	                                    <a class="page-link" href="../food/list.do?page=${startPage - 1}">이전 <i class="fa fa-angle-double-left" aria-hidden="true"></i></a>
	                                </li>
                                </c:if>
                                
                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                	<li class="page-item ${i == curpage ? 'active' : '' }"><a class="page-link" href="../food/list.do?page=${i}">${i}</a></li>
                                </c:forEach>
                                
                                <c:if test="${endPage < totalpage}">
                                <li class="page-item">
                                    <a class="page-link" href="../food/list.do?page=${endPage + 1}">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>
                                </li>
                                </c:if>
                            </ul>
                        </nav>
                        <div class="page-status">
                            <p>Page ${curpage} of ${totalpage} results</p>
                        </div>
                    </div>
                </div>

            </div>
            <c:if test="${sessionScope.id != null}">
            <div class="row" style="margin-top: 20px">
              <div class="recent-container">
                <h3>최근 방문 맛집</h3>
                <div class="recent-list">
                  <c:set var="i" value="0"/>
                  <c:forEach var="vo" items="${cList}">
                    <c:if test="${i < 9}">
                    <a class="recent-card">
                      <div class="thumb">
                        <img src="${vo.poster}">
                      </div>
                      <div class="meta">
                        <div class="title">${vo.name}</div>
                      </div>
                    </a>
                    </c:if>
                    <c:set var="i" value="${i + 1}"/>
                  </c:forEach>
                </div>
              </div>
            </div>
            </c:if>
        </div>
    </section>
    <!-- ****** Archive Area End ****** -->
</body>
</html>