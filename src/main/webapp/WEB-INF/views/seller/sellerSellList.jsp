<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>판매자 정산 내역</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/sellerHead.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/views/include/sellerNavigation.jsp" %>
<div class="container mt-5">

<h2 class="mb-4">📦 판매자 정산 내역</h2>
<h4 class="mb-4 text-secondary" style="font-weight: 500;">
  💰 총 정산 금액: <span class="text-dark"><fmt:formatNumber value="${sum}" type="number" pattern="#,###"/> 원</span>
</h4>

  <c:choose>
    <c:when test="${empty list}">
      <div class="alert alert-info">판매 내역이 없습니다.</div>
    </c:when>
    <c:otherwise>
      <table class="table table-bordered align-middle text-center">
        <thead class="table-light">
          <tr>
            <th>숙소 이름</th>
            <th>숙소 주소</th>
            <th>객실 이름</th>
            <th>체크인</th>
            <th>체크아웃</th>
            <th>결제 수단</th>
            <th>판매 금액</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="item" items="${list}">
            <tr>
              <!-- 숙소 정보 -->
              <td>${item.accomm.accomName}</td>
              <td>${item.accomm.accomAdd}</td>

              <!-- 객실 정보 -->
              <td>${item.accommRoom.roomName}</td>

              <!-- 체크인/아웃 -->
              <td><fmt:formatDate value="${item.orderDetailsCheckinDate}" pattern="yyyy-MM-dd"/></td>
              <td><fmt:formatDate value="${item.orderDetailsCheckoutDate}" pattern="yyyy-MM-dd"/></td>

              <!-- 결제 수단 -->
              <td>
                <c:choose>
                  <c:when test="${item.orderDetailsPaymentMethod == 'card'}">카드</c:when>
                  <c:when test="${item.orderDetailsPaymentMethod == 'kakao'}">카카오페이</c:when>
                  <c:otherwise>${item.orderDetailsPaymentMethod}</c:otherwise>
                </c:choose>
              </td>

              <!-- 금액 -->
              <td><fmt:formatNumber value="${item.orderDetailsRoomEachPrice}" type="number" pattern="#,###" /> 원</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</div>
</body>
</html>
