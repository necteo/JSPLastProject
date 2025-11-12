<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>맛집 예약 UI (Bootstrap)</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body{
      background-color:#f8f9fa;
      font-family:'Noto Sans KR', sans-serif;
    }
    .card{
      box-shadow:0 4px 10px rgba(0,0,0,0.05);
      border:none;
      border-radius:12px;
    }
    .card-header{
      font-weight:700;
      font-size:1.1rem;
    }
    #food_list{
      height:600px;
      overflow-y:auto;
    }
    .food-item:hover{
      background-color:#f1f1f1;
      cursor:pointer;
    }
    img#food_poster{
      border-radius:8px;
    }
  </style>
  <script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
  <script type="text/javascript">
  $(function() {
	  foodReader('한식')
  })
  function foodReader(type) {
	  $.ajax({
		  type: 'post',
		  url: '../reserve/reserve_food.do',
		  data: {"type": type},
		  success: function(result) {
			  $('#food_list').html(result)
		  },
		  error: function(error) {
			  console.log(error)
		  }
	  })
  }
  </script>
</head>
<body>
  <div class="container my-4">
    <div class="row g-4">
      <!-- 맛집 정보 -->
      <div class="col-md-4">
        <div class="card h-100">
          <div class="card-header bg-danger text-white text-center">맛집 정보</div>
          <div class="card-body" id="food_list">
            
          </div>
        </div>
      </div>

      <!-- 예약일 정보 -->
      <div class="col-md-5">
        <div class="card h-100">
          <div class="card-header bg-info text-white text-center">예약일 정보</div>
          <div class="card-body text-center" id="food_rdays">
            <p class="text-muted">날짜를 선택하세요</p>
            <div class="d-flex justify-content-center flex-wrap gap-2">
              <button class="btn btn-outline-info btn-sm" onclick="pickDay('2025-11-18')">2025-11-18</button>
              <button class="btn btn-outline-info btn-sm" onclick="pickDay('2025-11-19')">2025-11-19</button>
              <button class="btn btn-outline-info btn-sm" onclick="pickDay('2025-11-20')">2025-11-20</button>
            </div>
          </div>
        </div>
      </div>

      <!-- 예약 정보 -->
      <div class="col-md-3">
        <div class="card h-100">
          <div class="card-header bg-success text-white text-center">예약 정보</div>
          <div class="card-body text-center">
            <img id="food_poster" src="" class="img-fluid mb-3" alt="poster" style="display: none">
            <table class="table table-borderless text-start" style="display: none" id="reserve_info">
              <tbody>
                <tr><td class="text-muted">업체명</td><td id="food_name">-</td></tr>
                <tr><td class="text-muted">예약일</td><td id="food_reserve_day">-</td></tr>
                <tr><td class="text-muted">예약시간</td><td id="food_reserve_time">-</td></tr>
                <tr><td class="text-muted">예약인원</td><td id="food_reserve_inwon">-</td></tr>
              </tbody>
            </table>
            <form method="post" action="../reserve/reserve_insert.do" id="reserveBtn" style="display:none">
              <input type="hidden" name="fno" id="rfno">
              <input type="hidden" name="day" id="rday">
              <input type="hidden" name="time" id="rtime">
              <input type="hidden" name="inwon" id="rinwon">
              <button type="submit" class="btn btn-primary w-100">예약하기</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <div class="row g-4 mt-3">
      <div class="col-md-4">
        <div class="card">
          <div class="card-header bg-primary text-white text-center">시간 정보</div>
          <div class="card-body text-center" id="reserve_time2">
            <div class="d-flex justify-content-center gap-2 flex-wrap">
              <button class="btn btn-outline-primary btn-sm">11:00</button>
              <button class="btn btn-outline-primary btn-sm">12:00</button>
              <button class="btn btn-outline-primary btn-sm">18:00</button>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-8">
        <div class="card">
          <div class="card-header bg-info text-white text-center">인원 정보</div>
          <div class="card-body text-center" id="reserve_inwon">
            <div class="d-flex justify-content-center gap-2 flex-wrap">
              <button class="btn btn-outline-success btn-sm" onclick="pickInwon(2)">2명</button>
              <button class="btn btn-outline-success btn-sm" onclick="pickInwon(4)">4명</button>
              <button class="btn btn-outline-success btn-sm" onclick="pickInwon(6)">6명</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

</body>
</html>