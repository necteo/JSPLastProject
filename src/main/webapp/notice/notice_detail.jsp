<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.detail_row{
  margin: 0px auto;
  width: 850px;
}
.notice-detail-wrap {
  width: 980px;
  margin: 20px auto;
  padding: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 6px 18px rgba(20,24,40,0.06);
}

/* 제목 */
.detail-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0 0 14px;
}

/* 메타 정보 */
.detail-meta {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  padding-bottom: 12px;
  border-bottom: 1px solid #e5e7eb;
  margin-bottom: 18px;
  font-size: 0.9rem;
  color: #4b5563;
}

/* 배지 (공지 종류) */
.badge {
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 0.75rem;
  font-weight: 700;
  border: 1px solid transparent;
}
.badge-maintain {
  background: #fef3c7;
  color: #92400e;
  border-color: #fde68a;
}
.badge-emergency {
  background: #fee2e2;
  color: #b91c1c;
  border-color: #fecaca;
}
.badge-event {
  background: #dbeafe;
  color: #1d4ed8;
  border-color: #bfdbfe;
}
.badge-normal {
  background: #e5e7eb;
  color: #374151;
  border-color: #d1d5db;
}

/* 본문 */
.detail-content {
  line-height: 1.6;
  font-size: 1rem;
  color: #374151;
  padding: 6px 0 20px;
  border-bottom: 1px solid #e5e7eb;
  margin-bottom: 20px;
}

/* 첨부파일 */
.detail-attach {
  margin-bottom: 20px;
}
.attach-title {
  display: inline-block;
  font-weight: 700;
  margin-bottom: 6px;
}
.attach-list {
  margin: 0;
  padding-left: 18px;
}
.attach-list li {
  margin-bottom: 4px;
}
.attach-list a {
  color: #2563eb;
  text-decoration: none;
}
.attach-list a:hover {
  text-decoration: underline;
}

/* 네비 (이전/다음/목록) */
.detail-nav {
  display: flex;
  justify-content: flex-end;
  gap: 8px;
}

.btn {
  padding: 9px 14px;
  background: #f3f4f6;
  border-radius: 8px;
  text-decoration: none;
  color: #111827;
  font-weight: 600;
  transition: 0.12s ease;
}
.btn:hover {
  background: #e5e7eb;
}
.btn.primary {
  background: #2563eb;
  color: white;
}
.btn.primary:hover {
  background: #1e4ed8;
}
</style>
</head>
<body>
 <!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>공지사항 상세보기</h2>
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
            <div class="row justify-content-center">
				<section class="notice-detail-wrap">
				
				  <!-- 제목 -->
				  <h2 class="detail-title">${vo.subject}</h2>
				
				  <!-- 메타 영역 -->
				  <div class="detail-meta">
				  	<c:choose>
				      <c:when test="${vo.state == 'normal'}">
				        <c:set var="state" value="일반"/>
				      </c:when>
				      <c:when test="${vo.state == 'emergency'}">
				        <c:set var="state" value="긴급"/>
				      </c:when>
				      <c:when test="${vo.state == 'maintain'}">
				        <c:set var="state" value="점검"/>
				      </c:when>
				      <c:when test="${vo.state == 'event'}">
				        <c:set var="state" value="이벤트"/>
				      </c:when>
				    </c:choose>
				    <span class="badge badge-${vo.state}">${state}</span>
				    <span class="meta-item">작성자: ${vo.name}</span>
				    <span class="meta-item">등록일: ${vo.dbday}</span>
				    <span class="meta-item">조회수: ${vo.hit}</span>
				  </div>
				
				  <!-- 본문 -->
				  <article class="detail-content">
				    <pre style="white-space: pre-wrap; background-color: white; border: none">${vo.content}</pre>
				  </article>
				
				  <!-- 첨부파일 -->
				  <c:if test="${vo.filecount > 0}">
					<div class="detail-attach">
					  <span class="attach-title">첨부파일</span>
					  <ul class="attach-list">
					    <c:forTokens items="${vo.filename}" delims="," var="files">
					    	<li><a href="../notice/download.do?fn=${files}">${files}</a></li>
					    </c:forTokens>
					  </ul>
					</div>
				  </c:if>
				
				  <!-- 이전 / 다음 / 목록 -->
				  <div class="detail-nav">
				    <a href="../notice/list.do" class="btn primary nav-btn">목록</a>
				  </div>
				</section>
			</div>
		</div>
	</section>

</body>
</html>