<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 컨테이너 */
.notice-table-wrap {
  width: 980px;
  margin: 20px auto;
  background: #fff;
  border-radius: 12px;
  padding: 18px;
  box-shadow: 0 6px 18px rgba(20,24,40,0.06);
}

/* 제목 */
.notice-title {
  font-size: 1.25rem;
  margin-bottom: 12px;
  font-weight: 700;
}

/* 테이블 기본 */
.notice-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.95rem;
}

.notice-table th {
  background: #f3f4f6;
  padding: 12px 10px;
  border-bottom: 2px solid #e5e7eb;
  text-align: center;
  font-weight: 600;
}

.notice-table td {
  padding: 12px 10px;
  border-bottom: 1px solid #e5e7eb;
  text-align: center;
}

/* 제목 좌측 정렬 */
.title-cell {
  text-align: left;
}

.title-cell a {
  text-decoration: none;
  font-weight: 600;
  color: #1f2937;
}

.title-cell a:hover {
  color: #2563eb;
}

/* 컬럼 너비 */
.col-no { width: 60px; }
.col-type { width: 90px; }
.col-title { width: auto; }
.col-writer { width: 120px; }
.col-date { width: 130px; }
.col-view { width: 90px; }

/* 행 hover */
.notice-table tbody tr:hover {
  background: #f9fafb;
}

/* =============== 공지 종류별 배지 스타일 =============== */

.badge {
  display: inline-block;
  padding: 4px 10px;
  border-radius: 999px;
  font-size: 0.75rem;
  font-weight: 700;
  border: 1px solid transparent;
}

/* 긴급 */
.badge-emergency {
  color: #b91c1c;
  background: #fee2e2;
  border-color: #fecaca;
}

/* 점검 */
.badge-maintain {
  color: #92400e;
  background: #fef3c7;
  border-color: #fde68a;
}

/* 이벤트 */
.badge-event {
  color: #1d4ed8;
  background: #dbeafe;
  border-color: #bfdbfe;
}

/* 일반 */
.badge-normal {
  color: #374151;
  background: #e5e7eb;
  border-color: #d1d5db;
}

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

/* 반응형 */
@media (max-width: 640px) {
  .col-writer, .col-view {
    display: none;
  }
}
</style>
</head>
<body>
<section class="notice-table-wrap">
  <h2 class="notice-title">공지사항</h2>
  <div class="detail-nav">
    <a href="../admin/notice_insert.do" class="btn primary nav-btn">등록</a>
  </div>
  <div style="height: 10px"></div>
  <table class="notice-table">
    <thead>
      <tr>
        <th class="col-no">번호</th>
        <th class="col-type">종류</th>
        <th class="col-title">제목</th>
        <th class="col-writer">작성자</th>
        <th class="col-date">등록일</th>
        <th class="col-view">조회수</th>
      </tr>
    </thead>
	  <%--
        <option value="normal">일반</option>
        <option value="emergency">긴급</option>
        <option value="maintain">점검</option>
        <option value="event">이벤트</option>
	   --%>
    <tbody>
      <c:forEach var="vo" items="${list}">
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
      <tr>
        <td>${vo.no}</td>
        <td><span class="badge badge-${vo.state}">${state}</span></td>
        <td class="title-cell"><a href="../admin/notice_detail.do?no=${vo.no}">${vo.subject}</a></td>
        <td>${vo.name}</td>
        <td>${vo.dbday}</td>
        <td>${vo.hit}</td>
      </tr>
      </c:forEach>
      <tr>
        <td colspan="6" class="text-center">
          <a href="../admin/notice_list.do?page=${curpage > 1 ? curpage - 1 : curpage}">이전</a>
          ${curpage} page / ${totalpage} pages
          <a href="../admin/notice_list.do?page=${curpage < totalpage ? curpage + 1 : curpage}">다음</a>
        </td>
      </tr>
    </tbody>
  </table>
</section>

</body>
</html>