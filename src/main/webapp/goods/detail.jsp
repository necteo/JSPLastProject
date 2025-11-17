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
 .goods-detail {
    margin-top: 50px;
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
  }
  .goods-image {
    max-width: 100%;
    border-radius: 8px;
    box-shadow: 0 0 6px rgba(0,0,0,0.1);
  }
  #title {
    font-size: 22px;
    font-weight: bold;
  }
  #sub {
    color: #666;
    font-size: 15px;
  }
  #percent {
    color: #e74c3c;
    font-weight: bold;
    font-size: 18px;
  }
  #price {
    font-size: 20px;
    font-weight: bold;
    color: #2c3e50;
  }
  #psub {
    color: #999;
    font-size: 14px;
  }
  #total {
    font-weight: bold;
    font-size: 18px;
    color: #16a085;
  }
  #cart, #buy, #go {
    width: 25%;
    margin-right: 1%;
    height: 40px;
    font-weight: bold;
  }
  #cart {
    background-color: #f39c12;
    color: #fff;
    border: none;
  }
  #buy {
    background-color: #e74c3c;
    color: #fff;
    border: none;
  }
  #go {
    background-color: #95a5a6;
    color: #fff;
    border: none;
  }
  #cart:hover { background-color: #e67e22; }
  #buy:hover { background-color: #c0392b; }
  #go:hover { background-color: #7f8c8d; }
</style>
<link rel="stylesheet" href="../css/table.css">
<link rel="stylesheet" href="../shadow/css/shadowbox.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="../shadow/js/shadowbox.js"></script>
<script type="text/javascript" src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
let sel = 0
Shadowbox.init({
	players: ['iframe']
})
$(function() {
	$('#sel').change(function() {
		let account = $('#sel').val()
		if (account !== "수량 선택") {
		    sel = 1
		    let price = $('#title').attr("data-price");
		    let total = Number(price) * Number(account)
		    $('#total').text(total.toLocaleString() + "원")
		} else {
			 sel = 0
		}
	})
	$('#cart').click(function() {
		if (sel == 0) {
		  alert("수량을 선택하세요!!");
		  return
		}
		let account = $('#sel').val()
		$('#account').val(account)
		$('#frm').submit()
	})
	$('#buy').click(function() {
		if (sel == 0) {
			  alert("수량을 선택하세요!!");
			  return
			}
		let account = $('#sel').val()
		let gno = $('#gno').val()
		Shadowbox.open({
			content: '../goods/buy.do?gno=' + gno + '&account=' + account,
			player: 'iframe',
			width: 960,
			heigth: 750,
			title: '결제 내역'
		})
	})
})
function ok(cno,page) {
	location.href = "../goods/list.do?cno=" + cno + "&page=" + page
}
</script>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg)">
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
  <div class="container goods-detail">
    <div class="row">
      <div class="col-md-5 text-center">
        <img src="${vo.goods_poster}" id="image" class="goods-image img-responsive">
      </div>

      <div class="col-md-7">
        <table class="table table-bordered">
          <tr>
            <td colspan="2" class="text-center">
              <span id="title" data-price="${vo.price}">${vo.goods_name}</span><br>
              <span id="sub">${vo.goods_sub}</span>
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <span id="percent">${vo.goods_discount}%</span>
              &nbsp;<span id="price">${vo.goods_price}</span>
              <p><del id="psub">500,000원</del></p>
            </td>
          </tr>
          <tr>
            <td>
              <img src="https://recipe1.ezmember.co.kr/img/mobile/icon_delivery3.png" width="20" height="20">
              &nbsp;<span id="del">${vo.goods_delivery}</span>
            </td>
            <td>
              <img src="https://recipe1.ezmember.co.kr/img/mobile/icon_point.png" width="20" height="20">
              &nbsp;<span id="del">10% 적립</span>
            </td>
          </tr>
          <tr>
            <td colspan="2">
              <select id="sel" class="form-control input-sm">
                <option>수량 선택</option>
                <c:forEach var="i" begin="1" end="10">
                  <option value="${i}">${i}개</option>
                </c:forEach>
              </select>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="text-right">
              총금액: <span id="total">${vo.goods_price}</span>
            </td>
          </tr>
          <tr>
            <td colspan="2" class="text-center">
             <c:if test="${sessionScope.id != null && sessionScope.admin == 'n'}">
              <form method="post" action="../cart/cart_insert.do" id="frm">
                <input type="hidden" name="gno" id="gno" value="${vo.no}">
                <input type="hidden" name="account" id="account">
                <input type="button" value="장바구니" id="cart" class="btn" data-no="${vo.no}" >
              </form>
              <input type="button" value="바로구매" id="buy" class="btn">
             </c:if>
              <input type="button" value="목록" id="go" class="btn" onclick="ok(${cno}, ${page})">
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</section>

</body>
</html>