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
    <h2>상품 정보</h2>
    <div class="info-card">
      <table>
        <tr>
          <td colspan="2" class="text-center">
            <img src="${vo.gvo.goods_poster}" style="width: 300px; height: 200px">
          </td>
        </tr>
        <tr>
          <td colspan="2">${vo.gvo.goods_name}</td>
        </tr>
        <tr>
          <td width="20%">가격</td>
          <td width="80%">${vo.gvo.goods_price}</td>
        </tr>
        <tr>
          <td width="20%">배송</td>
          <td width="80%">무료배송</td>
        </tr>
      </table>
    </div>
    <h2>배송지 정보</h2>
    <div class="info-card">
      <table>
        <tr>
          <td width="20%">수취인</td>
          <td width="80%">${vo.name}</td>
        </tr>
        <tr>
          <td width="20%">우편번호</td>
          <td width="80%">${vo.post}</td>
        </tr>
        <tr>
          <td width="20%">기본주소</td>
          <td width="80%">${vo.addr1}</td>
        </tr>
        <tr>
          <td width="20%">상세주소</td>
          <td width="80%">${vo.addr2}</td>
        </tr>
        <tr>
          <td width="20%">요청사항</td>
          <td width="80%">${vo.msg}</td>
        </tr>
      </table>
    </div>
    <h2>구매 정보</h2>
    <div class="info-card">
      <table>
        <tr>
          <td width="20%">구매일</td>
          <td width="80%">${vo.dbday}</td>
        </tr>
        <tr>
          <td width="20%">수량</td>
          <td width="80%">${vo.account}</td>
        </tr>
        <tr>
          <td width="20%">가격</td>
          <td width="80%">${vo.gvo.goods_price}</td>
        </tr>
        <tr>
          <td colspan="2" class="text-right">총결제 금액:<span style="color: red">${total}원</span></td>
        </tr>
        <tr>
          <td colspan="2" class="text-right">
            <input type="button" class="btn-sm btn-danger" value="목록" onclick="javascript:hitory.back()">
          </td>
        </tr>
      </table>
    </div>
  </main>
</body>
</html>