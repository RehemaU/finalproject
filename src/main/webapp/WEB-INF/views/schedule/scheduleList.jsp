<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  .btn-group {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin: 32px 280px;
  }

  .action-btn {
    display: inline-block;
    padding: 12px 20px;
    font-size: 15px;
    font-weight: 600;
    background: #111;
    color: #fff;
    border: none;
    border-radius: 8px;
    text-decoration: none;
    cursor: pointer;
    transition: background 0.2s ease;
  }

  .action-btn:hover {
    background: #333;
  }

  .action-btn.gray {
    background: #bbb;
    color: #fff;
  }

  .action-btn.gray:hover {
    background: #999;
  }

  .btn-group form {
    margin: 0;
  }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>
  <br>
<h2 style="margin-left: 280px;">
  <c:choose>
    <c:when test="${not empty list.calanderListName}">
      ${list.calanderListName}
    </c:when>
    <c:when test="${not empty sessionScope.listName}">
      ${sessionScope.listName}
    </c:when>
    <c:otherwise>
      일정 보기
    </c:otherwise>
  </c:choose>
</h2>  
  
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

<!-- 수정된 버튼 그룹 -->
<div class="btn-group">
  <a href="${pageContext.request.contextPath}/schedule/myList" class="action-btn">일정 목록</a>
  
  <!-- listId 파라미터 우선순위 수정 -->
  <c:choose>
    <c:when test="${not empty param.listId}">
      <a href="${pageContext.request.contextPath}/schedule/editForm?listId=${param.listId}" class="action-btn">일정 수정</a>
    </c:when>
    <c:when test="${not empty list.calanderListId}">
      <a href="${pageContext.request.contextPath}/schedule/editForm?listId=${list.calanderListId}" class="action-btn">일정 수정</a>
    </c:when>
    <c:when test="${not empty sessionScope.calanderListId}">
      <a href="${pageContext.request.contextPath}/schedule/editForm?listId=${sessionScope.calanderListId}" class="action-btn">일정 수정</a>
    </c:when>
  </c:choose>
  
  <!-- 삭제 폼도 동일한 우선순위 적용 -->
  <form action="${pageContext.request.contextPath}/schedule/deleteList" method="post" 
        onsubmit="return confirm('정말 삭제하시겠습니까?');">
    <c:choose>
      <c:when test="${not empty param.listId}">
        <input type="hidden" name="listId" value="${param.listId}" />
      </c:when>
      <c:when test="${not empty list.calanderListId}">
        <input type="hidden" name="listId" value="${list.calanderListId}" />
      </c:when>
      <c:when test="${not empty sessionScope.calanderListId}">
        <input type="hidden" name="listId" value="${sessionScope.calanderListId}" />
      </c:when>
    </c:choose>
    <button type="submit" class="action-btn gray">일정 삭제</button>
  </form>
</div>
    </c:otherwise>
  </c:choose>
  
  <script>
    const calList = [
      <c:forEach var="c" items="${calList}" varStatus="s">
        <c:if test="${not empty c.lat && not empty c.lon}">
          { 
            name: "${c.locationName}", 
            lat: ${c.lat}, 
            lon: ${c.lon}, 
            dayNo: ${c.calDayNo},
            startTime: "${c.calanderStartTime}"
          }<c:if test="${!s.last}">,</c:if>
        </c:if>
      </c:forEach>
    ];
    
    if (calList.length) {
      kakao.maps.load(() => {
        const map = new kakao.maps.Map(document.getElementById('map'), {
          center: new kakao.maps.LatLng(calList[0].lat, calList[0].lon),
          level: 6
        });
        
        // 마커 생성
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
        
        // Day별로 그룹화하여 연결선 그리기
        const dayGroups = {};
        calList.forEach(loc => {
          if (!dayGroups[loc.dayNo]) {
            dayGroups[loc.dayNo] = [];
          }
          dayGroups[loc.dayNo].push(loc);
        });
        
        // 각 Day별로 시간순 정렬 후 연결선 그리기
        const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7', '#DDA0DD', '#98D8C8'];
        let colorIndex = 0;
        
        Object.keys(dayGroups).forEach(dayNo => {
          const dayLocations = dayGroups[dayNo];
          
          // 시간순으로 정렬
          dayLocations.sort((a, b) => {
            return a.startTime.localeCompare(b.startTime);
          });
          
          // 연결선 그리기
          if (dayLocations.length > 1) {
            const linePath = dayLocations.map(loc => 
              new kakao.maps.LatLng(loc.lat, loc.lon)
            );
            
            const polyline = new kakao.maps.Polyline({
              path: linePath,
              strokeWeight: 3,
              strokeColor: colors[colorIndex % colors.length],
              strokeOpacity: 0.7,
              strokeStyle: 'solid'
            });
            
            polyline.setMap(map);
            colorIndex++;
          }
        });
        
        // 전체 일정을 포함하도록 지도 범위 조정
        if (calList.length > 1) {
          const bounds = new kakao.maps.LatLngBounds();
          calList.forEach(loc => {
            bounds.extend(new kakao.maps.LatLng(loc.lat, loc.lon));
          });
          map.setBounds(bounds);
        }
      });
    }
  </script>
</body>
</html>