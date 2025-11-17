<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
/* 컨테이너 */
.notice-table-wrap {
  max-width: 980px;
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

    <tbody>
      <tr>
        <td>15</td>
        <td><span class="badge badge-emergency">긴급</span></td>
        <td class="title-cell"><a href="#">서버 장애 발생 안내</a></td>
        <td>관리자</td>
        <td>2025-11-11</td>
        <td>342</td>
      </tr>

      <tr>
        <td>14</td>
        <td><span class="badge badge-maintain">점검</span></td>
        <td class="title-cell"><a href="#">11월 시스템 점검 일정</a></td>
        <td>관리자</td>
        <td>2025-11-02</td>
        <td>132</td>
      </tr>

      <tr>
        <td>13</td>
        <td><span class="badge badge-event">이벤트</span></td>
        <td class="title-cell"><a href="#">블랙프라이데이 할인 안내</a></td>
        <td>마케팅팀</td>
        <td>2025-11-01</td>
        <td>88</td>
      </tr>

      <tr>
        <td>12</td>
        <td><span class="badge badge-normal">일반</span></td>
        <td class="title-cell"><a href="#">새로운 기능 업데이트</a></td>
        <td>관리자</td>
        <td>2025-10-29</td>
        <td>201</td>
      </tr>
    </tbody>
  </table>
</section>

</body>
</html>