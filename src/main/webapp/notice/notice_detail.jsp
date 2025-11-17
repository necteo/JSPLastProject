<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.notice-detail-wrap {
  max-width: 980px;
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

/* 모바일 */
@media (max-width: 640px) {
  .notice-detail-wrap {
    margin: 12px;
    padding: 18px;
  }
  .detail-meta {
    gap: 6px;
    font-size: 0.85rem;
  }
  .btn.nav-btn {
    font-size: 0.85rem;
    padding: 8px 12px;
  }
}

</style>
</head>
<body>
<section class="notice-detail-wrap">

  <!-- 제목 -->
  <h2 class="detail-title">서버 점검 안내</h2>

  <!-- 메타 영역 -->
  <div class="detail-meta">
    <span class="badge badge-maintain">점검</span>
    <span class="meta-item">작성자: 관리자</span>
    <span class="meta-item">등록일: 2025-11-10</span>
    <span class="meta-item">조회수: 123</span>
  </div>

  <!-- 본문 -->
  <article class="detail-content">
    <p>
      안녕하세요.<br>
      아래 일정에 따라 시스템 점검이 진행될 예정입니다.<br><br>

      - 점검 일시: 2025년 11월 12일 01:00 ~ 06:00<br>
      - 영향 범위: 로그인 및 일부 서비스 이용 제한<br><br>

      보다 안정적인 서비스를 제공하기 위한 조치이니 양해 부탁드립니다.
    </p>
  </article>

  <!-- 첨부파일 -->
  <div class="detail-attach">
    <span class="attach-title">첨부파일</span>
    <ul class="attach-list">
      <li><a href="#">점검_안내문.pdf</a></li>
      <li><a href="#">서비스중단_공지.png</a></li>
    </ul>
  </div>

  <!-- 이전 / 다음 / 목록 -->
  <div class="detail-nav">
    <a href="#" class="btn nav-btn primary">수정</a>
    <a href="#" class="btn nav-btn primary">삭제</a>
    <a href="#" class="btn primary nav-btn">목록</a>
  </div>
</section>

</body>
</html>