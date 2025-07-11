<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <title>숙소 등록</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=services,clusterer"></script>
<style>
  body {
    font-family: 'Pretendard', sans-serif;
    background-color: #f9f9f9;
    margin: 0;
  }

  .container {
    max-width: 900px;
    margin: 40px auto;
    padding: 40px;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
  }

  h2 {
    font-size: 28px;
    margin-bottom: 40px;
    border-bottom: 2px solid #000;
    padding-bottom: 10px;
    text-align: left;
  }

  .form-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 24px;
  }

  .form-group.two-column {
    display: grid;
    grid-template-columns: 150px 1fr;
    gap: 16px;
    align-items: center;
  }

  .form-group label {
    font-weight: 600;
    font-size: 15px;
    color: #333;
    margin-bottom: 8px;
  }

  .form-group.two-column label {
    margin-bottom: 0;
    text-align: left;
  }

  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 15px;
    background-color: #fafafa;
    box-sizing: border-box;
    transition: border-color 0.2s ease;
  }

  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: #000;
  }

  textarea {
    resize: vertical;
    min-height: 120px;
  }

  .address-group {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 12px;
    align-items: end;
  }

  .address-group input {
    margin-bottom: 0;
  }

  .detail-address-group {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 12px;
    align-items: end;
  }

  #map {
    width: 100%;
    height: 300px;
    border-radius: 12px;
    margin-top: 16px;
    border: 1px solid #ddd;
  }

  .form-buttons {
    text-align: center;
    margin-top: 40px;
  }

  .btn {
    display: inline-block;
    padding: 12px 24px;
    font-size: 15px;
    font-weight: 600;
    color: #fff;
    background-color: #000;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.2s ease;
    white-space: nowrap;
  }

  .btn:hover {
    background-color: #333;
  }

  .btn-secondary {
    background-color: #666;
    color: #fff;
    padding: 10px 16px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    transition: background 0.2s ease;
  }

  .btn-secondary:hover {
    background-color: #555;
  }

  .file-input-wrapper {
    position: relative;
    overflow: hidden;
    display: inline-block;
    width: 100%;
  }

  .file-input-wrapper input[type=file] {
    position: absolute;
    left: -9999px;
  }

  .file-input-display {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fafafa;
    cursor: pointer;
    transition: border-color 0.2s ease;
  }

  .file-input-display:hover {
    border-color: #000;
  }

  .file-input-display .file-text {
    flex: 1;
    color: #666;
  }

  .file-input-display .file-btn {
    background-color: #000;
    color: #fff;
    padding: 6px 12px;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
  }

  @media (max-width: 768px) {
    .container {
      margin: 20px;
      padding: 30px 20px;
    }
    
    .form-group.two-column {
      grid-template-columns: 1fr;
      gap: 8px;
    }
    
    .address-group,
    .detail-address-group {
      grid-template-columns: 1fr;
      gap: 8px;
    }
  }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>
<div class="container">
  <h2>숙소 등록</h2>
  <form method="post" action="/accomm/insert" enctype="multipart/form-data" onsubmit="return validateForm()">

    <!-- 지역 선택 -->
    <div class="form-group two-column">
      <label for="regionDropdown">지역 선택</label>
      <select id="regionDropdown" onchange="updateSigunguOptions()">
        <option value="">-- 선택 --</option>
        <c:forEach var="r" items="${regionList}">
          <option value="${r.regionId}">${r.regionName}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 시군구 선택 -->
    <div class="form-group two-column">
      <label for="sigunguDropdown">시군구 선택</label>
      <select id="sigunguDropdown" onchange="syncSelectedCodes()">
        <option value="">-- 선택 --</option>
      </select>
    </div>

    <!-- 숨겨진 값 (DB insert용) -->
    <input type="hidden" id="regionId" name="regionId">
    <input type="hidden" id="sigunguCode" name="sigunguCode">
    <input type="hidden" id="accomLat" name="accomLat">
    <input type="hidden" id="accomLon" name="accomLon">

    <!-- 주소 입력 -->
    <div class="form-group">
      <label for="zipCode">우편번호</label>
      <div class="address-group">
        <input type="text" id="zipCode" name="zipcode" readonly>
        <button type="button" class="btn" onclick="execPostCode()">주소 검색</button>
      </div>
    </div>

    <div class="form-group">
      <label>도로명 주소</label>
      <input type="text" id="streetAdr" name="accomAdd" readonly>
    </div>

    <div class="form-group">
      <label>상세 주소</label>
      <div class="detail-address-group">
        <input type="text" id="detailAdr" name="accomAdd2" placeholder="예: 3층 301호">
        <button type="button" class="btn-secondary" onclick="loadMapFromAddress()">📍 위치 확인</button>
      </div>
    </div>

    <!-- 지도 영역 -->
    <div class="form-group">
      <label>위치 미리보기</label>
      <div id="map"></div>
    </div>

    <!-- 기타 입력 -->
    <div class="form-group two-column">
      <label>숙소명</label>
      <input type="text" name="accomName" required>
    </div>

    <div class="form-group two-column">
      <label>대표 전화</label>
      <input type="text" name="accomTel">
    </div>

    <div class="form-group">
      <label>대표 이미지</label>
      <div class="file-input-wrapper">
        <input type="file" name="firstImageFile" id="firstImageFile" accept="image/*">
        <div class="file-input-display" onclick="document.getElementById('firstImageFile').click()">
          <span class="file-text">이미지 파일을 선택하세요</span>
          <span class="file-btn">파일 선택</span>
        </div>
      </div>
    </div>
    
    <div class="form-group">
      <label for="accomDes">숙소 설명</label>
      <textarea name="accomDes" id="accomDes" rows="6" placeholder="숙소에 대한 상세한 설명을 입력해주세요"></textarea>
    </div>

    <div class="form-buttons">
      <button type="submit" class="btn">숙소 등록</button>
    </div>

  </form>
