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
<style>
/* 전체 댓글 영역 */
.board_row {
  margin-top: 30px;
}

/* 기본 댓글 카드 */
.panel.panel-default {
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.06);
  border: none;
  margin-bottom: 20px;
  transition: all 0.2s ease;
}
.panel.panel-default:hover {
  box-shadow: 0 4px 10px rgba(0,0,0,0.08);
}

/* 댓글 제목 */
.panel-heading {
  background-color: #f9f9f9 !important;
  border-bottom: 1px solid #eee;
  border-radius: 10px 10px 0 0;
}

/* 댓글 본문 */
.panel-body {
  background-color: #fff;
  border-radius: 0 0 10px 10px;
  padding: 15px 20px;
}

/* 댓글 내용 텍스트 */
.panel-body pre {
  background: none;
  border: none;
  white-space: pre-wrap;
  font-size: 14px;
  line-height: 1.6em;
  color: #333;
}

/* 대댓글 구역 */
.reply-panel {
  margin-left: 60px; /* 들여쓰기 */
  border-left: 3px solid #a3d2ca; /* 민트 라인 */
  background-color: #fefefe;
  position: relative;
}

/* 대댓글 이미지 (답변 아이콘 / 프로필) */
.reply-icon {
  width: 40px;
  height: 30px;
  /*border-radius: 50%;*/
  position: absolute;
  left: -45px;
  top: 15px;
  /*border: 2px solid #a3d2ca;*/
  background-color: #ffffff;
  object-fit: cover;
}

/* 댓글 간격 정리 */
.panel + .reply-panel {
  margin-top: -5px;
}

/* 버튼 스타일 */
.btn-success {
  background-color: #a3d2ca;
  border-color: #a3d2ca;
  color: #fff;
}
.btn-success:hover {
  background-color: #8fc7bb;
  border-color: #8fc7bb;
}
.btn-warning {
  background-color: #f8c291;
  border-color: #f8c291;
  color: #fff;
}
.btn-info {
  background-color: #74b9ff;
  border-color: #74b9ff;
  color: #fff;
}

