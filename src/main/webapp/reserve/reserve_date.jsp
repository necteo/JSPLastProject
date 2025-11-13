<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.day-link {
	cursor: pointer;
	width: 32px;
	height: 32px;
	line-height: 32px;
	border-radius: 50%;
	border: 2px solid #4caf50;
	color: #4caf50;
	font-weight: bold;
	transition: all 0.2s;
}
.day-link:hover {
	background-color: #4caf50;
}
</style>
<script type="text/javascript">
$(function() {
	$('.day-link').click(function() {
		const day = $(this).text()
		const year = $('#year').text()
		const month = $('#month').text()
		const date = year + '-' + month + '-' + day
		
		$('#food_reserve_day').text(date)
		$('#rday').val(date)
		
		$.ajax({
			type: 'post',
			url: '../reserve/reserve_time.do',
			data: {"day": day},
			success: function(result) {
				$('#reserve_time2').html(result)
			}
		})
	})
})
</script>
</head>
<body>
  <table class="table">
    <tr>
      <td colspan="7">
        <h3><span id="year">${year}</span>년 <span id="month">${month}</span>월</h3>
      </td>
    </tr>
    <tr>
      <c:forEach var="weeks" items="${weeks}" varStatus="s">
        <td class="text-center">
          <c:set var="style" value="black"/>
          <c:choose>
            <c:when test="${s.index == 0}">
              <c:set var="style" value="red"/>
            </c:when>
            <c:when test="${s.index == 6}">
              <c:set var="style" value="blue"/>
            </c:when>
            <c:otherwise>
              <c:set var="style" value="black"/>
            </c:otherwise>
          </c:choose>
      	  <h3 style="color: ${style}">${weeks}</h3>
        </td>
      </c:forEach>
    </tr>
    <c:set var="week" value="${week}"/>
    <c:forEach var="i" begin="1" end="${lastday}">
      <c:if test="${i == 1}">
        <tr>
        <c:forEach var="j" begin="1" end="${week}">
          <td class="text-center">&nbsp;</td>
        </c:forEach>
      </c:if>
      <c:set var="style" value="black"/>
        <c:choose>
          <c:when test="${s.index == 0}">
            <c:set var="style" value="red"/>
          </c:when>
          <c:when test="${s.index == 6}">
            <c:set var="style" value="blue"/>
          </c:when>
          <c:otherwise>
            <c:set var="style" value="black"/>
          </c:otherwise>
        </c:choose>
          
      <c:if test="${day > i}">
        <td class="text-center"><h4 style="color: gray">${i}</h4></td>
      </c:if>
      <c:if test="${day <= i}">
        <td class="text-center"><h4 class="day-link" style="color: ${style}">${i}</h4></td>
      </c:if>
      
      <c:set var="week" value="${week + 1}"/>
      <c:if test="${week > 6}">
        <c:set var="week" value="0"/>
        </tr>
        <tr>
      </c:if>
    </c:forEach>
    </tr>
  </table>
</body>
</html>