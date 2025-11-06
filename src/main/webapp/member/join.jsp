<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="../css/table.css">
<link rel="stylesheet" href="../shadow/css/shadowbox.css">
<style type="text/css">
 .join_row{
  margin: 0px auto;
  width: 900px;
} 
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="../shadow/js/shadowbox.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
Shadowbox.init({
	players: ['iframe']
})
$(function() {
	$('#idBtn').click(function() {
		Shadowbox.open({
			content: '../member/idcheck.do',
			player: 'iframe',
			width: 500,
			heigth: 350,
			title: '아이디 중복체크'
		})
	})
	$('#postBtn').on('click', function() {
		new daum.Postcode({
			oncomplete: function(data) {
				$('#post').val(data.zonecode)
				$('#addr1').val(data.address)
			}
		}).open()
	})
	
	$('#joinBtn').click(function() {
		let id = $('#join_id').val()
		if (id.trim() === '') {
			alert('아이디 중복체크를 하세요')
			return
		}
		let pwd1 = $('#pwd1').val()
		if (pwd1.trim() === '') {
			$('#pwd1').focus()
			return
		}
		let pwd2 = $('#pwd2').val()
		if (pwd1 !== pwd2) {
			alert('비밀번호를 틀립니다')
			$('#pwd2').val('')
			$('#pwd2').focus()
			return
		}
		let name = $('#name').val()
		if (name.trim() === '') {
			$('#name').focus()
			return
		}
		let day = $('#birthday').val()
		if (day.trim() === "") {
			alert('생년월일을 선택하세요')
			return
		}
		let post = $('#post').val()
		if (post.trim() === '') {
			alert('우편번호 검색을 하세요')
			return
		}
		
		// Model로 전송
		$('#frm').submit()
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
                        <h2>회원가입</h2>
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
        <div class="container" style="max-width: 800px; margin-top: 40px;">
            
             <div class="panel panel-pastel">
			    <div class="panel-heading text-center">
			      <span class="glyphicon glyphicon-leaf"></span>
			    </div>
			    <div class="panel-body">
			    <form id="frm" name="frm" method="post" action="../member/join_ok.do">
			      <table class="table table-bordered table-hover">
			        <tr>
			          <th class="text-center" width="20%">ID</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" name="id" id="join_id" class="form-control input-sm" placeholder="아이디" readonly>
			              <button type="button" id="idBtn" class="btn btn-mint btn-sm">중복체크</button>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">Password</th>
			          <td>
			            <div class="form-inline">
			              <input type="password" name="pwd" id="pwd1" class="form-control input-sm" placeholder="비밀번호">
			              <input type="password" name="pwd1" id="pwd2" class="form-control input-sm" placeholder="비밀번호 재입력">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이름</th>
			          <td><input type="text" name="name" id="name" class="form-control input-sm" placeholder="이름 입력"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">성별</th>
			          <td>
			            <label class="radio-inline"><input type="radio" name="sex" value="남자" checked> 남자</label>
			            <label class="radio-inline"><input type="radio" name="sex" value="여자"> 여자</label>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">생년월일</th>
			          <td><input type="date" id="birthday" name="birthday" class="form-control input-sm"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">이메일</th>
			          <td><input type="text" name="email" class="form-control input-sm" placeholder="example@email.com"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">우편번호</th>
			          <td>
			            <div class="form-inline">
			              <input type="text" id="post" name="post" class="form-control input-sm" readonly>
			              <button type="button" id="postBtn" class="btn btn-pink btn-sm">우편번호검색</button>
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">주소</th>
			          <td><input type="text" id="addr1" name="addr1" class="form-control input-sm" readonly></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">상세주소</th>
			          <td><input type="text" name="addr2" class="form-control input-sm"></td>
			        </tr>
			
			        <tr>
			          <th class="text-center">전화번호</th>
			          <td>
			            <div class="form-inline">
			              <select name="phone1" class="form-control input-sm">
			                <option>010</option>
			                <option>011</option>
			                <option>016</option>
			              </select>
			              <input type="text" name="phone2" class="form-control input-sm" placeholder="####-####">
			            </div>
			          </td>
			        </tr>
			
			        <tr>
			          <th class="text-center">소개</th>
			          <td><textarea rows="5" name="content" class="form-control input-sm" placeholder="자기소개를 입력하세요"></textarea></td>
			        </tr>
			
			        <tr>
			          <td colspan="2" class="text-center">
			            <button type="button" class="btn btn-mint btn-sm" id="joinBtn">회원가입</button>
			            <button type="button" class="btn btn-pink btn-sm" onclick="history.back()">취소</button>
			          </td>
			        </tr>
			      </table>
			      </form>
			    </div>
			  </div>
            </div>
        
    </section>

</body>
</html>