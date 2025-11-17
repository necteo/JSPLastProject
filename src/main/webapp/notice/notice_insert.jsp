<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.notice-form-wrap {
  max-width: 980px;
  margin: 20px auto;
  padding: 24px;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 6px 18px rgba(20,24,40,0.06);
}

/* 타이틀 */
.form-title {
  margin: 0 0 16px;
  font-size: 1.25rem;
  font-weight: 700;
}

/* 기본 행 */
.notice-form .form-row {
  display: flex;
  flex-direction: column;
  margin-bottom: 16px;
  gap: 6px;
}

.label {
  font-size: 0.95rem;
  color: #374151;
  font-weight: 600;
}

/* 기본 input */
.input, .textarea {
  border: 1px solid #d1d5db;
  padding: 10px 12px;
  border-radius: 8px;
  font-size: 0.95rem;
  background: #fff;
  outline: none;
  transition: all .15s ease;
}

.input:focus, .textarea:focus {
  border-color: #2563eb;
  box-shadow: 0 4px 12px rgba(37,99,235,0.18);
}

/* 파일 input */
.file-input {
  padding: 6px;
}

/* 버튼 */
.form-actions {
  display: flex;
  gap: 10px;
  justify-content: flex-end;
}

.btn {
  padding: 10px 16px;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  background: #f3f4f6;
  transition: 0.15s ease;
}

.btn:hover {
  background: #e5e7eb;
}

.btn.primary {
  background: #2563eb;
  color: white;
  box-shadow: 0 6px 16px rgba(37,99,235,0.25);
}

.btn.primary:hover {
  background: #1e4ed8;
}

/* 모바일 */
@media (max-width: 640px) {
  .notice-form-wrap {
    margin: 12px;
    padding: 18px;
  }
}

</style>
</head>
<body>
<section class="notice-form-wrap">
  <h2 class="form-title">공지 등록</h2>

  <form class="notice-form">
    <!-- 공지 종류 -->
    <div class="form-row">
      <label class="label">공지 종류</label>
      <select name="type" class="input">
        <option value="normal">일반</option>
        <option value="emergency">긴급</option>
        <option value="maintain">점검</option>
        <option value="event">이벤트</option>
      </select>
    </div>

    <!-- 제목 -->
    <div class="form-row">
      <label class="label">제목</label>
      <input type="text" name="title" class="input" required>
    </div>

    <!-- 내용 -->
    <div class="form-row">
      <label class="label">내용</label>
      <textarea name="content" class="textarea" rows="8" required></textarea>
    </div>

    <!-- 첨부파일 -->
    <div class="form-row">
      <label class="label">첨부파일</label>
      <input type="file" name="file" class="input file-input">
    </div>

    <!-- 버튼 -->
    <div class="form-actions">
      <button type="submit" class="btn primary">등록</button>
      <button type="reset" class="btn">초기화</button>
    </div>
  </form>
</section>

</body>
</html>