</div>

<script>
  // 파일 선택 표시 업데이트
  document.getElementById('firstImageFile').addEventListener('change', function(e) {
    const fileText = document.querySelector('.file-text');
    if (e.target.files.length > 0) {
      fileText.textContent = e.target.files[0].name;
    } else {
      fileText.textContent = '이미지 파일을 선택하세요';
    }
  });

  // 서버 데이터 → JS 배열 (첫 번째 코드 패턴 적용)
  const sigunguData = [
    <c:forEach var="s" items="${sigunguList}" varStatus="loop">
      { regionId:"${s.regionId}", sigunguId:"${s.sigunguId}", sigunguName:"${s.sigunguName}" }<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];

  // 드롭다운 선택 로직 (첫 번째 코드 패턴 적용)
  function updateSigunguOptions() {
    const rId = $('#regionDropdown').val();
    const $sSelect = $('#sigunguDropdown');
    
    // 시군구 드롭다운 초기화
    $sSelect.empty().append('<option value="">-- 선택 --</option>');

    // 선택된 지역에 해당하는 시군구만 필터링해서 추가
    sigunguData.filter(v => v.regionId === rId)
               .forEach(v => $sSelect.append(
                 $('<option>', { value: v.sigunguId, text: v.sigunguName })
               ));

    // regionId hidden 값 갱신
    $('#regionId').val(rId);
    // 시군구 초기화
    $('#sigunguId').val('');
  }

  function syncSelectedCodes() {
    $('#sigunguCode').val($('#sigunguDropdown').val());
  }

  function execPostCode() {
    new daum.Postcode({
      oncomplete: function(data) {
        $('#zipCode').val(data.zonecode);
        $('#streetAdr').val(data.roadAddress);

        // region 자동 선택
        $.post('/accomm/regionSelect', { streetAdr: data.roadAddress }, function(res) {
          if (res.code === 0) {
            const regionId = res.data.regionId;
            $('#regionDropdown').val(regionId).trigger('change');

            // sigungu 자동 선택은 region 반영 후 수행
            setTimeout(() => {
              $.post('/accomm/sigunguSelect', { streetAdr: data.roadAddress, regionId: regionId }, function(res2) {
                if (res2.code === 0) {
                  $('#sigunguDropdown').val(res2.data.sigunguId).trigger('change');
                }
              }, 'json');
            }, 300);
          }
        }, 'json');
      }
    }).open();
  }

  function loadMapFromAddress() {
    const addr = $('#streetAdr').val() + ' ' + ($('#detailAdr').val() || '');
    if (!addr.trim()) return alert('주소를 먼저 입력하세요');

    const geocoder = new kakao.maps.services.Geocoder();
    geocoder.addressSearch(addr, function(result, status) {
      if (status === kakao.maps.services.Status.OK) {
        const lat = result[0].y;
        const lon = result[0].x;

        $('#accomLat').val(lat);
        $('#accomLon').val(lon);

        const mapContainer = document.getElementById('map');
        const mapOption = { center: new kakao.maps.LatLng(lat, lon), level: 3 };
        const map = new kakao.maps.Map(mapContainer, mapOption);
        const marker = new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lon) });
        marker.setMap(map);
      } else {
        alert('지도를 찾을 수 없습니다.');
      }
    });
  }

  function validateForm() {
    if (!$('#regionId').val() || !$('#sigunguCode').val()) {
      alert('지역과 시군구를 선택해주세요.');
      return false;
    }
    if (!$('#accomLat').val() || !$('#accomLon').val()) {
      alert('주소를 입력한 후 위치 확인 버튼을 눌러주세요.');
      return false;
    }
    return true;
  }
</script>
</body>
</html>