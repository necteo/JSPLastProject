<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%--
		아키텍쳐 : 요구사항 분석
		  |
	  ------------
	  |		|	 |
	 PM	   PM	 PM
	  |
   ------
   |	|
  PL   PL=> 데이터베이스 설계
  => 서버단  View DB단
  				| DAO
  		   | Front
  	  | => Model
   |
  -----
  |	  |
 2년	 1년
  |
 신입
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
$(function() {
	$('.times').click(function() {
		const time = $(this).text()
		$('#food_reserve_time').text(time)
		$('#rtime').val(time)
		
		$.ajax({
			type: 'get',
			url: '../reserve/reserve_inwon.do',
			success: function(result) {
				$('#reserve_inwon').html(result)
			}
		})
	})
})
</script>
</head>
<body>
  <c:forEach var="time" items="${tList}">
    <button class="btn btn-outline-primary btn-sm times">${time}</button>
  </c:forEach>
</body>
</html>