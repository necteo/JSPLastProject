<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제하기</title>

<style>
:root {
  --bg: #f5f7fb;
  --white: #ffffff;
  --line: #e5e7eb;
  --text: #1f2937;
  --gray: #6b7280;
  --primary: #2563eb;
  --primary-light: #3b82f6;
  --shadow: 0 8px 24px rgba(0,0,0,0.06);
  --radius: 18px;
  --max-width: 1200px;
  font-family: "Noto Sans KR", sans-serif;
}
/*
body {
  margin: 0;
  padding: 0;
  background: var(--bg);
  color: var(--text);
}*/

/* ---------------- Layout ---------------- */
.checkout-container {
  display: grid;
  grid-template-columns: 1fr 400px;
  gap: 28px;
  max-width: var(--max-width);
  margin: 40px auto;
  padding: 0 20px;
}

.card {
  background: var(--white);
  border-radius: var(--radius);
  padding: 26px;
  box-shadow: var(--shadow);
}

/* ------------ Titles --------------- */
.title-main {
  font-size: 1.9rem;
  font-weight: 700;
  color: var(--primary);
  margin-bottom: 24px;
}

.card h2 {
  font-size: 1.15rem;
  margin-bottom: 16px;
  padding-left: 10px;
  border-left: 4px solid var(--primary);
}

/* ------------ Form --------------- */
.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 14px;
}

.form-group label {
  font-size: 0.92rem;
  margin-bottom: 6px;
  color: var(--gray);
}

.form-group input,
.form-group textarea {
  border: 1px solid var(--line);
  border-radius: 12px;
  padding: 12px 14px;
  font-size: 0.95rem;
  resize: none;
  transition: 0.2s;
}

.form-group input:focus,
.form-group textarea:focus {
  border-color: var(--primary);
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
  outline: none;
}

.zip-row {
  display: flex;
  gap: 10px;
}

.zip-row input {
  flex: 1;
}

.btn-small {
  padding: 12px 18px;
  border-radius: 12px;
  border: none;
  background: var(--primary);
  color: #fff;
  cursor: pointer;
  font-weight: 600;
  transition: background 0.2s;
}

.btn-small:hover {
  background: var(--primary-light);
}

/* ---------------- Summary ---------------- */
.summary {
  position: sticky;
  top: 20px;
  height: fit-content;
}

.summary ul {
  margin: 0;
  padding: 0;
  list-style: none;
  border-bottom: 1px dashed var(--line);
}

.summary ul li {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
}

.summary-total {
  display: flex;
  justify-content: space-between;
  padding-top: 14px;
  font-weight: bold;
  font-size: 1.05rem;
}

/* ---------------- Pay Button ---------------- */
.pay-btn {
  width: 100%;
  margin-top: 22px;
  padding: 16px;
  background: linear-gradient(90deg, var(--primary), var(--primary-light));
  border: none;
  border-radius: 14px;
  color: white;
  font-size: 1.1rem;
  font-weight: 700;
  cursor: pointer;
  transition: box-shadow 0.2s, transform 0.1s;
}

.pay-btn:hover {
  box-shadow: 0 6px 18px rgba(37, 99, 235, 0.28);
}

.pay-btn:active {
  transform: scale(0.97);
}

/* --------------- Responsive --------------- */
@media (max-width: 820px) {
  .checkout-container {
    grid-template-columns: 1fr;
  }
}
</style>
</head>

<body>
<div class="checkout-container">

  <!-- Left -->
  <div>
    <h1 class="title-main">💳 결제하기</h1>

    <div class="card">
      <h2>📦 배송지 정보</h2>

      <div class="form-group">
        <label>수취인</label>
        <input type="text" placeholder="${mvo.name}">
      </div>

      <div class="form-group">
        <label>연락처</label>
        <input type="text" placeholder="${mvo.phone}">
      </div>

      <div class="form-group">
        <label>우편번호</label>
        <div class="zip-row">
          <input type="text" placeholder="${mvo.post}">
          <button class="btn-small" type="button">검색</button>
        </div>
      </div>

      <div class="form-group">
        <label>주소</label>
        <input type="text" placeholder="${mvo.addr1}">
      </div>

      <div class="form-group">
        <label>상세주소</label>
        <input type="text" placeholder="${mvo.addr2}">
      </div>

      <div class="form-group">
        <label>배송메모</label>
        <textarea rows="3" placeholder="예: 문 앞에 놓아주세요"></textarea>
      </div>
    </div>
  </div>

  <!-- Right Summary -->
  <aside class="summary card">
    <h2>🧾 주문 요약</h2>

    <ul>
      <li><span>${gvo.goods_name}</span><span>₩ ${gvo.goods_price}</span></li>
      <li><span><img src="${gvo.goods_poster}" style="width: 100px; height: 100px"></span></li>
      <li><span id="buys" data-cont="${gvo.goods_name}(수량:${account})" data-total="${total}">수량</span><span>${account}</span></li>
    </ul>

    <div class="summary-total">
      <span>총 결제금액</span>
      <span>₩ ${total}원</span>
    </div>

    <button class="pay-btn">결제하기</button>
  </aside>

</div>
</body>
</html>