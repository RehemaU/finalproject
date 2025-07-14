<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<!-- Noto Sans 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
  }
  .card-title {
    font-weight: bold;
    font-size: 1.2rem;
  }
  .room-features span {
    display: inline-block;
    margin-right: 12px;
    font-size: 14px;
  }
</style>
<style>
  .custom-btn {
    padding: 10px 22px;
    border: none;
    border-radius: 30px;
    font-weight: 600;
    font-size: 16px;
    color: #fff;
    background-color: #6c757d; /* 기본 회색 */
    transition: all 0.3s ease;
    box-shadow: 2px 4px 10px rgba(0, 0, 0, 0.1);
  }

  .custom-btn:hover {
    background-color: #5a6268; /* 조금 어두운 회색 */
    transform: translateY(-1.5px);
    box-shadow: 4px 6px 14px rgba(0, 0, 0, 0.15);
  }

  .custom-btn:disabled {
    background-color: #adb5bd;
    cursor: not-allowed;
    box-shadow: none;
  }
</style>

<body style="font-family: 'Noto Sans KR', sans-serif;">
  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div style="max-width: 800px; margin: 0 auto; padding: 40px 24px;">

  <!-- 숙소 정보 카드 -->
  <div class="card mb-4">
    <div class="row g-0">
      <div class="col-md-5 d-flex justify-content-center align-items-center">
        <img src="${orderDetail.accomm.firstImage}" class="img-fluid rounded-start" alt="숙소 이미지" style="height:100%; object-fit:cover; border-right: 2px solid #ccc; margin: 25px auto 0 auto;">
      </div>
      <div class="col-md-7">
        <div class="card-body">
          <h5 class="card-title">${orderDetail.accomm.accomName}</h5>
          <p class="card-text"><strong>판매자:</strong> ${orderDetail.accomm.sellerId}</p>
          <p class="card-text"><strong>전화번호:</strong> ${orderDetail.accomm.accomTel}</p>
          <p class="card-text"><strong>주소:</strong> ${orderDetail.accomm.accomAdd}</p>
        </div>
      </div>
    </div>
  </div>

  <!-- 객실 정보 카드 -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">${orderDetail.accommRoom.roomName}</h5>
      <p class="card-text"><strong>평균가:</strong> ${orderDetail.accommRoom.standardPrice}원</p>
      <p class="card-text"><strong>기준 인원:</strong> ${orderDetail.accommRoom.standardPerson}명</p>

      <p class="card-text"><strong>객실 옵션:</strong></p>
      <div class="room-features mb-3">
        <c:if test="${orderDetail.accommRoom.bathroom == 'Y'}"><span>🛁 욕실</span></c:if>
        <c:if test="${orderDetail.accommRoom.bath == 'Y'}"><span>🛀 욕조</span></c:if>
        <c:if test="${orderDetail.accommRoom.tv == 'Y'}"><span>📺 TV</span></c:if>
        <c:if test="${orderDetail.accommRoom.pc == 'Y'}"><span>💻 PC</span></c:if>
        <c:if test="${orderDetail.accommRoom.internet == 'Y'}"><span>🌐 인터넷</span></c:if>
        <c:if test="${orderDetail.accommRoom.refrigerator == 'Y'}"><span>🧊 냉장고</span></c:if>
        <c:if test="${orderDetail.accommRoom.sofa == 'Y'}"><span>🛋️ 소파</span></c:if>
        <c:if test="${orderDetail.accommRoom.table == 'Y'}"><span>🪑 테이블</span></c:if>
        <c:if test="${orderDetail.accommRoom.dryer == 'Y'}"><span>💨 드라이기</span></c:if>
      </div>

      <p class="card-text"><strong>체크인 시각:</strong> ${orderDetail.accommRoom.checkIn}</p>
      <p class="card-text"><strong>체크아웃 시각:</strong> ${orderDetail.accommRoom.checkOut}</p>
    </div>
  </div>

  <!-- 예약 정보 카드 -->
  <div class="card mb-4">
    <div class="card-body">
      <h5 class="card-title">예약 정보</h5>
      <p class="card-text"><strong>결제 수단:</strong> ${orderDetail.orderDetailsPaymentMethod}</p>
      <p class="card-text"><strong>체크인 날짜:</strong> ${checkinDate}</p>
      <p class="card-text"><strong>체크아웃 날짜:</strong> ${checkoutDate}</p>
    </div>
  </div>
<!-- 버튼 영역 -->
<div class="mb-5">

<div class="card mb-4">
  <div class="card-body text-center">
    
    <div style="display: flex; justify-content: center; gap: 12px;">
      <c:if test="${isRefund}">
        <button type="button" class="custom-btn" onclick="openRefund('${orderDetail.orderId}')">환불 신청</button>
      </c:if>
      <c:if test="${isReview}">
        <button type="button" class="custom-btn" onclick="openReviewPopup('${orderDetail.accomm.accomId}')">리뷰 작성</button>
      </c:if>
      <a href="/mypage/orderlist" class="custom-btn"
         style="text-decoration: none; color: white; background-color: black;">
        목록으로
      </a>
    </div>

<!-- 환불 -->
<script>
  function openRefund(orderId) {
    // 폼 생성
    const form = document.createElement("form");
    form.method = "POST";
    form.action = "/order/kakao/cancel/refund";

    // 숨겨진 input 생성
    const input = document.createElement("input");
    input.type = "hidden";
    input.name = "orderId";  // 서버에서 받을 파라미터 이름
    input.value = orderId;

    form.appendChild(input);
    document.body.appendChild(form);  // 폼을 body에 붙여야 submit 가능
    form.submit();
  }
</script>

<!-- 리뷰 -->
<script>
const loginUserId = "<%= session.getAttribute("userId") != null ? session.getAttribute("userId") : "" %>";

function openReviewPopup(accommId) {
	if (!loginUserId || loginUserId === "") 
	{
	   alert("로그인이 필요합니다.");
	   return;
	}
	const url = '/mypage/reviewPopup?accommId=' + accommId;
	window.open(url, 'reviewPopup', 'width=500,height=500');
}
</script>

  </div>
</div>
</div>
</div>
</body>
