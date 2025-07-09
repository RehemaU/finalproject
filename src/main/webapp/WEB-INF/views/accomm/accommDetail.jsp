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
    <div class="accomm-header">
        <img src="${accommodation.firstImage}" alt="${accommodation.accomName}" />
        <div class="accomm-info">
            <h1>${accommodation.accomName}</h1>
            <p>${accommodation.accomDes}</p>
        </div>
    </div>

    <div class="date-selector">
        <label for="dateRange">🗓️ 숙박 날짜 선택:</label>
        <input type="text" id="dateRange" placeholder="체크인 ~ 체크아웃" style="padding: 8px; width: 250px;" />
    </div>

    <div class="room-list">
        <h2>객실 정보</h2>
        <c:forEach var="room" items="${roomList}">
            <div class="room-card">
                <div class="room-info">
                    <h3>${room.roomName}</h3>
                    <p>기준 인원: ${room.standardPerson}명 / 객실 수: ${room.roomCount}개 / 크기: ${room.roomScale}㎡</p>
                    <p>체크인: ${room.checkIn} / 체크아웃: ${room.checkOut}</p>
                    <p class="price-result" id="priceResult-${room.accommRoomId}"></p>

                    <button class="reserve-btn" data-room-id="${room.accommRoomId}" style="margin-top: 10px; padding: 8px 16px; background-color: #2c3e50; color: white; border: none; border-radius: 5px; cursor: pointer;">
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

<script>

const accommId = '<c:out value="${accommodation.accomId}" />';
const roomIds = [
    <c:forEach var="room" items="${roomList}" varStatus="status">
        '<c:out value="${room.accommRoomId}" />'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];
const today = new Date();
const tomorrow = new Date();
tomorrow.setDate(today.getDate() + 1);

flatpickr("#dateRange", {
    mode: "range",
    dateFormat: "Y-m-d",
    defaultDate: [today, tomorrow], // ✅ 기본 선택: 오늘 ~ 내일
    minDate: today,                 // ✅ 오늘 이전은 선택 불가
    onClose: function(selectedDates) {
        if (selectedDates.length === 2) {
            const checkIn = selectedDates[0].toISOString().split("T")[0];
            const checkOut = selectedDates[1].toISOString().split("T")[0];
            fetchRoomPrices(checkIn, checkOut);
            fetchAvailableRooms(checkIn, checkOut);
        }
    }
});

// ✅ 최초 자동 호출
fetchRoomPrices(today.toISOString().split("T")[0], tomorrow.toISOString().split("T")[0]);
fetchAvailableRooms(today.toISOString().split("T")[0], tomorrow.toISOString().split("T")[0]);

function fetchAvailableRooms(checkIn, checkOut) {
    fetch("/accommDetail/availableRooms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            accommId: "${accommodation.accomId}",
            checkIn,
            checkOut
        })
    })
    .then(res => res.json())
    .then(data => {
        const availableIds = new Set(data.map(room => room.accommRoomId));
        document.querySelectorAll(".room-card").forEach(card => {
            const roomId = card.querySelector(".reserve-btn").dataset.roomId;
            card.style.display = availableIds.has(roomId) ? "flex" : "none";
        });
    });
}

function fetchRoomPrices(checkInDate, checkOutDate) {
    console.log("🧾 [fetchRoomPrices] 호출됨");

    const checkIn = checkInDate;
    const checkOut = checkOutDate;

    console.log("👉 checkIn:", checkIn);
    console.log("👉 checkOut:", checkOut);

    roomIds.forEach(roomId => {
        const payload = {
            roomId,
            checkIn,
            checkOut
        };

        console.log("📤 [요청] roomId:", roomId, "| payload:", payload);

        fetch("/accommDetail/calculatePrice", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(payload)
        })
        .then(res => res.json())
        .then(data => {
            const target = document.getElementById("priceResult-" + roomId);
            console.log("📥 [응답] roomId:", roomId, "| data:", data);

            if (data && typeof data.days !== 'undefined' && typeof data.totalPrice !== 'undefined') {
                const resultStr = "총 " + data.days + "박 / 총액: ₩" + Number(data.totalPrice).toLocaleString();
                target.innerText = resultStr;
                console.log("✅ [DOM 반영 성공]", resultStr);
            } else {
                target.innerText = "총액 계산 실패 (데이터 없음)";
                console.warn("⚠️ [DOM 반영 실패] data 불완전");
            }
        })
        .catch(err => {
            const target = document.getElementById("priceResult-" + roomId);
            target.innerText = "가격 계산 실패";
            console.error("❌ [요청 실패]", err);
        });
    });
}

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

        const form = document.createElement("form");
        form.method = "POST";
        form.action = "/accomm/reservation";

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
</script>
</body>
</html>
