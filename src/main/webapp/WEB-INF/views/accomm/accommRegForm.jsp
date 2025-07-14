<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/sellerHead2.jsp" %>
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
  align-items: start; /* 중심 정렬 → 위 정렬로 변경 */
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

  .address-group,
  .detail-address-group {
    display: grid;
    grid-template-columns: 1fr auto;
    gap: 12px;
  }

  #map {
    width: 100%;
    height: 300px;
    border-radius: 12px;
    margin-top: 12px;
    border: 1px solid #ddd;
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

  .btn-secondary {
    background-color: #888;
    color: #fff;
    padding: 10px 16px;
    border-radius: 8px;
    font-size: 14px;
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
    <h2>숙소 등록</h2>
    <form method="post" action="/accomm/insert" enctype="multipart/form-data" onsubmit="return validateForm()">

      <h3 class="section-title">주소 정보</h3>

      <!-- 지역/시군구 선택 -->
      <div class="form-row">
        <label for="regionDropdown">지역</label>
        <select id="regionDropdown" onchange="updateSigunguOptions()">
          <option value="">-- 선택 --</option>
          <c:forEach var="r" items="${regionList}">
            <option value="${r.regionId}">${r.regionName}</option>
          </c:forEach>
        </select>
      </div>

      <div class="form-row">
        <label for="sigunguDropdown">시군구</label>
        <select id="sigunguDropdown" onchange="syncSelectedCodes()">
          <option value="">-- 선택 --</option>
        </select>
      </div>

      <input type="hidden" id="regionId" name="regionId">
      <input type="hidden" id="sigunguCode" name="sigunguCode">
      <input type="hidden" id="accomLat" name="accomLat">
      <input type="hidden" id="accomLon" name="accomLon">

      <!-- 주소 검색 -->
      <div class="form-group">
        <label>우편번호</label>
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
          <button type="button" class="btn-secondary" onclick="loadMapFromAddress()">위치 확인</button>
        </div>
      </div>

      <div class="form-group">
        <label>위치 미리보기</label>
        <div id="map"></div>
      </div>

      <h3 class="section-title">기본 정보</h3>

      <div class="form-row">
        <label>숙소명</label>
        <input type="text" name="accomName" required>
      </div>

      <div class="form-row">
        <label>대표 전화</label>
        <input type="text" name="accomTel">
      </div>

      <div class="form-group">
        <label>대표 이미지</label>
        <div class="file-drop-zone" onclick="document.getElementById('firstImageFile').click()">
          <span class="file-text">클릭하거나 드래그하여 파일을 선택하세요</span>
        </div>
        <input type="file" name="firstImageFile" id="firstImageFile" accept="image/*" style="display: none;">
      </div>

      <div class="form-group">
        <label>숙소 설명</label>
        <textarea name="accomDes" rows="6" placeholder="숙소에 대한 상세한 설명을 입력해주세요"></textarea>
      </div>

      <div class="form-group" style="text-align: center;">
        <button type="submit" class="btn">숙소 등록</button>
      </div>
    </form>
  </div>
</main>

<!-- ✅ Script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=services"></script>

<script>
  const sigunguData = [
    <c:forEach var="s" items="${sigunguList}" varStatus="loop">
      { regionId:"${s.regionId}", sigunguId:"${s.sigunguId}", sigunguName:"${s.sigunguName}" }<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];

  function updateSigunguOptions() {
    const rId = $('#regionDropdown').val();
    const $sSelect = $('#sigunguDropdown').empty().append('<option value="">-- 선택 --</option>');
    sigunguData.filter(v => v.regionId === rId)
      .forEach(v => $sSelect.append($('<option>', { value: v.sigunguId, text: v.sigunguName })));
    $('#regionId').val(rId);
  }

  function syncSelectedCodes() {
    $('#sigunguCode').val($('#sigunguDropdown').val());
  }

  function execPostCode() {
    new daum.Postcode({
      oncomplete: function(data) {
        $('#zipCode').val(data.zonecode);
        $('#streetAdr').val(data.roadAddress);
        $.post('/accomm/regionSelect', { streetAdr: data.roadAddress }, function(res) {
          if (res.code === 0) {
            const regionId = res.data.regionId;
            $('#regionDropdown').val(regionId).trigger('change');
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
        const map = new kakao.maps.Map(document.getElementById('map'), {
          center: new kakao.maps.LatLng(lat, lon),
          level: 3
        });
        new kakao.maps.Marker({ position: new kakao.maps.LatLng(lat, lon) }).setMap(map);
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

  // 파일명 표시
  document.getElementById('firstImageFile').addEventListener('change', function(e) {
    const zone = document.querySelector('.file-drop-zone .file-text');
    if (e.target.files.length > 0) {
      zone.textContent = e.target.files[0].name;
    } else {
      zone.textContent = '클릭하거나 드래그하여 파일을 선택하세요';
    }
  });
</script>
