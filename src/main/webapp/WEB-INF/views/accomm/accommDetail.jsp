<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${accommodation.accomName} - 상세정보</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

    <style>
        .container { width: 80%; margin: 30px auto; font-family: sans-serif; }
        .accomm-header { display: flex; gap: 30px; margin-bottom: 20px; }
        .accomm-header img { width: 400px; border-radius: 10px; }
        .accomm-info { flex: 1; }
        .date-selector { margin: 20px 0; font-size: 16px; }
        .room-list { margin-top: 40px; }
        .room-card {
            display: flex; justify-content: space-between; align-items: flex-start;
            border: 1px solid #ccc; padding: 20px; margin-bottom: 20px;
            border-radius: 10px; background-color: #f9f9f9;
        }
        .room-info { flex: 1; padding-right: 20px; }
        .room-image img { width: 200px; border-radius: 8px; object-fit: cover; }
        .room-features { margin-top: 10px; }
        .room-features span { margin-right: 10px; font-size: 14px; }
        .price-result { margin-top: 10px; color: #2c3e50; font-weight: bold; }
    </style>
</head>
<body>
<div class="container">

    <!-- 숙소 정보 -->
    <div class="accomm-header">
        <img src="${accommodation.firstImage}" alt="${accommodation.accomName}" />

        <div class="accomm-info">
            <h1>${accommodation.accomName}</h1>
            <p>${accommodation.accomDes}</p>
        </div>
    </div>

    <!-- ✅ 날짜 선택 -->
    <div class="date-selector">
        <label for="dateRange">🗓️ 숙박 날짜 선택:</label>
        <input type="text" id="dateRange" placeholder="체크인 ~ 체크아웃" style="padding: 8px; width: 250px;" />
    </div>

    <!-- 객실 목록 -->
    <div class="room-list">
        <h2>객실 정보</h2>
        <c:forEach var="room" items="${roomList}">
            <div class="room-card">
                <div class="room-info">
                    <h3>${room.roomName}</h3>
                    <p>기준 인원: ${room.standardPerson}명 / 객실 수: ${room.roomCount}개 / 크기: ${room.roomScale}㎡</p>
                    <p>체크인: ${room.checkIn} / 체크아웃: ${room.checkOut}</p>
                    <p>
                       <p class="price-result" id="priceResult-${room.accommRoomId}"></p>
                    </p>
					<!-- ✅ 예약 버튼 -->
					<button class="reserve-btn" 
					        data-room-id="${room.accommRoomId}"
					        style="margin-top: 10px; padding: 8px 16px; background-color: #2c3e50; color: white; border: none; border-radius: 5px; cursor: pointer;">
					    예약하기
					</button>
                    <div class="room-features">
                        <c:if test="${room.bathroom == 'Y'}"><span>🛁 욕실</span></c:if>
                        <c:if test="${room.bath == 'Y'}"><span>🛀 욕조</span></c:if>
                        <c:if test="${room.tv == 'Y'}"><span>📺 TV</span></c:if>
                        <c:if test="${room.pc == 'Y'}"><span>💻 PC</span></c:if>
                        <c:if test="${room.internet == 'Y'}"><span>🌐 인터넷</span></c:if>
                        <c:if test="${room.refrigerator == 'Y'}"><span>🧊 냉장고</span></c:if>
                        <c:if test="${room.sofa == 'Y'}"><span>🛋️ 소파</span></c:if>
                        <c:if test="${room.table == 'Y'}"><span>🪑 테이블</span></c:if>
                        <c:if test="${room.dryer == 'Y'}"><span>💨 드라이기</span></c:if>
                    </div>
                </div>

                <div class="room-image">
                    <img src="${empty room.roomImage ? '/resources/images/default-room.jpg' : room.roomImage}" alt="${room.roomName} 이미지" />
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- ✅ 스크립트: 가격 계산 함수 및 초기 실행 -->
<script>
function fetchRoomPrices(checkInDate, checkOutDate) {
    const checkIn = checkInDate.toISOString().split("T")[0];
    const checkOut = checkOutDate.toISOString().split("T")[0];

    document.querySelectorAll(".price-result").forEach(el => el.innerText = "계산 중...");

    const roomIds = [
        <c:forEach var="room" items="${roomList}" varStatus="status">
            "${room.accommRoomId}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    roomIds.forEach(roomId => {
        fetch("/accommDetail/calculatePrice", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ roomId, checkIn, checkOut })
        })
        .then(res => res.json())
        .then(data => {
            const target = document.getElementById("priceResult-" + roomId);
            if (data && typeof data.days !== 'undefined' && typeof data.totalPrice !== 'undefined') {
                target.innerText = "총 " + data.days + "박 / 총액: ₩" + data.totalPrice.toLocaleString();
            } else {
                target.innerText = "총액 계산 실패 (데이터 없음)";
            }
        })
        .catch(() => {
            const target = document.getElementById("priceResult-" + roomId);
            target.innerText = "가격 계산 실패";
        });
    });
}

// ✅ flatpickr 초기화 및 초기 자동 호출
const today = new Date();
const tomorrow = new Date();
tomorrow.setDate(today.getDate() + 1);
const imgSrc = "${accommodation.firstImage}";
console.log("이미지 URL:", imgSrc);
flatpickr("#dateRange", {
    mode: "range",
    dateFormat: "Y-m-d",
    defaultDate: [today, tomorrow],
    onClose: function(selectedDates) {
        if (selectedDates.length === 2) {
            fetchRoomPrices(selectedDates[0], selectedDates[1]);
        }
    }
});

document.querySelectorAll(".reserve-btn").forEach(button => {
    button.addEventListener("click", () => {
        const roomId = button.dataset.roomId;
        const dateRange = document.getElementById("dateRange")._flatpickr.selectedDates;

        if (dateRange.length !== 2) {
            alert("날짜를 선택해주세요.");
            return;
        }

        const checkIn = dateRange[0].toISOString().split("T")[0];
        const checkOut = dateRange[1].toISOString().split("T")[0];

        // POST 방식으로 서버에 데이터 전송
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "/accomm/reservation";  // 예약 확인 or 결제 페이지

        const input1 = document.createElement("input");
        input1.name = "roomId";
        input1.value = roomId;

        const input2 = document.createElement("input");
        input2.name = "checkIn";
        input2.value = checkIn;

        const input3 = document.createElement("input");
        input3.name = "checkOut";
        input3.value = checkOut;

        form.appendChild(input1);
        form.appendChild(input2);
        form.appendChild(input3);

        document.body.appendChild(form);
        form.submit();
    });
});


// ✅ 최초 자동 계산
fetchRoomPrices(today, tomorrow);
</script>

</body>
</html>