/* 댓글 입력창 */
.panel-primary {
  border-radius: 10px;
}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
let bCheck=true
let u = 0
let i = 0
$(function(){
	$("#delSpan").text("삭제")
	$('#delSpan').click(function(){
		if(bCheck===true)
		{
			$('#delTr').show("slow")
			$("#delSpan").text("취소")
			bCheck=false
		}
		else
		{
			$('#delTr').hide("slow")
			$("#delSpan").text("삭제")
			bCheck=true
		}
	})
	$('#delBtn').on('click',function(){
		let pwd=$('#delpwd').val()
		if(pwd.trim()==="")
		{
			$('#delpwd').focus()
			return
		}
		let no=$('#delBtn').attr("data-no")
		let page=$('#delBtn').attr("data-page")
		// 서버와 연결 => axios / fetch / getJSON
		/*
		  axios.get('url',{
			  params:{}
		  })
		  .then(result=>{
			  결과값 
		  })
		  axios.post
		*/
		$.ajax({
			type:'post',
			url:'../board/delete.do',
			data:{"no":no,"pwd":pwd},
			success:function(result)
			{
				// yes/no 
				if(result==="yes")
				{
					location.href="../board/list.do?page="+page
				}
				else
				{
					alert("비밀번호가 틀립니다!!")
					$('#delpwd').val("")
					$('#delpwd').focus()
				}
			},
			error:function(error)
			{
				console.log(error)
			}
		})
	})
	/* 댓글 */
	$('.ups').hide()
	$('.upBtns').click(function() {
		let no = $(this).attr('data-no')
		if (u == 0) {
			$('.ups').hide()
			$('#up' + no).show()
			$(this).text('취소')
			u = 1
		} else 	{
			$('#up' + no).hide()
			$(this).text('수정')
			$('.upBtns').text('수정')
			u = 0
		}
	})
	
	$('.ins').hide()
	$('.inBtns').click(function() {
		let no = $(this).attr('data-no')
		if (u == 0) {
			$('.ins').hide()
			$('#in' + no).show()
			$(this).text('취소')
			u = 1
		} else 	{
			$('#in' + no).hide()
			$(this).text('수정')
			$('.inBtns').text('답변')
			u = 0
		}
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
               <th width=20% class="text-center">번호</th>
               <td width=30% class="text-center">${vo.no }</td>
               <th width=20% class="text-center">작성일</th>
               <td width=30% class="text-center">${vo.dbday }</td>
              </tr>
              <tr>
               <th width=20% class="text-center">이름</th>
               <td width=30% class="text-center">${vo.name }</td>
               <th width=20% class="text-center">조회수</th>
               <td width=30% class="text-center">${vo.hit }</td>
              </tr>
              <tr>
               <th width=20% class="text-center">제목</th>
               <td colspan="3">${vo.subject }</td>
              </tr>
              <tr>
                <td colspan="4" valign="top" height="200">
                 <pre style="white-space: pre-wrap;border:none;background-color: white;">${vo.content }</pre>
                </td>
              </tr>
              <tr>
               <td colspan="4" class="text-right">
                <a href="../board/update.do?no=${vo.no }&page=${page}" class="btn btn-mint btn-xs">수정</a>
                <span class="btn btn-pink btn-xs" id="delSpan">삭제</span>
                <a href="../board/list.do?page=${page }" class="btn btn-mint btn-xs">목록</a>
               </td>
              </tr>
              <tr id="delTr" style="display:none">
                <td colspan="4" class="text-right">
                 비밀번호:<input type=password name=pwd
                        style="width:100px" 
                        class="input-sm" id="delpwd">
                   <input type=button class="btn-mint btn-sm"
                    id="delBtn" value="삭제"
                    data-no="${vo.no }" data-page="${page }"
                   >
                </td>
              </tr>
             </table>
            </div>
            <c:forEach var="rvo" items="${rList}">
		     <c:choose>
		   
		     <c:when test="${rvo.group_tab == 0}">
		      <div class="panel panel-danger">
		        <div class="panel-heading">
		          <div class="row">
		            <div class="col-md-8">
		              <strong>${rvo.name}</strong> 
		              <small class="text-muted">(${rvo.dbday})</small>
		            </div>
		            <div class="col-md-4 text-right">
		              <c:if test="${sessionScope.id!=null && rvo.msg != '관리자가 삭제한 댓글입니다'}">
		               <c:if test="${sessionScope.id==rvo.id}">
		                <span class="btn btn-xs btn-info upBtns" data-no="${rvo.no}">수정</span>
		                <a href="../reply/reply_delete.do?no=${rvo.no}&bno=${vo.no}&page=${page}" class="btn btn-xs btn-warning">삭제</a>
		               </c:if>
		                <a href="#" class="btn btn-xs btn-success inBtns" data-no="${rvo.no}">답글</a>
		              </c:if>
		            </div>
		          </div>
		        </div>
		        <div class="panel-body">
		          <pre>${rvo.msg}</pre>
		        </div>
		         <form id="up${rvo.no}" class="ups" style="display: none" method="post" action="../reply/reply_update.do"> 
			         <div class="form-group"> 
			         <textarea class="form-control" rows="4" name="msg" placeholder="댓글을 입력하세요..." style="resize:none;">${rvo.msg}</textarea>
			         <input type="hidden" name="bno" value="${vo.no}">
			         <input type="hidden" name="page" value="${page}">
			         <input type="hidden" name="no" value="${rvo.no}">
			         </div> 
			         <button type="submit" class="btn btn-primary btn-block" style="font-weight:bold;"> 
			         <span class="glyphicon glyphicon-send">
			         </span> 수정하기</button> 
		         </form> 
		       <div>
		       <form id="in${rvo.no}" class="ins" style="display: none" method="post" action="../reply/reply_reply_insert.do"> 
			         <div class="form-group"> 
			         <textarea class="form-control" rows="4" name="msg" placeholder="댓글을 입력하세요..." style="resize:none;"></textarea>
			         <input type="hidden" name="bno" value="${vo.no}">
			         <input type="hidden" name="page" value="${page}">
			         <input type="hidden" name="pno" value="${rvo.no}">
			         </div> 
			         <button type="submit" class="btn btn-primary btn-block" style="font-weight:bold;"> 
			         <span class="glyphicon glyphicon-send">
			         </span> 댓글쓰기 </button> 
		         </form> 
		       </div>
		      </div>
		    </c:when>
		    <c:otherwise>
		      <div class="panel panel-info reply-panel" style="margin-left: ${(rvo.group_tab*30)+='px'}">
		        <img src="../board/images/re_icon.png" class="reply-icon">
		        <div class="panel-heading">
		          <div class="row">
			        <div class="col-md-8">
		              <strong>${rvo.name}</strong> 
		              <small class="text-muted">(${rvo.dbday})</small>
		            </div>
		            <div class="col-md-4 text-right">
		              <c:if test="${sessionScope.id!=null && rvo.msg != '관리자가 삭제한 댓글입니다'}">
		               <c:if test="${sessionScope.id==rvo.id}">
		                <span class="btn btn-xs btn-info upBtns" data-no="${rvo.no}">수정</span>
		                <a href="../reply/reply_delete.do?no=${rvo.no}&bno=${vo.no}&page=${page}" class="btn btn-xs btn-warning">삭제</a>
		               </c:if>
		                <a href="#" class="btn btn-xs btn-success inBtns" data-no="${rvo.no}">답글</a>
		              </c:if>
		            </div>
		          </div>
		        </div>
		        <div class="panel-body">
		          <pre>${rvo.msg}</pre>
		        </div>
                 <form id="up${rvo.no}" class="ups" style="display: none" method="post" action="../reply/reply_update.do"> 
			         <div class="form-group"> 
			         <textarea class="form-control" rows="4" name="msg" placeholder="댓글을 입력하세요..." style="resize:none;">${rvo.msg}</textarea>
			         <input type="hidden" name="bno" value="${vo.no}">
			         <input type="hidden" name="page" value="${page}">
			         <input type="hidden" name="no" value="${rvo.no}">
			         </div> 
			         <button type="submit" class="btn btn-primary btn-block" style="font-weight:bold;"> 
			         <span class="glyphicon glyphicon-send">
			         </span> 수정하기 </button> 
		         </form> 
		       <div>
		       	<form id="in${rvo.no}" class="ins" style="display: none" method="post" action="../reply/reply_reply_insert.do"> 
			         <div class="form-group"> 
			         <textarea class="form-control" rows="4" name="msg" placeholder="댓글을 입력하세요..." style="resize:none;"></textarea>
			         <input type="hidden" name="bno" value="${vo.no}">
			         <input type="hidden" name="page" value="${page}">
			         <input type="hidden" name="pno" value="${rvo.no}">
			         </div> 
			         <button type="submit" class="btn btn-primary btn-block" style="font-weight:bold;"> 
			         <span class="glyphicon glyphicon-send">
			         </span> 댓글쓰기 </button> 
		         </form> 
		       </div>
		      </div>
		    </c:otherwise>
		  </c:choose>
		</c:forEach>
         <!-- 댓글 입력창 --> 
         <c:if test="${sessionScope.id!=null}"> 
         <div class="panel panel-primary" style="margin-top:20px;"> 
         <div class="panel-heading"> 
         <strong>댓글쓰기</strong> 
         </div> 
         <div class="panel-body"> 
         <form method="post" action="../reply/reply_insert.do"> 
         <div class="form-group"> 
         <textarea class="form-control" rows="4" name="msg" placeholder="댓글을 입력하세요..." style="resize:none;"></textarea>
         <input type="hidden" name="bno" value="${vo.no}">
         <input type="hidden" name="page" value="${page}">
         </div> 
         <button type="submit" class="btn btn-primary btn-block" style="font-weight:bold;"> 
         <span class="glyphicon glyphicon-send">
         </span> 등록하기 </button> 
         </form> 
         </div> 
         </div> 
         </c:if> 
         <!-- 로그인 안된 경우 --> 
         <c:if test="${sessionScope.id==null}"> 
         <div class="alert alert-warning text-center" style="margin-top:15px;"> 
         <span class="glyphicon glyphicon-lock"></span> 댓글을 작성하려면 로그인하세요. </div> 
         </c:if> 
         </div>
    </section>
</body>
</html>