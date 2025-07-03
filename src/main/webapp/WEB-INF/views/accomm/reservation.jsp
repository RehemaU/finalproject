<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>숙소 예약</title>
    <style>
        .container { width: 80%; margin: 0 auto; font-family: sans-serif; }
        .section { border-bottom: 1px solid #ccc; padding: 20px 0; }
        .price-box { background-color: #f9f9f9; padding: 15px; border-radius: 10px; }
        .right { text-align: right; }
        .btn-pay {
            background-color: #FEE500; color: #000;
            padding: 15px; text-align: center;
            font-size: 18px; font-weight: bold;
            cursor: pointer; border: none; border-radius: 10px;
            width: 100%;
        }
        .room-img {
            width: 100%;
            max-height: 200px;
            object-fit: cover;
            border-radius: 10px;
        }
    </style>
</head>
<body>
<div class="container">

    <!-- 숙소 이미지 -->
    <div class="section">
        <img src="${empty room.roomImage ? '/resources/images/default-room.jpg' : room.roomImage}" alt="${room.roomName} 이미지" class="room-img"/>
    </div>

    <!-- 숙소 정보 -->
    <div class="section">
        <h2>${room.roomName}</h2>
        <p>입실: ${room.checkIn} / 퇴실: ${room.checkOut}</p>
        <p><strong>${days}</strong>박</p>
        <p>기준 인원: ${room.standardPerson}명 / 총 객실 수: ${room.roomCount}</p>
    </div>

    <!-- 가격 정보 -->
    <div class="section price-box">
        <p>정가: <fmt:formatNumber value="${totalPrice}" type="number" />원</p>
        <p id="discountInfo" style="display:none;">할인 금액: <span id="discountAmount">0</span>원</p>
        <p>최종 결제 금액: <strong id="finalPrice"><fmt:formatNumber value="${totalPrice}" type="number" />원</strong></p>
    </div>

    <!-- 쿠폰 선택 -->
    <div class="section">
        <label for="coupon">사용 가능한 쿠폰:</label>
        <select id="coupon">
            <option value="">선택 안 함</option>
            <c:forEach var="coupon" items="${couponList}">
                <option value="${coupon.userCouponId}"
                    data-type="${coupon.couponType}"
                    data-amount="${coupon.couponAmount}"
                    data-max="${coupon.couponMaxAmount}">
                    ${coupon.userCouponName}
                </option>
            </c:forEach>
        </select>
    </div>

    <!-- 결제 버튼 -->
    <div class="section">
        <button class="btn-pay" onclick="payWithKakao()">카카오페이로 결제하기</button>
    </div>

</div>

<!-- 스크립트 -->
<script>
const originalTotalPrice = ${totalPrice};
let discountedPrice = originalTotalPrice;

document.getElementById("coupon").addEventListener("change", function() {
    const selected = this.options[this.selectedIndex];
    const type = selected.getAttribute("data-type");
    const amount = parseInt(selected.getAttribute("data-amount"));
    const maxAmount = parseInt(selected.getAttribute("data-max"));

    let discount = 0;

    if (type === "P") {
        discount = Math.floor(originalTotalPrice * (amount / 100));
        if (!isNaN(maxAmount) && discount > maxAmount) {
            discount = maxAmount;
        }
    } else if (type === "A") {
        discount = amount;
    }

    if (this.value === "") {
        discount = 0;
        document.getElementById("discountInfo").style.display = "none";
    } else {
        document.getElementById("discountInfo").style.display = "block";
    }

    discountedPrice = Math.max(originalTotalPrice - discount, 0);

    document.getElementById("discountAmount").innerText = discount.toLocaleString();
    document.getElementById("finalPrice").innerText = discountedPrice.toLocaleString() + "원";
});

function payWithKakao() {
    const roomId = '${room.accommRoomId}';
    const checkIn = '${checkIn}';
    const checkOut = '${checkOut}';
    const userCouponId = document.getElementById('coupon').value;

    fetch('/order/kakao/start', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            roomId,
            checkIn,
            checkOut,
            userCouponId
        })
    })
    .then(res => res.json())
    .then(data => {
        if (data.nextRedirectPcUrl) {
            window.location.href = data.nextRedirectPcUrl;
        } else {
            alert('결제 요청 중 문제가 발생했습니다.');
        }
    })
    .catch(err => {
        console.error(err);
        alert('결제 요청 실패');
    });
}
</script>

</body>
</html>
