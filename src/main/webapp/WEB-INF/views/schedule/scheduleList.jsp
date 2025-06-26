<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>일정 보기</title>

  <!-- Kakao Maps -->
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=clusterer"></script>

  <style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 32px; }
    h2 { margin-bottom: 24px; font-size: 28px; font-weight: 700; }

    .container { display: flex; gap: 32px; }
    .schedule-list { width: 340px; max-height: 600px; overflow-y: auto; }
    .day-title { margin-top: 24px; font-size: 22px; font-weight: 600; }
    .card { border: 1px solid #ddd; border-radius: 10px; padding: 14px; margin: 10px 0; }
    .card strong { font-size: 16px; }
    .card time { display: block; margin-top: 4px; color: #666; font-size: 14px; }

    #map { flex: 1 1 0%; min-height: 600px; border: 1px solid #ccc; }

    @media (max-width:760px){
      .container { flex-direction: column; }
      .schedule-list { width: 100%; }
      #map { min-height: 480px; }
    }
  </style>
</head>
<body>
<h2>🗺 저장된 일정</h2>

<!-- ✅ 0. 전체 Calander 객체 디버깅 -->


<c:choose>
  <c:when test="${empty calList}">
    <p>저장된 일정이 없습니다.</p>
  </c:when>

  <c:otherwise>
    <div class="container">
      <!-- ① Day 별 일정 출력 -->
      <section class="schedule-list">
        <c:set var="maxDay" value="0" />
        <c:forEach var="c" items="${calList}">
          <c:if test="${c.calDayNo > maxDay}">
            <c:set var="maxDay" value="${c.calDayNo}" />
          </c:if>
        </c:forEach>

        <c:forEach var="d" begin="1" end="${maxDay}">
          <h3 class="day-title">Day ${d}</h3>
          <c:forEach var="c" items="${calList}">
            <c:if test="${c.calDayNo == d}">
              <div class="card">
                <strong>${c.locationName}</strong>
                <time>${c.calanderStartTime} ~ ${c.calanderEndTime}</time>
              </div>
            </c:if>
          </c:forEach>
        </c:forEach>
      </section>

      <!-- ② 지도 영역 -->
      <div id="map"></div>
    </div>
  </c:otherwise>
</c:choose>

<!-- ===== 지도 스크립트 ===== -->
<script>
const calList = [
  <c:forEach var="c" items="${calList}" varStatus="s">
    <c:if test="${not empty c.lat && not empty c.lon}">
      { name: "${c.locationName}", lat: ${c.lat}, lon: ${c.lon} }<c:if test="${!s.last}">,</c:if>
    </c:if>
  </c:forEach>
];

if (calList.length) {
  kakao.maps.load(() => {
    const map = new kakao.maps.Map(document.getElementById('map'), {
      center: new kakao.maps.LatLng(calList[0].lat, calList[0].lon),
      level: 6
    });

    calList.forEach(loc => {
      const marker = new kakao.maps.Marker({
        map,
        position: new kakao.maps.LatLng(loc.lat, loc.lon),
        title: loc.name
      });

      const info = new kakao.maps.InfoWindow({
        content: `<div style="padding:5px;">${loc.name}</div>`
      });
      kakao.maps.event.addListener(marker, 'click', () => info.open(map, marker));
    });
  });
}
</script>
</body>
</html>
