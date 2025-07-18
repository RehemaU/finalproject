<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/sellerHead.jsp" %>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #fff;
    margin: 0;
    padding: 0;
  }
  main.wrap {
    max-width: 100%;
    padding: 40px 60px;
    box-sizing: border-box;
    background-color: #f9f9f9;
  }
  h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 24px;
  }
  table {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
    text-align: left;
    background-color: #fff;
    box-shadow: 0 2px 8px rgba(0,0,0,0.03);
    margin-bottom: 20px;
  }
  thead {
    background-color: #f4f4f4;
    border-top: 2px solid #000;
    border-bottom: 1px solid #ccc;
  }
  thead th {
    padding: 12px 16px;
  }
  tbody td {
    padding: 12px 16px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
  }
  .room-img {
    width: 100px;
    height: 70px;
    object-fit: cover;
    border-radius: 4px;
    background-color: #e0e0e0;
    background-image: url('/resources/images/no-image-bg.svg');
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
  }
  .small-text {
    font-size: 13px;
    color: #555;
  }
  .btn {
    display: inline-block;
    padding: 8px 16px;
    font-size: 13px;
    background-color: #000;
    color: #fff;
    border: none;
    border-radius: 6px;
    text-decoration: none;
    transition: background-color 0.2s ease;
  }
  .btn:hover {
    background-color: #333;
    color: #fff;
  }
  .btn-add {
    background-color: #111;
    margin-top: 20px;
  }
  .btn-add:hover {
    background-color: #495057;
  }
  .no-data {
    text-align: center;
    padding: 40px;
    color: #666;
  }
  .amenities {
    display: flex;
    flex-wrap: wrap;
    gap: 4px;
  }
  .amenity-tag {
    background-color: #e9ecef;
    padding: 2px 6px;
    border-radius: 3px;
    font-size: 11px;
    color: #495057;
  }
</style>

<main class="wrap">
  <h2>객실 관리</h2>

  <!-- 객실 목록이 있는 경우 -->
  <c:if test="${not empty roomList}">
    <table>
      <colgroup>
        <col style="width: 120px;">     <!-- 이미지 -->
        <col style="width: 150px;">     <!-- 객실명 -->
        <col style="width: 80px;">      <!-- 면적 -->
        <col style="width: 80px;">      <!-- 객실 수 -->
        <col style="width: 80px;">      <!-- 기준 인원 -->
        <col style="width: 100px;">     <!-- 체크인 -->
        <col style="width: 100px;">     <!-- 체크아웃 -->
        <col style="width: 120px;">     <!-- 기본요금 -->
        <col style="width: 160px;">     <!-- 편의시설 -->
        <col style="width: 80px;">      <!-- 삭제 버튼 -->
      </colgroup>
      <thead>
        <tr>
          <th>이미지</th>
          <th>객실명</th>
          <th>면적(㎡)</th>
          <th>객실 수</th>
          <th>기준 인원</th>
          <th>체크인</th>
          <th>체크아웃</th>
          <th>기본요금</th>
          <th>편의시설</th>
          <th>객실삭제</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="room" items="${roomList}">
          <tr>
            <td>
              <c:choose>
                <c:when test="${not empty room.roomImage}">
                  <img src="${room.roomImage}" class="room-img" />
                </c:when>
                <c:otherwise>
                  <img src="" class="room-img" />
                </c:otherwise>
              </c:choose>
            </td>
            <td>${room.roomName}</td>
            <td>${room.roomScale}</td>
            <td>${room.roomCount}</td>
            <td>${room.standardPerson}명</td>
            <td>${room.checkIn}</td>
            <td>${room.checkOut}</td>
            <td>
              <c:choose>
                <c:when test="${not empty room.standardPrice}">
                  <fmt:formatNumber value="${room.standardPrice}" type="number" />원
                </c:when>
                <c:otherwise>
                  미정
                </c:otherwise>
              </c:choose>
            </td>
            <td>
              <div class="amenities">
                <c:if test="${room.bathroom eq 'Y'}"><span class="amenity-tag">욕실</span></c:if>
                <c:if test="${room.bath eq 'Y'}"><span class="amenity-tag">욕조</span></c:if>
                <c:if test="${room.tv eq 'Y'}"><span class="amenity-tag">TV</span></c:if>
                <c:if test="${room.pc eq 'Y'}"><span class="amenity-tag">PC</span></c:if>
                <c:if test="${room.internet eq 'Y'}"><span class="amenity-tag">인터넷</span></c:if>
                <c:if test="${room.refrigerator eq 'Y'}"><span class="amenity-tag">냉장고</span></c:if>
                <c:if test="${room.sofa eq 'Y'}"><span class="amenity-tag">소파</span></c:if>
                <c:if test="${room.table eq 'Y'}"><span class="amenity-tag">테이블</span></c:if>
                <c:if test="${room.dryer eq 'Y'}"><span class="amenity-tag">드라이기</span></c:if>
              </div>
            </td>
            <td>
              <a href="/seller/roomDelete?roomId=${room.accommRoomId}&accommId=${accommId}"
                 class="btn"
                 onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

  <!-- 객실 목록이 없는 경우 -->
  <c:if test="${empty roomList}">
    <div class="no-data">
      <p>등록된 객실이 없습니다.</p>
      <p>첫 번째 객실을 등록해보세요!</p>
    </div>
  </c:if>

  <!-- 객실 추가 버튼 -->
  <div>
    <a href="/accomm/accommRoomRegForm?accommId=${accommId}" class="btn btn-add">+ 객실 추가</a>
  </div>

  <!-- 객실 금액 수정 버튼 -->
  <div>
    <a href="/seller/roomPriceUpdateForm?accommId=${accommId}" class="btn btn-add">+ 금액 수정</a>
  </div>
</main>
