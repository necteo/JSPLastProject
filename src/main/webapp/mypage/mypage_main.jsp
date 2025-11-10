<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 예시용 세션 데이터 (실제로는 로그인 시 session에 저장)
    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String userPhone = (String) session.getAttribute("userPhone");

    if (userName == null) {
        userName = "홍길동";
        userEmail = "hong@test.com";
        userPhone = "010-1234-5678";
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="css/mypage.css">
<style>
/*body {
  font-family: 'Noto Sans KR', sans-serif;
  margin: 0;
  background: #f8f9fa;
  color: #333;
}*/

.mypage-container {
  display: flex;
  max-width: 1200px;
  margin: 40px auto;
  background: #fff;
  border-radius: 15px;
  box-shadow: 0 8px 25px rgba(0,0,0,0.1);
  overflow: hidden;
}

/* 🔹 사이드바 */
.mypage-sidebar {
  width: 250px;
  background: linear-gradient(180deg, #ffb6b9, #fae3d9);
  padding: 30px 20px;
  text-align: center;
  color: #333;
}

.profile img {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  border: 3px solid #fff;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
}

.profile h3 {
  margin: 10px 0 5px;
}

.profile p {
  font-size: 14px;
  color: #555;
}

.menu {
  list-style: none;
  padding: 0;
  margin-top: 30px;
}

.menu li {
  margin-bottom: 15px;
}

.menu a {
  text-decoration: none;
  color: #333;
  background: #fff;
  display: block;
  padding: 10px 15px;
  border-radius: 10px;
  font-weight: 500;
  transition: all 0.3s;
}

.menu a:hover, .menu a.active {
  background: #ff9292;
  color: #fff;
}

/* 🔹 메인 콘텐츠 */
.mypage-main {
  flex: 1;
  padding: 40px 60px;
}

.mypage-main h2 {
  margin-top: 0;
  font-size: 24px;
  color: #444;
  border-bottom: 2px solid #ff9292;
  padding-bottom: 8px;
}

.info-card {
  margin-top: 25px;
  background: #fffaf6;
  border: 1px solid #ffe0d2;
  border-radius: 15px;
  padding: 20px 30px;
  box-shadow: 0 4px 12px rgba(255, 145, 145, 0.1);
}

.info-card table {
  width: 100%;
  border-collapse: collapse;
}

.info-card th, .info-card td {
  text-align: left;
  padding: 12px 8px;
  border-bottom: 1px solid #f1f1f1;
}

.info-card th {
  width: 120px;
  color: #555;
  font-weight: 600;
}

.edit-btn {
  margin-top: 25px;
  background: linear-gradient(90deg, #ff9292, #ffb6b9);
  border: none;
  color: white;
  font-size: 16px;
  padding: 12px 30px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s;
}

.edit-btn:hover {
  transform: scale(1.05);
  background: linear-gradient(90deg, #ffb6b9, #ff9292);
}

@media (max-width: 900px) {
  .mypage-container {
    flex-direction: column;
  }
  .mypage-sidebar {
    width: 100%;
    border-radius: 15px 15px 0 0;
  }
  .mypage-main {
    padding: 25px;
  }
}

</style>
</head>
<body>

<div class="mypage-container">
  
  <!-- 🔹 사이드 메뉴 -->
  <aside class="mypage-sidebar">
    <div class="profile">
      <img src="https://cdn-icons-png.flaticon.com/512/1077/1077012.png" alt="profile">
      <h3><%= userName %>님</h3>
      <p>환영합니다 👋</p>
    </div>
    <ul class="menu">
      <li><a href="mypage.jsp" class="active">회원 정보</a></li>
      <li><a href="reservationList.jsp">예약 내역</a></li>
      <li><a href="paymentList.jsp">결제 내역</a></li>
      <li><a href="editProfile.jsp">정보 수정</a></li>
      <li><a href="deleteAccount.jsp">회원 탈퇴</a></li>
    </ul>
  </aside>

  <!-- 🔹 메인 정보 영역 -->
  <main class="mypage-main">
    <h2>회원 정보</h2>
    <div class="info-card">
      <table>
        <tr>
          <th>이름</th>
          <td><%= userName %></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><%= userEmail %></td>
        </tr>
        <tr>
          <th>연락처</th>
          <td><%= userPhone %></td>
        </tr>
        <tr>
          <th>가입일</th>
          <td>2024-05-12</td>
        </tr>
      </table>
    </div>
    <button class="edit-btn" onclick="location.href='editProfile.jsp'">정보 수정 ✏️</button>
  </main>

</div>

</body>
</html>