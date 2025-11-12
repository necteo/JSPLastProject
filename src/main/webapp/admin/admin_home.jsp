<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 🔹 메인 콘텐츠 -->
  <main class="admin-main">
    <h2>📊 대시보드</h2>

    <div class="card-container">
      <div class="card">
        <h3>총 회원 수</h3>
        <p>1,240명</p>
      </div>
      <div class="card">
        <h3>오늘 주문 수</h3>
        <p>58건</p>
      </div>
      <div class="card">
        <h3>신규 리뷰</h3>
        <p>32개</p>
      </div>
      <div class="card">
        <h3>방문자 수</h3>
        <p>2,430명</p>
      </div>
    </div>

    <section class="recent-section">
      <h3>📅 최근 등록된 회원</h3>
      <table>
        <tr><th>이름</th><th>이메일</th><th>가입일</th></tr>
        <tr><td>홍길동</td><td>hong@test.com</td><td>2025-11-10</td></tr>
        <tr><td>이영희</td><td>lee@test.com</td><td>2025-11-09</td></tr>
        <tr><td>박철수</td><td>park@test.com</td><td>2025-11-09</td></tr>
      </table>
    </section>

  </main>
</body>
</html>