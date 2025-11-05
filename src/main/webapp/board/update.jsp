<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/table.css">
<style type="text/css">
.board_row {
	margin: 0px auto;
	width: 800px;
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('#up_pwd').on('keyup', function() {
		const pwd = $(this).val();
		const no = $('#no').val();
		$.ajax({
			type: 'post',
			url: '../board/pwdcheck.do',
			data: {
				'pwd': pwd,
				'no': no
			},
			success: function(result) {
				if (result === 'yes') {
					$('#print').text('비밀번호가 일치합니다!');
					$('#updateBtn').show('slow');
				} else {
					$('#print').text('비밀번호가 일치하지 않습니다!');
					$('#updateBtn').hide('slow');
					/* $('#up_pwd').val('');
					$('#up_pwd').focus(); */
				}
			},
			error: function(err) {
				console.log(err);
			}
		})
	})
	/*
		<input type="text" id="a" value="">
								  -------- $('#a').val()
							 input / textarea / select
							 	  $('#a').val(값)
		<img src="파일명">
			 ----------- $('img').attr('src')
			 			 $('img').attr('src','값')
		<span>데이터</span>
			  ----- $('span').text()
			  		$('span').text('값')
	*/
	$('#updateBtn').click(function() {
		const no = $('#no').val();
		const name = $('#name').val();
		const page = $('#page').val();
		if (name.trim() === '') {
			$('#name').focus();
			return;
		}
		const subject = $('#subject').val();
		if (subject.trim() === '') {
			$('#subject').focus();
			return;
		}
		const content = $('#content').val();
		if (content.trim() === '') {
			$('#content').focus();
			return;
		}
		const pwd = $('#up_pwd').val();
		if (pwd.trim() === '') {
			$('#up_pwd').focus();
			return;
		}
		$.ajax({
			type: 'post',
			url: '../board/update_ok.do',
			data: $('#frm').serialize(),
			success: function(result) {
				if (result === 'yes') {
					location.href = '../board/detail.do?no=' + no + '&page=' + page + '&type=1';
				} else {
					alert(result)
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	})
})
</script>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>수정하기</h2>
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
                        	<%-- 검색기 --%>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ****** Breadcumb Area End ****** -->

    <!-- ****** Archive Area Start ****** -->
    <!-- 
    	 id , class : javascript
    	 name : java
     -->
    <section class="archive-area section_padding_80">
        <div class="container">
            <div class="row board_row">
            <form id="frm">
              <table class="table">
                <tr>
                  <th class="text-center">이름</th>
                  <td>
                    <input type="text" name="name" id="name" class="form-control input-sm" style="width: 200px" required value="${vo.name}">
                    <input type="hidden" name="no" id="no" value="${vo.no}">
                    <input type="hidden" name="page" id="page" value="${page}">
                  </td>
                <tr>
                <tr>
                  <th class="text-center">제목</th>
                  <td>
                    <input type="text" name="subject" id="subject" class="form-control input-sm" required value="${vo.subject}">
                  </td>
                <tr>
                <tr>
                  <th class="text-center">내용</th>
                  <td>
                    <textarea rows="10" cols="50" class="form-control" name="content" id="content" required>${vo.content}</textarea>
                  </td>
                <tr>
                <tr>
                  <th class="text-center">비밀번호</th>
                  <td>
                    <input type="password" name="pwd" id="up_pwd" class="form-control input-sm" style="width: 150px" required>
                  </td>
                <tr>
                <tr>
                  <td colspan="2" class="text-center">
                    <input type="button" class="btn btn-sm btn-mint" value="수정" id="updateBtn" style="display: none;">
                    <input type="button" class="btn btn-sm btn-pink" value="취소" onclick="javascript:history.back()">
                  </td>
                </tr>
                <tr>
                  <td colspan="2" class="text-center">
                    <span style="color: red" id="print"></span>
                  </td>
                </tr>
              </table>
            </form>
            </div>
        </div>
    </section>
</body>
</html>