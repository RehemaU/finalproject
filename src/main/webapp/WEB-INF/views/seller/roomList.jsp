<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head.jsp" %>
  <title>객실 리스트</title>
  <style>
    .container { max-width: 1200px; margin: 40px auto; padding: 20px; }
    table {
      width: 100%; border-collapse: collapse; margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd; padding: 12px; text-align: center;
    }
    th {
      background-color: #f7f7f7;
    }
    img {
      width: 100px; height: auto; object-fit: cover; border-radius: 8px;
    }
    .btn {
      padding: 6px 12px; border: none; background: #000; color: #fff; border-radius: 4px;
      text-decoration: none;
    }
    h2 { margin-bottom: 20px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation2.jsp" %>

<div class="container">
  <h2>객실 목록</h2>

  <table>
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
        <th>옵션</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="room" items="${roomList}">
        <tr>
          <td>
            <c:if test="${not empty room.roomImage}">
              <img src="${room.roomImage}" alt="room image" />
            </c:if>
          </td>
          <td>${room.roomName}</td>
          <td>${room.roomScale}</td>
          <td>${room.roomCount}</td>
          <td>${room.standardPerson}</td>
          <td>${room.checkIn}</td>
          <td>${room.checkOut}</td>
          <td><fmt:formatNumber value="${room.standardPrice}" type="number" /></td>
          <td>
            <c:if test="${room.bathroom eq 'Y'}">욕실 </c:if>
            <c:if test="${room.bath eq 'Y'}">욕조 </c:if>
            <c:if test="${room.tv eq 'Y'}">TV </c:if>
            <c:if test="${room.pc eq 'Y'}">PC </c:if>
            <c:if test="${room.internet eq 'Y'}">인터넷 </c:if>
            <c:if test="${room.refrigerator eq 'Y'}">냉장고 </c:if>
            <c:if test="${room.sofa eq 'Y'}">소파 </c:if>
            <c:if test="${room.table eq 'Y'}">테이블 </c:if>
            <c:if test="${room.dryer eq 'Y'}">드라이기 </c:if>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <div style="margin-top:20px;">
    <a href="/seller/accommRoomRegForm?accommId=${param.accommId}" class="btn">+ 객실 추가</a>
  </div>
</div>
</body>
</html>
