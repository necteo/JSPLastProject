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
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>글쓰기</h2>
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
    <section class="archive-area section_padding_80">
        <div class="container">
            <div class="row board_row">
              <table class="table">
                <tr>
                  <th class="text-center">이름</th>
                  <td>
                    <input type="text" name="name" class="form-control input-sm">
                  </td>
                <tr>
                <tr>
                  <th class="text-center">제목</th>
                  <td>
                    <input type="text" name="subject" class="form-control input-sm">
                  </td>
                <tr>
                <tr>
                  <th class="text-center">내용</th>
                  <td>
                    <textarea rows="10" cols="50" class="form-control" name="content"></textarea>
                  </td>
                <tr>
                <tr>
                  <th class="text-center">비밀번호</th>
                  <td>
                    <input type="password" name="pwd" class="form-control input-sm" style="width: 150px">
                  </td>
                <tr>
                <tr>
                  <td colspan="2" class="text-center">
                    <input type="button" class="btn btn-sm btn-mint" value="글쓰기">
                    <input type="button" class="btn btn-sm btn-pink" value="취소" onclick="javascript:history.back()">
                  </td>
                </tr>
              </table>
            </div>
        </div>
    </section>
</body>
</html>