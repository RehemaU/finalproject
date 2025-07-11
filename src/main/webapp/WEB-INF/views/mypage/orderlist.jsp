<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %> <%-- Bootstrap 포함되어 있다고 가정 --%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>결제 내역</title>
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Noto Sans KR', sans-serif;
    }
    .order-card {
      background-color: #fff;
      border: 1px solid #dee2e6;
      border-radius: 15px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
      transition: all 0.2s ease-in-out;
    }
    .order-card:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    .order-header {
      font-weight: 600;
      font-size: 1.1rem;
      color: #343a40;
    }
    .order-meta {
      font-size: 0.9rem;
      color: #6c757d;
    }
    .order-value {
      font-size: 1.1rem;
      color: #000;
      font-weight: bold;
    }
    .badge-status {
      font-size: 0.8rem;
      padding: 0.4em 0.6em;
      border-radius: 0.5rem;
    }
  </style>
</head>
<body>

<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 헤더/네비게이션 --%>

<div class="d-flex justify-content-center mt-5 mb-5">
  <div style="max-width: 900px; margin: 0 auto; padding: 20px;">
    <h3 class="mb-4"><i class="fas fa-receipt me-2"></i>내 결제 내역</h3>
<br/>
    <c:forEach var="order" items="${list}">
    <a href="/mypage/orderdetail?orderId=${order.orderId}" style="text-decoration:none; color:inherit;">
      <div class="order-card">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <div class="order-header">주문번호: ${order.orderId}</div>
            <div class="order-meta">
              주문일시: <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
            </div>
          </div>
          <div>
            <span class="badge bg-secondary badge-status">${order.orderStatus}</span>
          </div>
        </div>

        <hr>

        <div class="d-flex justify-content-between">
          <div>
            <div class="order-meta">쿠폰 ID: ${order.orderCouponId}</div>
            <div class="order-meta">사용 포인트: <fmt:formatNumber value="${order.orderExpendPoint}" type="number" />P</div>
          </div>
          <div class="text-end">
            <div class="order-meta">총 결제 금액</div>
            <div class="order-value">
              <fmt:formatNumber value="${order.orderTotalAmount}" type="currency" currencySymbol="₩"/>
            </div>
          </div>
        </div>

        <c:if test="${not empty order.orderTid}">
          <div class="mt-2 order-meta">거래번호(TID): ${order.orderTid}</div>
        </c:if>
      </div>
    </a>
    </c:forEach>

    <c:if test="${empty list}">
      <div class="text-center mt-5 text-muted">결제 내역이 없습니다.</div>
    </c:if>
  </div>
</div>

</body>
</html>
