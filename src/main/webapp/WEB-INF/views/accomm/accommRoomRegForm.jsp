<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <title>객실 등록</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .container { max-width:600px; margin:40px auto; padding:40px; border:1px solid #ddd; border-radius:12px; background:#fff; }
    .form-group { margin-bottom:20px; display:flex; flex-direction:column; }
    label { font-weight:600; margin-bottom:6px; }
    input[type="text"], input[type="number"], input[type="time"], select, textarea {
      padding:12px; border:1px solid #ccc; border-radius:8px;
    }
    textarea { resize: vertical; height:100px; }
    .checkbox-group { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 6px; }
    .checkbox-group label { font-weight: normal; }
    button { padding:10px; border:none; background:#000; color:#fff; border-radius:8px; font-weight:bold; cursor:pointer; }
    .flex-row { display:flex; gap:10px; }
    .flex-row > div { flex:1; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>

<div class="container">
  <h2>객실 등록</h2>
  <form method="post" action="/room/insert" enctype="multipart/form-data">
    <!-- 숙소 ID는 hidden으로 -->
    <input type="hidden" name="accommId" value="${accommId}" />

    <div class="form-group">
      <label>객실명</label>
      <input type="text" name="accommRoomName" required />
    </div>

    <div class="form-group">
      <label>객실 면적 (㎡)</label>
      <input type="number" name="accommRoomScale" required />
    </div>

    <div class="form-group flex-row">
      <div>
        <label>객실 수</label>
        <input type="number" name="accommRoomCount" min="1" required />
      </div>
      <div>
        <label>기준 인원</label>
        <input type="number" name="accommRoomStandardPerson" min="1" required />
      </div>
    </div>

    <div class="form-group">
      <label>체크인 시간</label>
      <input type="text" name="accommRoomCheckin" placeholder="예: 15:00" required />
    </div>

    <div class="form-group">
      <label>체크아웃 시간</label>
      <input type="text" name="accommRoomCheckout" placeholder="예: 11:00" required />
    </div>

    <div class="form-group">
      <label>기본 요금 (₩)</label>
     <input type="text" name="accommRoomStandardPrice" id="priceInput" required />
    </div>

    <div class="form-group">
  <label>객실 옵션</label>
  <div class="checkbox-group">
    <input type="hidden" name="accommRoomBathroom" value="N" />
    <label><input type="checkbox" name="accommRoomBathroom" value="Y" /> 욕실</label>

    <input type="hidden" name="accommRoomBath" value="N" />
    <label><input type="checkbox" name="accommRoomBath" value="Y" /> 욕조</label>

    <input type="hidden" name="accommRoomTv" value="N" />
    <label><input type="checkbox" name="accommRoomTv" value="Y" /> TV</label>

    <input type="hidden" name="accommRoomPc" value="N" />
    <label><input type="checkbox" name="accommRoomPc" value="Y" /> PC</label>

    <input type="hidden" name="accommRoomInternet" value="N" />
    <label><input type="checkbox" name="accommRoomInternet" value="Y" /> 인터넷</label>

    <input type="hidden" name="accommRoomRefrigerator" value="N" />
    <label><input type="checkbox" name="accommRoomRefrigerator" value="Y" /> 냉장고</label>

    <input type="hidden" name="accommRoomSofa" value="N" />
    <label><input type="checkbox" name="accommRoomSofa" value="Y" /> 소파</label>

    <input type="hidden" name="accommRoomTable" value="N" />
    <label><input type="checkbox" name="accommRoomTable" value="Y" /> 테이블</label>

    <input type="hidden" name="accommRoomDryer" value="N" />
    <label><input type="checkbox" name="accommRoomDryer" value="Y" /> 드라이기</label>
  </div>
</div>

    <div class="form-group">
      <label>객실 대표 이미지</label>
      <input type="file" name="accommRoomImage" />
    </div>

    <button type="submit">객실 등록</button>
  </form>
</div>

</body>
<script>
  $(document).ready(function() {
    $('#priceInput').on('input', function() {
      let val = $(this).val().replace(/,/g, '');
      if (!isNaN(val)) {
        $(this).val(Number(val).toLocaleString());
      }
    });

    // 폼 제출 전 숫자만 넘기기
    $('form').on('submit', function() {
      const raw = $('#priceInput').val().replace(/,/g, '');
      $('#priceInput').val(raw); // 원래 숫자로 되돌림
    });
  });
</script>
</html>
