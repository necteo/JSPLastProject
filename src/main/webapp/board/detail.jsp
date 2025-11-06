<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
let bCheck = true;
$(function() {
	$('#delSpan').text('삭제');
	$('#delSpan').click(function() {
		if (bCheck === true) {
			$('#delTr').show("slow");
			$('#delSpan').text('취소');
			bCheck = false;
		} else {
			$('#delTr').hide("slow");
			$('#delSpan').text('삭제');
			bCheck = true;
		}
	})
	$('#delBtn').on('click', function() {
		let pwd = $('#delPwd').val();
		if (pwd.trim() === "") {
			$('#delPwd').focus();
			return;
		}
		const no = $('#delBtn').attr('data-no');
		const page = $('#delBtn').attr('data-page');
		// 서버와 연결 => axios / fetch / getJSON
		/*
		  axios.get('url', {
			  params: {}
		  })
		  .then(result => {
			  결과값
		  })
		  axios.post
		*/
		$.ajax({
			type: 'post',
			url: '../board/delete.do',
			data: {
				'no': no,
				'pwd': pwd
			},
			success: function(result) {
				// yes/no
				if (result === 'yes') {
					location.href = '../board/list.do?page=' + page;
				} else {
					alert('비밀번호가 틀립니다!!');
					$('#delPwd').val('');
					$('#delPwd').focus();
				}
			},
			error: function(error) {
				console.log(error.response);
			}
		})
	});
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
                  <td width="30%" class="text-center">${vo.no}</td>
                  <th width="20%" class="text-center">작성일</th>
                  <td width="30%" class="text-center">${vo.dbday}</td>
                </tr>
                <tr>
                  <th width="20%" class="text-center">이름</th>
                  <td width="30%" class="text-center">${vo.name}</td>
                  <th width="20%" class="text-center">조회수</th>
                  <td width="30%" class="text-center">${vo.hit}</td>
                </tr>
                <tr>
                  <th width="20%" class="text-center">제목</th>
                  <td colspan="3">${vo.subject}</td>
                </tr>
                <tr>
                  <td colspan="4" valign="top" height="200">
                    <pre style="white-space: pre-wrap; border: none; background: white">${vo.content}</pre>
                  </td>
                </tr>
                <tr>
                  <td colspan="4" class="text-right">
                    <a href="../board/update.do?no=${vo.no}&page=${page}" class="btn btn-mint btn-xs">수정</a>
                    <span class="btn btn-pink btn-xs" id="delSpan">삭제</span>
                    <a href="../board/list.do?page=${page}" class="btn btn-mint btn-xs">목록</a>
                  </td>
                </tr>
                <tr id="delTr" style="display: none;">
                  <td colspan="4" class="text-right">
                    비밀번호: <input type="password" name="pwd" style="width: 100px" class="input-sm" id="delPwd">
                    <input type="submit" class="btn-mint btn-sm" id="delBtn" value="삭제" data-no="${vo.no}" data-page="${page}">
                  </td>
                </tr>
              </table>
            </div>
            <div class="row board_row" style="margin-top: 10px">
              <h3>댓글</h3>
              <c:if test="${rcount == 0}">
                <table class="table">
                  <tr>
                    <td class="text-center">
                      댓글등록이 없습니다
                    </td>
                  </tr>
                </table>
              </c:if>
              <c:if test="${rcount > 0}">
                <table class="table">
                  <tr>
                    <td>
                      <c:forEach var="rvo" items="${rList}">
                        <table class="table">
                          <tr>
                            <td class="text-left">◑${rvo.name}(${rvo.dbday})</td>
                            <td class="text-right">
                              <c:if test="${sessionScope.id != null}">
                                <c:if test="${sessionScope.id == rvo.id}">
	                              <a href="#" class="btn btn-xs btn-info">수정</a>
	                              <a href="#" class="btn btn-xs btn-warning">삭제</a>
	                            </c:if>
	                              <a href="#" class="btn btn-xs btn-success">댓글</a>
                              </c:if>
                            </td>
                          </tr>
                          <tr>
                            <td colspan="2" class="text-left" valign="top">
                              <pre style="white-space: pre-wrap; background-color: white;border: none">${rvo.msg}</pre>
                            </td>
                          </tr>
                        </table>
                      </c:forEach>
                    </td>
                  </tr>
                </table>
              </c:if>
              <c:if test="${sessionScope.id != null}">
              <table class="table">
                <tr>
                  <td>
                    <textarea rows="5" cols="80" name="msg" style="float: left"></textarea>
                    <button style="width: 100px; height: 103px; background-color: blue;color: white; float: left">댓글쓰기</button>
                  </td>
                </tr>
              </table>
              </c:if>
            </div>
        </div>
    </section>
</body>
</html>