<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/sellerHead.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
  }

  main.wrap {
    max-width: 100%;
    padding: 40px 60px;
    box-sizing: border-box;
  }

  .form-box {
    max-width: 900px;
    margin: 0 auto;
    background: #fff;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
  }

  h2 {
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 30px;
    border-bottom: 2px solid #000;
    padding-bottom: 10px;
  }

  .section-title {
    font-size: 18px;
    font-weight: 600;
    margin-top: 40px;
    margin-bottom: 16px;
    color: #222;
    border-bottom: 1px solid #ddd;
    padding-bottom: 6px;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 24px;
  }

  .form-group label {
    font-size: 14px;
    color: #444;
    font-weight: 500;
    margin-bottom: 8px;
  }

  .form-group input,
  .form-group select,
  .form-group textarea {
    padding: 14px 16px;
    border: 1px solid #ddd;
    border-radius: 12px;
    font-size: 15px;
    background-color: rgba(250, 250, 250, 0.95);
    transition: all 0.2s ease;
  }

  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: #000;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.04);
  }

  .form-row {
    display: grid;
    grid-template-columns: 160px 1fr;
    gap: 16px;
    align-items: center;
    margin-bottom: 20px;
  }

  .form-row input,
  .form-row select {
    height: 48px;
    padding: 10px 14px;
    font-size: 15px;
    border: 1px solid #ddd;
    border-radius: 12px;
    background-color: rgba(250, 250, 250, 0.95);
    transition: all 0.2s ease;
  }

  .form-row input:focus,
  .form-row select:focus {
    outline: none;
    border-color: #000;
    box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.04);
  }

  .checkbox-group {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
  }

  .checkbox-group label {
    font-weight: 400;
    font-size: 14px;
  }

  .btn {
    padding: 12px 28px;
    background: linear-gradient(135deg, #000 0%, #222 100%);
    color: #fff;
    font-weight: 600;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.08);
  }

  .btn:hover {
    background: linear-gradient(135deg, #333 0%, #000 100%);
    transform: translateY(-1px);
  }

  .file-drop-zone {
    border: 2px dashed #ccc;
    padding: 30px;
    border-radius: 16px;
    text-align: center;
    cursor: pointer;
    background: #fafafa;
    transition: border-color 0.3s ease;
  }

  .file-drop-zone:hover {
    border-color: #888;
  }

  .file-text {
    color: #666;
    font-size: 14px;
  }

  @media (max-width: 768px) {
    .form-row {
      grid-template-columns: 1fr;
    }

    .form-box {
      padding: 24px;
    }
  }
</style>

<main class="wrap">
  <div class="form-box">
    <h2>객실 등록</h2>
    <form method="post" action="/seller/roomAdd" enctype="multipart/form-data" onsubmit="return cleanPrice()">
      <input type="hidden" name="accommId" value="${accommId}" />

      <div class="form-row">
        <label>객실명</label>
        <input type="text" name="roomName" required />
      </div>

      <div class="form-row">
        <label>객실 면적 (㎡)</label>
        <input type="number" name="roomScale" required />
      </div>

      <div class="form-row">
        <label>객실 수</label>
        <input type="number" name="roomCount" min="1" required />
      </div>

      <div class="form-row">
        <label>기준 인원</label>
        <input type="number" name="standardPerson" min="1" required />
      </div>

      <div class="form-row">
        <label>체크인 시간</label>
        <input type="text" name="checkIn" placeholder="예: 15:00" required />
      </div>

      <div class="form-row">
        <label>체크아웃 시간</label>
        <input type="text" name="checkOut" placeholder="예: 11:00" required />
      </div>

      <div class="form-row">
        <label>기본 요금 (₩)</label>
        <input type="text" name="standardPrice" id="priceInput" required />
      </div>

      <h3 class="section-title">객실 옵션</h3>
      <div class="form-group">
        <div class="checkbox-group">
          <label><input type="checkbox" name="bathroom" value="Y" /> 욕실</label>
          <label><input type="checkbox" name="bath" value="Y" /> 욕조</label>
          <label><input type="checkbox" name="tv" value="Y" /> TV</label>
          <label><input type="checkbox" name="pc" value="Y" /> PC</label>
          <label><input type="checkbox" name="internet" value="Y" /> 인터넷</label>
          <label><input type="checkbox" name="refrigerator" value="Y" /> 냉장고</label>
          <label><input type="checkbox" name="sofa" value="Y" /> 소파</label>
          <label><input type="checkbox" name="table" value="Y" /> 테이블</label>
          <label><input type="checkbox" name="dryer" value="Y" /> 드라이기</label>
        </div>
      </div>

      <div class="form-group">
        <label>객실 대표 이미지</label>
        <div class="file-drop-zone" onclick="document.getElementById('roomImageFile').click()">
          <span class="file-text">클릭하거나 드래그하여 파일을 선택하세요</span>
        </div>
        <input type="file" name="roomImageFile" id="roomImageFile" accept="image/*" style="display: none;">
      </div>

      <div class="form-group" style="text-align: center;">
        <button type="submit" class="btn">객실 등록</button>
      </div>
    </form>
  </div>
</main>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // 가격 입력 시 자동 콤마 처리
  $('#priceInput').on('input', function () {
    let val = $(this).val().replace(/,/g, '');
    if (!isNaN(val)) {
      $(this).val(Number(val).toLocaleString());
    }
  });

  // 제출 시 콤마 제거
  function cleanPrice() {
    const raw = $('#priceInput').val().replace(/,/g, '');
    $('#priceInput').val(raw);
    return true;
  }

  // 파일 선택시 이름 표시
  document.getElementById('roomImageFile').addEventListener('change', function(e) {
    const zone = document.querySelector('.file-drop-zone .file-text');
    if (e.target.files.length > 0) {
      zone.textContent = e.target.files[0].name;
    } else {
      zone.textContent = '클릭하거나 드래그하여 파일을 선택하세요';
    }
  });
</script>
