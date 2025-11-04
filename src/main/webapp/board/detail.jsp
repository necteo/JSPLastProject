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
                        <h2>내용보기</h2>
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
                  <th width="20%" class="text-center">번호</th>
                  <td width="30%" class="text-center"></td>
                  <th width="20%" class="text-center">작성일</th>
                  <td width="30%" class="text-center"></td>
                </tr>
                <tr>
                  <th width="20%" class="text-center">이름</th>
                  <td width="30%" class="text-center"></td>
                  <th width="20%" class="text-center">조회수</th>
                  <td width="30%" class="text-center"></td>
                </tr>
                <tr>
                  <th width="20%" class="text-center">제목</th>
                  <td colspan="3"></td>
                </tr>
                <tr>
                  <td colspan="4" valign="top" height="200">
                    <pre style="white-space: pre-wrap; border: none; background: white"></pre>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" class="text-right">
                    <a href="#" class="btn btn-mint btn-xs">수정</a>
                    <a href="#" class="btn btn-pink btn-xs">삭제</a>
                    <a href="#" class="btn btn-mint btn-xs">목록</a>
                  </td>
                </tr>
              </table>
            </div>
        </div>
    </section>
</body>
</html>