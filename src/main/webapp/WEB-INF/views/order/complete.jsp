<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
    <title>결제 완료</title>
    <style>
        .container {
            width: 80%;
            margin: 40px auto;
            font-family: sans-serif;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .info {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .info span {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            text-decoration: none;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
<div class="container">
    <h2>결제가 완료되었습니다 🎉</h2>

    <div class="info">
        <span>주문번호:</span> ${order.orderId}
    </div>
    <div class="info">
        <span>원금액:</span> <fmt:formatNumber value="${originAmount}" pattern="#,###"/>원
    </div>
    <div class="info">
        <span>사용한 쿠폰:</span> ${coupon.couponName}
    </div>
    <div class="info">
        <span>할인금액:</span> <fmt:formatNumber value="${discountAmount}" pattern="#,###"/>원
    </div>
    <div class="info">
        <span>결제금액:</span> <fmt:formatNumber value="${order.orderTotalAmount}" pattern="#,###"/>원
    </div>
    <div class="info">
        <span>체크인 날짜:</span> ${detail.orderDetailsCheckinDate}
    </div>
    <div class="info">
        <span>체크아웃 날짜:</span> ${detail.orderDetailsCheckoutDate}
    </div>
    <div class="info">
        <span>결제수단:</span> ${detail.orderDetailsPaymentMethod}
    </div>

    <div class="info">
        <span>인원 수:</span> ${detail.orderDetailsPeopleCount}명
    </div>

    <a href="/mypage/orderlist" class="btn">주문 내역 확인</a>
</div>
</body>
</html>
