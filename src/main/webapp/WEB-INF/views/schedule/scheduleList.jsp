<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String listName = (String) session.getAttribute("listName");
%>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>일정 보기</title>
  <!-- Kakao Maps -->
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e91447aad4b4b7e4b923ab8dd1acde77&libraries=clusterer"></script>
  <style>
  h2{font-family:'Inter',sans-serif;font-size:28px;font-weight:700;letter-spacing:-.02em}
  
    .schedule-list { width: 340px; max-height: 600px; overflow-y: auto; }
    .day-title { margin-top: 24px; font-size: 22px; font-weight: 600; }
    .mycard {
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 14px;
      margin: 10px 0;
    }
    .mycard strong { font-size: 16px; }
    .mycard time { display: block; margin-top: 4px; color: #666; font-size: 14px; }
    #map { flex: 1 1 0%; min-height: 600px; border: 1px solid #ccc; }
    .container { display: flex; gap: 40px; max-width: 1440px; margin: 48px auto; padding: 0 48px; }
    @media (max-width: 760px) {
      .container { flex-direction: column; }
      .schedule-list { width: 100%; }
      #map { min-height: 480px; }
    }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <br>
<h2 style="margin-left: 280px;"><%= listName %></h2>

  <c:choose>
    <c:when test="${empty calList}">
      <p>저장된 일정이 없습니다.</p>
    </c:when>
    <c:otherwise>
      <div class="container">
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
                <div class="mycard">
                  <strong>${c.locationName}</strong>
                  <time>${c.calanderStartTime} ~ ${c.calanderEndTime}</time>
                </div>
              </c:if>
            </c:forEach>
          </c:forEach>
        </section>
        <div id="map"></div>
      </div>
    </c:otherwise>
  </c:choose>

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