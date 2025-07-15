<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
  .discount-form {
    width: 600px;
    margin: 20px auto;
    font-family: sans-serif;
    border: 1px solid #ccc;
    padding: 20px;
    border-radius: 12px;
  }

  .discount-form h3 {
    text-align: center;
    margin-bottom: 20px;
  }

  .form-row {
    margin-bottom: 15px;
  }

  .form-row label {
    display: inline-block;
    width: 120px;
    font-weight: bold;
  }

  .weekday-section {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-left: 120px;
  }

  .weekday-section .weekday {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .weekday input[type="number"] {
    width: 100px;
    padding: 5px;
  }

  .form-row select,
  .form-row input[type="date"] {
    padding: 5px;
    width: 200px;
  }

  .submit-btn {
    text-align: center;
    margin-top: 20px;
  }

  .submit-btn button {
    padding: 10px 30px;
    background-color: #3478f6;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
  }
</style>

<div class="discount-form">
  <h3>할인 요금 설정</h3>
  <form action="/discount/apply" method="post">
    <!-- 적용 기간 -->
    <div class="form-row">
      <label>적용 기간</label>
      <input type="date" name="startDate" required> ~
      <input type="date" name="endDate" required>
    </div>

    <!-- 적용 객실 -->
    <div class="form-row">
      <label>적용 객실</label>
      <select name="roomId" required>
        <option value="">객실 선택</option>
        <option value="101">101호</option>
        <option value="102">102호</option>
        <option value="201">201호</option>
        <!-- 서버에서 동적 생성 가능 -->
      </select>
    </div>

    <!-- 요일별 설정 -->
    <div class="form-row">
      <label>적용 요일</label>
      <div class="weekday-section">
        <div class="weekday">
          <input type="checkbox" name="weekday" value="MON" id="mon">
          <label for="mon">월요일-목요일</label>
          <input type="number" name="price_mon" placeholder="금액 (원)">
        </div>
        <div class="weekday">
          <input type="checkbox" name="weekday" value="FRI" id="fri">
          <label for="fri">금요일</label>
          <input type="number" name="price_fri" placeholder="금액 (원)">
        </div>
        <div class="weekday">
          <input type="checkbox" name="weekday" value="SAT" id="sat">
          <label for="sat">토요일</label>
          <input type="number" name="price_sat" placeholder="금액 (원)">
        </div>
        <div class="weekday">
          <input type="checkbox" name="weekday" value="SUN" id="sun">
          <label for="sun">일요일</label>
          <input type="number" name="price_sun" placeholder="금액 (원)">
        </div>
      </div>
    </div>

    <div class="submit-btn">
      <button type="submit">할인 등록</button>
    </div>
  </form>
</div>


</body>
</html>