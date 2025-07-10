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
    .container { max-width:600px; margin:40px auto; padding:40px; border:1px solid #ddd; border-radius:12px; background:#fff; }
    .form-group { margin-bottom:20px; display:flex; flex-direction:column; }
    label { font-weight:600; margin-bottom:6px; }
    input, select { padding:12px; border:1px solid #ccc; border-radius:8px; }
    #map { width:100%; height:300px; border-radius:8px; margin-top:12px; }
    button { padding:10px; border:none; background:#000; color:#fff; border-radius:8px; font-weight:bold; cursor:pointer; }
    .btn-secondary { background:#444; margin-top:8px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>
<div class="container">
  <h2>숙소 등록</h2>
  <form method="post" action="/accomm/insert" enctype="multipart/form-data" onsubmit="return validateForm()">

    <!-- 지역 선택 -->
    <div class="form-group">
      <label for="regionDropdown">지역 선택</label>
      <select id="regionDropdown" onchange="updateSigunguOptions()">
        <option value="">-- 선택 --</option>
        <c:forEach var="r" items="${regionList}">
          <option value="${r.regionId}">${r.regionName}</option>
        </c:forEach>
      </select>
    </div>

    <!-- 시군구 선택 -->
    <div class="form-group">
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
      <label>우편번호</label>
      <input type="text" id="zipCode" name="zipcode" readonly onclick="execPostCode()">
      <button type="button" class="btn-secondary" onclick="execPostCode()">주소 검색</button>
    </div>

    <div class="form-group">
      <label>도로명 주소</label>
      <input type="text" id="streetAdr" name="accomAdd" readonly>
    </div>

    <div class="form-group">
      <label>상세 주소</label>
      <input type="text" id="detailAdr" name="accomAdd2" placeholder="예: 3층 301호">
      <button type="button" class="btn-secondary" onclick="loadMapFromAddress()">📍 위치 확인</button>
    </div>

    <!-- 지도 영역 -->
    <div id="map"></div>

    <!-- 기타 입력 -->
    <div class="form-group">
      <label>숙소명</label>
      <input type="text" name="accomName" required>
    </div>

    <div class="form-group">
      <label>대표 전화</label>
      <input type="text" name="accomTel">
    </div>

    <div class="form-group">
      <label>대표 이미지</label>
      <input type="file" name="firstImageFile">
    </div>
    
	<div class="form-group">
	  <label>숙소 설명</label>
	  <textarea name="accomDes" rows="5" style="padding:12px; border:1px solid #ccc; border-radius:8px;"></textarea>
	</div>
	
    <button type="submit">숙소 등록</button>
  </form>
</div>

<script>
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