<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>이벤트 상세</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .event-detail-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            position: relative;
        }
        .event-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .event-date {
            color: #777;
            margin-bottom: 30px;
        }
        .event-image {
            width: 100%;
            height: auto;
            object-fit: contain; /* ✅ 이미지 전체 보여주기 */
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .event-content {
            font-size: 16px;
            line-height: 1.6;
            white-space: pre-line;
        }
        .coupon-button {
            display: inline-block;
            background-color: #ff6f00;
            color: white;
            font-size: 16px;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
        }
        .coupon-button:hover {
            background-color: #e65c00;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="event-detail-container">
            <div class="event-title">${event.eventTitle}</div>
            <div class="event-date">
                등록일: ${event.eventRegdate} &nbsp; | &nbsp; 종료일: ${event.eventEnddate}
            </div>

            <img src="${event.eventImageUrl}" class="event-image" alt="이벤트 본문 이미지" />

            <!-- ✅ 쿠폰 ID가 있을 때만 버튼 표시 -->
            <c:if test="${not empty event.couponId}">
                <div style="text-align: center;">
                    <button class="coupon-button" onclick="issueCoupon('${event.eventId}')">🎁 쿠폰 발급받기</button>
                </div>
            </c:if>

            <div class="event-content">
                ${event.eventContent}
            </div>
        </div>
    </div>

    <script>
        function issueCoupon(eventId) {
            $.ajax({
                type: "POST",
                url: "/event/issueCoupon",
                data: { eventId: eventId },
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("AJAX", "true");
                },
                success: function(res) {
                    if (res.code === 0) {
                        alert("✅ " + res.msg);
                        if (res.data && res.data.redirectUrl) {
                            window.location.href = res.data.redirectUrl;
                        } else {
                            location.reload();
                        }
                    } else {
                        alert("⚠️ " + res.msg);
                    }
                },
                error: function(xhr) {
                    alert("❌ 서버 오류 발생: " + xhr.status);
                }
            });
        }
    </script>
</body>
</html>
