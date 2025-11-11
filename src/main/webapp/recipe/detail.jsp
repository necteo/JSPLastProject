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
.recipe_row{
  margin: 0px auto;
  width: 850px;
}
.img-link{
  cursor: pointer
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
// ?rno=1&page=5 => ${param.rno} => request.getParameter("rno")
let likeCheck=false
let rno=${param.no}
let id='${sessionScope.id}'
// 전역변수 
$(function(){
	if(id.length>0)
	{
		$.ajax({
			type:'post',
			url:'../like/likeCheck.do',
			data:{
				"rno":rno,
				"type":2
			},
			success:function(result)
			{
				if(result==='OK')
				{
					likeCheck=true
					$('#likeBtn').attr("src","../img/images/likeon.png")
				}
				else
				{
					likeCheck=false
					$('#likeBtn').attr("src","../img/images/likeoff.png")
				}
			},
			error:function(err)
			{
				console.log(err)
			}
		})
	}
	// like 이미지 클릭
	$('#likeBtn').click(function(){
		if(likeCheck===true)
		{
			$.ajax({
				type:'post',
				url:'../like/likeOff.do',
				data:{"rno":rno,"type":2},
				success:function(result)
				{
					if(result>=0)
					{
						likeCheck=false
						$('#likeBtn').attr('src','../img/images/likeoff.png')
					}
				}
			})
		}
		else
		{
			$.ajax({
				type:'post',
				url:'../like/likeOn.do',
				data:{"rno":rno,"type":2},
				success:function(result)
				{
					if(result>=0)
					{
						likeCheck=true
						$('#likeBtn').attr('src','../img/images/likeon.png')
					}
				}
			})
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
                        <h2>맛집 상세보기</h2>
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
        	<div class="row recipe_row">
        		<table class="table">
        			<tr>
        				<td class="text-center" colspan="3">
        					<img src="${vo.poster}" style="width: 700px; height: 450px">
        				</td>
        			</tr>
        			<tr>
        				<td class="text-center" colspan="3">
        					<h3>${vo.title}</h3>
        				</td>
        			</tr>
        			<tr>
        				<td style="color: gray" colspan="3">${vo.content}</td>
        			</tr>
        			<tr>
        				<td class="text-center"><img src="../recipe/icon/a1.png"></td>
        				<td class="text-center"><img src="../recipe/icon/a2.png"></td>
        				<td class="text-center"><img src="../recipe/icon/a3.png"></td>
        			</tr>
        			
        			<tr>
        				<td class="text-center">${vo.info1}</td>
        				<td class="text-center">${vo.info2}</td>
        				<td class="text-center">${vo.info3}</td>
        			</tr>
        			<tr>
	                 <td class="text-right" colspan="3">
	                 <c:if test="${sessionScope.id != null && sessionScope.admin == 'n'}">
	                  <a href="#" class="btn btn-xs">
	                    <img src="../img/images/likeoff.png" style="width: 25px; height: 25px" class="img-link" id="likeBtn">
	                  </a>
	                  
	                  <a href="#" class="btn btn-xs btn-success">찜하기</a>
	                 </c:if>
	                 <a href="../recipe/list.do" class="btn btn-xs btn-info">목록</a>
	                 </td>
	                </tr>
        		</table>
        		<table class="table">
        			<tr>
        				<td colspan="2"><h3>[조리순서]</h3></td>
        			</tr>
        			<tr>
        				<td>
        					<c:forEach var="msg" items="${mList}" varStatus="s">
        						<table class="table">
        							<tr>
        								<td class="text-left" width="80%">${msg}</td>
        								<td class="text-right" width="20%">
        									<img src="${iList[s.index]}" style="width: 150px; height: 100px">
        								</td>
        							</tr>
        						</table>
        					</c:forEach>
        				</td>
        			</tr>
        		</table>
        		<table class="table">
        			<tr>
        				<td colspan="2"><h3>레시피 작성자</h3></td>
        			</tr>
        			<tr>
        				<td width="30%" rowspan="2" class="text-center">
        					<img src="${vo.chef_poster}" style="width: 100px; height: 100px" class="img-circle">
        				</td>
        				<td width="70%">${vo.chef}</td>
        			</tr>
        			<tr>
        				<td width="70%">${vo.chef_profile}</td>
        			</tr>
        		</table>
        	</div>
        </div>
    </section>

</body>
</html>