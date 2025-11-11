<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <main class="mypage-main">
    <h2>회원 정보</h2>
    <div class="info-card">
      <table>
        <tr>
          <th>이름</th>
          <td>${sessionScope.name}</td>
        </tr>
        <tr>
          <th>주소</th>
          <td>${sessionScope.addr1 += " " += sessionScope.addr2}</td>
        </tr>
        <tr>
          <th>연락처</th>
          <td>${sessionScope.phone}</td>
        </tr>
        <tr>
          <th>가입일</th>
          <td>2024-05-12</td>
        </tr>
      </table>
    </div>
    <button class="edit-btn" onclick="location.href='editProfile.jsp'">정보 수정 ✏️</button>
  </main>
</body>
</html>