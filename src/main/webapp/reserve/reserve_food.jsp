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
	$('.types').click(function() {
		  const type = $(this).val()
		  foodReader(type)
	})
	$('.food-item').click(function() {
		const fno = $(this).attr('data-fno')
		const poster = $(this).attr('data-poster')
		const name = $(this).attr('data-name')
		$('#food_poster').attr('src', poster)
		$('#food_poster').show()
		$('#reserve_info').show()
		$('#food_name').text(name)
	  
	    $('#rfno').val(fno)
	
	    // 화면 이동
	    $.ajax({
		    type: 'post',
		    url: '../reserve/reserve_date.do',
		    success: function(result) {
		 	    $('#food_rdays').html(result)
		    }
	    })
	})
})
</script>
</head>
<body>
<table class="table">
  <tr>
    <td class="text-center">
      <input type="button" value="한식" class="btn-xs btn-danger types">
      <input type="button" value="양식" class="btn-xs btn-warning types">
      <input type="button" value="중식" class="btn-xs btn-info types">
      <input type="button" value="일식" class="btn-xs btn-success types">
      <input type="button" value="분식" class="btn-xs btn-primary types">
    </td>
  </tr>
</table>
<table class="table table-hover align-middle">
  <tbody>
    <c:forEach var="vo" items="${list}">
	  <tr class="food-item" data-fno="${vo.fno}" data-poster="${vo.poster}" data-name="${vo.name}">
	    <td><img src="${vo.poster}" class="rounded" style="width: 150px; height: 100px"></td>
	    <td>
	      <strong>${vo.name}</strong><br>
	      <small class="text-muted">${vo.type}</small>
	    </td>
	  </tr>
    </c:forEach>
  </tbody>
</table>
</body>
</html>