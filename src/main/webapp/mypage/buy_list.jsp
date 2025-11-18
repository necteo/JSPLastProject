<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	$('.dataTr').hover(function() {
		$(this).css('cursor', 'pointer')
	})
	$('.dataTr').click(function() {
		let no = $(this).attr('data-no')
		location.href = '../mypage/buy_detail.do?no=' + no
	})
})
</script>
</head>
<body>
  <main class="mypage-main">
    <h2>장바구니 내역</h2>
    <div class="info-card">
      <table>
        <tr>
          <th width="10%">번호</th>
          <th width="10%"></th>
          <th width="40%">상품명</th>
          <th width="20%">구매일</th>
          <th width="10%">수량</th>
          <th width="10%">가격</th>
        </tr>
        <c:forEach var="vo" items="${gList}">
          <tr class="dataTr" data-no="${vo.no}">
            <td width="10%">${vo.no}</td>
            <td width="10%">
              <img src="${vo.gvo.goods_poster}" style="width: 35px; height: 35px">
            </td>
            <td width="40%">${vo.gvo.goods_name}</td>
            <td width="20%">${vo.dbday}</td>
            <td width="10%">${vo.account}</td>
            <td width="10%">${vo.gvo.goods_price}</td>
            
          </tr>
        </c:forEach>
      </table>
    </div>
  </main>
</body>
</html>
