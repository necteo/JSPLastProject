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
                        <h2>자유게시판</h2>
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
	              <td>
	                <a href="../board/insert.do" class="btn btn-mint btn-sm">새글</a>
	              </td>
	            </tr>
	          </table>
	          <table class="table table-hover">
	            <tr>
	              <th class="text-center" width="10%">번호</th>
	              <th class="text-center" width="45%">제목</th>
	              <th class="text-center" width="15%">이름</th>
	              <th class="text-center" width="20%">작성일</th>
	              <th class="text-center" width="10%">조회수</th>
	            </tr>
	          </table>
	          <table class="table">
	            <tr>
	              <td class="text-left">
	                <input type="checkbox" value="N" name="fd">이름
	                <input type="checkbox" value="S" name="fd">제목
	                <input type="checkbox" value="C" name="fd">내용
	                <input type="text" size="15" name="ss" class="input-sm">
	                <input type="button" class="btn-sm btn-pink" value="검색">
	              </td>
	              <td class="text-right">
	                0 page / 0 pages
	              </td>
	            </tr>
	          </table>
            </div>
        </div>
    </section>
</body>
</html>