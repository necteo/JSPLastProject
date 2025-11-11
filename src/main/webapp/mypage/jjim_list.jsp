<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.dataTr:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('.dataTr').click(function() {
		const fno = $(this).attr('data-no')
		//alert("fno:" + fno)
		$.ajax({
			type: 'post',
			url: '../jjim/food_detail.do',
			data: { "fno": fno },
			success: function(result) {
				const json = JSON.parse(result)
				console.log(json)
				$('#img').attr('src', json.poster)
				$('#name').text(json.name)
				$('#address').text(json.address)
				$('#phone').text(json.phone)
				$('#type').text(json.type)
				$('#price').text(json.price)
				$('#time').text(json.time)
				$('#score').text(json.score)
				$('#parking').text(json.parking)
				$('#theme').text(json.theme)
				$('#content').text(json.content)
				$('#print').show()
			},
			error: function(error) {
				console.log(err)
			}
		})
	})
})
</script>
</head>
<body>
  <main class="mypage-main">
    <h2>찜 내역</h2>
    <div class="info-card">
      <table>
        <tr>
          <th width="10%">번호</th>
          <th width="15%"></th>
          <th width="20%">맛집명</th>
          <th width="40%">주소</th>
          <th width="15%"></th>
        </tr>
        <c:forEach var="vo" items="${list}">
          <tr class="dataTr" data-no="${vo.fvo.fno}">
            <td width="10%">${vo.jno}</td>
            <td width="15%">
              <img src="${vo.fvo.poster}" style="width: 35px; height: 35px">
            </td>
            <td width="20%">${vo.fvo.name}</td>
            <td width="40%">${vo.fvo.address}</td>
            <td width="15%">
              <a href="../jjim/jjim_cancel.do?jno=${vo.jno}" class="btn btn-sm btn-danger">취소</a>
            </td>
          </tr>
        </c:forEach>
      </table>
      <table id="print" style="display: none">
        <tr>
         <td width=40% rowspan="8" class="text-center">
          <img src="#" id="img" style="width: 340px; height: 350px" class="img-rounded">
         </td>
         <td colspan="2">
           <h3><span id="name"></span>&nbsp;<span style="color:orange" id="score"></span></h3>
         </td>
        </tr>
        <tr>
          <td width=15% style="color:gray">주소</td>
          <td width=45% id="address"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">전화</td>
          <td width=45% id="phone"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">음식종류</td>
          <td width=45% id="type"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">가격대</td>
          <td width=45% id="price"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">주차</td>
          <td width=45% id="parking"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">영업시간</td>
          <td width=45% id="time"></td>
        </tr>
        <tr>
          <td width=15% style="color:gray">테마</td>
          <td width=45% id="theme"></td>
        </tr>
       </table>
       <table class="table">
         <tr>
          <td id="content"></td>
         </tr>
       </table>
    </div>
  </main>
</body>
</html>