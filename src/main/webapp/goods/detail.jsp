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
.chef_row{
  margin: 0px auto;
  width: 850px;
}
#image {
	width: 100%;
	height: 350px;
	border-radius: 20px;
}
#title {
	font-size: 25px;
	font-weight: bold;
}
#sub {
	color: gray;
	text-align: center;
}
#percent {
	font-size: 25px;
	color: pink;
	font-weight: bold;
}
#price {
	font-size: 25px;
	font-weight: bold;	
}
#psub {
	font-size: 12px;
	color: #999;
}
#sel {
	width: 100%;
	height:	40px;
}
#cart, #buy, #go {
	width: 150px;
	height: 70px;
	border: 2px solid green;
	font-size: 20px;
	font-weight: bold;
	border-radius: 10px;
	box-shadow: 5px 5px 5px #A9A9A9;
	margin-left: 10px;
}
#cart {
	background-color:  white;
	color: green;
}
#buy {
	background-color:  green;
	color: white;
}
#go {
	background-color:  blue;
	color: white;
}
</style>
<script type="text/javascript">
function ok(cno, page) {
	location.href="../goods/list.do?cno=" + cno + "&page=" + page;
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
                        <h2>상품 상세보기</h2>
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
            <div class="row chef_row">
              <table class="table">
                <tr>
                  <td width="30%" class="text-center" rowspan="9">
                    <img src="${vo.goods_poster}" id="image">
                  </td>
                  <td width="70%" class="text-center">
                    <span id="title">${vo.goods_name}</span>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <span id="sub">${vo.goods_sub }</span>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <span id="percent">${vo.goods_discount}%</span>
                    &nbsp;<span id="price">${vo.goods_price}</span>
                    <p id="aaa">
                      <del id="psub">500,000원</del>
                    </p>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <img src="https://recipe1.ezmember.co.kr/img/mobile/icon_delivery3.png"_width="20" height="20">
                    <c:forEach var="i" begin="1" end="7">
                      &nbsp;
                    </c:forEach>
                    <span id="del">${vo.goods_delivery}</span>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <img src="https://recipe1.ezmember.co.kr/img/mobile/icon_point.png"_width="20" height="20">
                    <c:forEach var="i" begin="1" end="7">
                      &nbsp;
                    </c:forEach>
                    <span id="del">10% 적립</span>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <select id="sel" class="input-sm">
                      <option>수량 선택</option>
                      <c:forEach var="i" begin="1" end="10">
                        <option value="${i}">${i}개</option>
                      </c:forEach>
                    </select>
                  </td> 
                </tr>
                <tr>
                  <td width="70%">
                    총금액:<span id="total">${vo.goods_price}</span>
                  </td>
                </tr>
                <tr>
                  <td width="70%">
                    <input type="button" value="장바구니" id="cart" style="float: left;">
                    <input type="button" value="바로구매" id="buy" style="float: left;">
                    <input type="button" value="목록" id="go" style="float: left;" onclick="ok(${cno}, ${page})">
                  </td>
                </tr>
              </table>
            </div>
        </div>
    </section>
</body>
</html>