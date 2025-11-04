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
</style>
</head>
<body>
<!-- ****** Breadcumb Area Start ****** -->
    <div class="breadcumb-area" style="background-image: url(../img/bg-img/breadcumb.jpg);">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-12">
                    <div class="bradcumb-title text-center">
                        <h2>쉐프 목록</h2>
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
                <td>
                  <c:forEach var="vo" items="${list }">
                    <table class="table">
                     <tr>
                       <td rowspan="2" width="30%">
                        <img src="${vo.poster }"
                          style="width: 150px;height: 150px;"
                          class="img-circle">
                       </td>
                       <td colspan="4"><h3 style="color:orange">${vo.chef}</h3></td>
                     </tr>
                     <tr>
                       <td class="text-center"><img src="icon/m1.png">&nbsp;${vo.mem_cont1 }</td>
                       <td class="text-center"><img src="icon/m2.png">&nbsp;${vo.mem_cont2 }</td>
                       <td class="text-center"><img src="icon/m3.png">&nbsp;${vo.mem_cont7 }</td>
                       <td class="text-center"><img src="icon/m4.png">&nbsp;${vo.mem_cont3 }</td>
                     </tr>
                    </table>
                  </c:forEach>
                </td>
               </tr>
              </table>
              <table class="table">
                <tr>
                  <td class="text-center">
                    <ul class="pagination">
                     <c:if test="${startPage>1 }">
                      <li><a href="../recipe/chef_list.do?page=${startPage-1 }">&lt;</a></li>
                     </c:if>
                     <c:forEach var="i" begin="${startPage }" end="${endPage }">
                      <li ${i==curpage?'class=active':'' }><a href="../recipe/chef_list.do?page=${i }">${i }</a></li>
                     </c:forEach>
                     <c:if test="${endPage<totalpage }">
                      <li><a href="../recipe/chef_list.do?page=${endPage+1 }">&gt;</a></li>
                     </c:if>
                    </ul>
                  </td>
                </tr>
              </table>
            </div>
         </div>
    </section>
</body>
</html>