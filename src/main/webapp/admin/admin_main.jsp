<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/adminMain.css">
<style>

body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  background-color: #f5f6fa;
}

/* 전체 레이아웃 */
.admin-container {
  display: grid;
  grid-template-columns: 220px 1fr;
  grid-template-rows: 60px 1fr;
  grid-template-areas:
    "header header"
    "sidebar main";
  height: 100vh;
}

/* 🔹 상단 헤더 */
.admin-header {
  grid-area: header;
  background-color: #2f3640;
  color: #fff;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 25px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.admin-header h1 {
  font-size: 20px;
}

.admin-user span {
  margin-right: 15px;
  font-size: 14px;
}

.admin-user button {
  background: #ff6b81;
  border: none;
  color: white;
  padding: 7px 15px;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.3s;
}

.admin-user button:hover {
  background: #ff4757;
}

/* 🔹 사이드바 */
.admin-sidebar {
  grid-area: sidebar;
  background-color: #353b48;
  color: #fff;
  padding-top: 20px;
}

.admin-sidebar ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.admin-sidebar li {
  margin-bottom: 5px;
}

.admin-sidebar a {
  display: block;
  color: #dcdde1;
  text-decoration: none;
  padding: 12px 20px;
  transition: background 0.3s, color 0.3s;
}

.admin-sidebar li.active a,
.admin-sidebar a:hover {
  background-color: #40739e;
  color: #fff;
}

/* 🔹 메인 콘텐츠 */
.admin-main {
  grid-area: main;
  padding: 30px 40px;
  background-color: #f5f6fa;
  overflow-y: auto;
}

.admin-main h2 {
  margin-top: 0;
  color: #333;
  font-size: 22px;
}

/* 카드형 통계 영역 */
.card-container {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-top: 25px;
}

.card {
  background: white;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  text-align: center;
  transition: transform 0.2s;
}

.card:hover {
  transform: translateY(-5px);
}

.card h3 {
  margin: 0;
  font-size: 16px;
  color: #555;
}

.card p {
  margin-top: 10px;
  font-size: 20px;
  font-weight: 700;
  color: #40739e;
}

/* 최근 등록 회원 테이블 */
.recent-section {
  margin-top: 40px;
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.05);
}

.recent-section table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 10px;
}

.recent-section th, .recent-section td {
  padding: 12px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.recent-section th {
  background-color: #f0f0f0;
  color: #555;
}

 /*반응형*/ 
@media (max-width: 900px) {
  .admin-container {
    grid-template-columns: 1fr;
    grid-template-areas:
      "header"
      "main";
  }

  .admin-sidebar {
    display: none;
  }

  .admin-main {
    padding: 20px;
  }
}


</style>
</head>
<body>

<div class="admin-container">

  <!-- 🔹 상단 헤더 -->
  <header class="admin-header">
    <h1>관리자 페이지</h1>
    <div class="admin-user">
      <span>${sessionScope.name}(${sessionScope.admin == 'y' ? '관리자' : '일반사용자'})님 환영합니다</span>
      <button onclick="location.href='../member/logout.do'">로그아웃</button>
    </div>
  </header>

  <!-- 🔹 좌측 메뉴 -->
  <aside class="admin-sidebar">
    <ul>
      <li class="active"><a href="adminMain.jsp">대시보드</a></li>
      <li><a href="memberList.jsp">회원관리</a></li>
      <li><a href="../admin/notice_list.do">공지관리</a></li>
      <li><a href="../admin/admin_reserve.do">예약관리</a></li>
      <li><a href="boardManage.jsp">묻고답하기관리</a></li>
      <li><a href="stats.jsp">통계관리</a></li>
    </ul>
  </aside>
  <jsp:include page="${admin_jsp}"></jsp:include>
</div>

</body>
</html>