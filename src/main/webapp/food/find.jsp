<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.a-link:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('#findBtn').click(function() {
		let types = []
		let count = $('input[name="type"]:checked').length
		if (count == 0) {
			alert('체크박스에 체크하세요!!')
			return
		}
		$('input[name="type"]:checked').each(function() {
			types.push($(this).val())
		})
		const fd = $('#fd').val()
		if (fd.trim() === '') {
			$('#fd').focus()
			return
		}
		const column = $('#column').val()
		console.log(types)
		console.log('검색어:' + fd)
		console.log('컬럼명:' + column)
		// 배열 => traditional
		$.ajax({
			type: 'post',
			url: '../food/find_ajax.do',
			data: {
				"fd": fd,
				"column": column,
				"type": types
			},
			traditional: true,
			success: function(result) {
				const json = JSON.parse(result)
				console.log(json)
				jsonView(json)
			},
			error: function(error) {
				console.log(error)
			}
		})
	})
	$('#fd').keydown(function(e) {
		if (e.keyCode == 13) {
			commons(1)
		}
	})
})
// 1. 처음
// 2.  <
// 3.  >
// 4.   1 2 3 4 5 6 7..
function commons(page) {
	let types = []
	$('input[name="type"]:checked').each(function() {
		types.push($(this).val())
	})
	const fd = $('#fd').val()
	const column = $('#column').val()
	// 배열 => traditional
	$.ajax({
		type: 'post',
		url: '../food/find_ajax.do',
		data: {
			"fd": fd,
			"column": column,
			"type": types,
			"page":  page
		},
		traditional: true,
		success: function(result) {
			const json = JSON.parse(result)
			console.log(json)
			jsonView(json)
		},
		error: function(error) {
			console.log(error)
		}
	})
}
function jsonView(json) {
	let html = ''
	json.map(food => {
		html += '<div class="col-12 col-md-6 col-lg-4">'
		        + '<div class="single-post wow fadeInUp" data-wow-delay="1.2s">'
		        	  + '<div class="post-thumb">'
		               + '<a class="a-link" href="../food/detail.do?page=' + json[0].curpage + '&fno=' + food.fno + '&link=1">'
		                 + '<img src="' + food.poster + '">'
		               + '</a>'
		             + '</div>'
		             + '<div class="post-content">'
		                 + '<div class="post-meta d-flex">'
		                     + '<div class="post-author-date-area d-flex">'
		                         + '<div class="post-author">'
		                             + '<a href="#">' + food.type + '</a>'
		                         + '</div>'
		                         + '<div class="post-date">'
		                             + '<a href="#">' + food.address + '</a>'
		                         + '</div>'
		                     + '</div>'
		                     + '<div class="post-comment-share-area d-flex">'
		                         + '<div class="post-favourite">'
		                             + '<a href="#"><i class="fa fa-heart-o" aria-hidden="true"></i> ' + food.likecount + '</a>'
		                         + '</div>'
		                         + '<div class="post-comments">'
		                             + '<a href="#"><i class="fa fa-comment-o" aria-hidden="true"></i> ' + food.replycount+ '</a>'
		                         + '</div>'
		                         + '<div class="post-share">'
		                             + '<a href="#"><i class="fa fa-share-alt" aria-hidden="true"></i></a>'
		                         + '</div>'
		                     + '</div>'
		                 + '</div>'
		                 + '<a class="a-link" href="../food/detail.do?page=' + json[0].curpage + '&fno=' + food.fno + '&link=1">'
		                     + '<h4 class="post-headline">' + food.name + '</h4>'
		                 + '</a>'
		             + '</div>'
		         + '</div>'
		     + '</div>'
	})

	// page
	html += '<div class="col-12">'
	html += '<div class="pagination-area d-sm-flex mt-15">'
	html += '<nav aria-label="#">'
	html += '<ul class="pagination">'
    if (json[0].startPage > 1) {
    	html += '<li class="page-item">'
    	html += '<a class="page-link" onclick="prev(' + (json[0].startPage - 1) + ')">이전 <i class="fa fa-angle-double-left" aria-hidden="true"></i></a>'
    	html += '</li>'
    }
    for (let i = json[0].startPage; i < json[0].endPage; i++) {
		if (json[0].curpage === i) {
			html += '<li class="page-item active"><a class="page-link" onclick="change(' + i + ')">' + i + '</a></li>'
		} else {
			html += '<li class="page-item"><a class="page-link" onclick="change(' + i + ')">' + i + '</a></li>'
		}
    }
    if (json[0].endPage < json[0].totalpage) {
    	html += '<li class="page-item">'
        html += '<a class="page-link" onclick="next(' + (json[0].endPage + 1) + ')">다음 <i class="fa fa-angle-double-right" aria-hidden="true"></i></a>'
        html += '</li>'
    }
    html += '</ul>'
    html += '</nav>'
    html += '<div class="page-status">'
    html += '<p>Page ' + json[0].curpage+ ' of ' + json[0].endPage + ' results</p>'
    html += '</div>'
    html += '</div>'
    html += '</div>'
	
	$('.find_print').html(html)
}
function change(page) {
	commons(page)
}
function prev(page) {
	commons(page)
}
function next(page) {
	commons(page)
}
</script>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>맛집 검색</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="breadcumb-nav">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                        	<input type="checkbox" name="type" value="A">한식
                        	<input type="checkbox" name="type" value="B">일식
                        	<input type="checkbox" name="type" value="C">중식
                        	<input type="checkbox" name="type" value="D">양식
                        	<input type="checkbox" name="type" value="E">분식
                        	<select name="column" id="column" class="input-sm">
                        		<option value="address">주소</option>
                        		<option value="name">업체명</option>
                        		<option value="theme">테마</option>
                        	</select>
                            <input type="text" name="fd" id="fd" class="input-sm">
                            <input type="button" value="검색" class="btn-sm btn-danger" id="findBtn">
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ******
    	 1. 화면 이동
    	 	데이터 전송 = 오라클 컬럼명 => page
    	 	========= primary key
    	 	예약
    	 	  1. 맛집 번호
    	 	  2. 월 일
    	 	  3. 시간
    	 	  4. 인원 
    -->
    <section class="archive-area section_padding_80">
        <div class="container">
            <div class="row find_print">
            	
            </div>
        </div>
    </section>
</body>
</html>