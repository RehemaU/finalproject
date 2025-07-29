<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<%@ include file="/WEB-INF/views/include/head.jsp" %> <%-- 공통 head --%>
<%@ include file="/WEB-INF/views/include/navigation_editor.jsp" %> <%-- 공통 GNB --%>
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
    
<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f5f5;
    padding: 40px;
  }

  .review-wrapper {
    max-width: 1450px;
    margin: 50px auto;
    font-family: 'Noto Sans KR', sans-serif;
  }

  .review-box {
    background-color: #fff;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  }

  .single-review {
    padding: 15px 0;
  }

  .review-stars {
    margin-bottom: 5px;
    text-align: left;
  }

  .review-stars .star,
  .star {
    font-size: 1.2rem;
    color: #ccc;
  }

  .review-stars .filled,
  .star.filled {
    color: gold;
  }

  .review-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    margin-bottom: 10px;
  }

  .review-content {
    font-size: 15px;
    line-height: 1.6;
    color: #333;
    white-space: pre-line;
  }

  .review-divider {
    border: none;
    border-top: 1px solid #eee;
    margin: 10px 0;
  }

  .no-review {
    text-align: center;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
    color: #666;
  }
</style>

    
</head>
<body>
<br/><br/><br/><br/>
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


<div class="review-wrapper">
  <h2>숙소 후기</h2>

  <c:choose>
    <c:when test="${not empty review}">
      <div class="review-box">
        <c:forEach var="r" items="${review}" varStatus="status">
          <div class="single-review">
            
            <!-- ★ 별점 먼저 출력 -->
            <div class="review-stars">
              <c:forEach begin="1" end="5" var="i">
                <c:choose>
                  <c:when test="${i <= r.accommReviewRating}">
                    <span class="star filled">★</span>
                  </c:when>
                  <c:otherwise>
                    <span class="star">☆</span>
                  </c:otherwise>
                </c:choose>
              </c:forEach>
            </div>

            <!-- 작성자 -->
            <div class="review-header">
              <span><b>작성자:</b> ${r.userId}</span>
            </div>
<br/>
            <!-- 내용 -->
            <div class="review-content">${r.accommReviewContent}</div>
          </div>
<br/>
          <!-- 마지막 리뷰가 아닐 때만 구분선 -->
          <c:if test="${!status.last}">
            <hr class="review-divider"/>
          </c:if>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <p class="no-review">등록된 후기가 없습니다.</p>
    </c:otherwise>
  </c:choose>
</div>




<script>
function formatDateLocal(date) {
    var yyyy = date.getFullYear();
    var mm = date.getMonth() + 1;
    var dd = date.getDate();

    if (mm < 10) mm = "0" + mm;
    if (dd < 10) dd = "0" + dd;

    return yyyy + "-" + mm + "-" + dd;
}

var accommId = '<c:out value="${accommodation.accomId}" />';
var roomIds = [
    <c:forEach var="room" items="${roomList}" varStatus="status">
        '${room.accommRoomId}'<c:if test="${!status.last}">,</c:if>
    </c:forEach>
];

var today = new Date();
var tomorrow = new Date();
tomorrow.setDate(today.getDate() + 1);

flatpickr("#dateRange", {
    mode: "range",
    dateFormat: "Y-m-d",
    defaultDate: [today, tomorrow],
    minDate: today,
    onClose: function(selectedDates) {
        if (selectedDates.length === 2) {
            var checkIn = formatDateLocal(selectedDates[0]);
            var checkOut = formatDateLocal(selectedDates[1]);
            fetchRoomPrices(checkIn, checkOut);
            fetchAvailableRooms(checkIn, checkOut);
        }
    }
});

// 초기 실행
fetchRoomPrices(formatDateLocal(today), formatDateLocal(tomorrow));
fetchAvailableRooms(formatDateLocal(today), formatDateLocal(tomorrow));

function fetchAvailableRooms(checkIn, checkOut) {
    fetch("/accommDetail/availableRooms", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ accommId: accommId, checkIn: checkIn, checkOut: checkOut })
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        var availableIds = {};
        data.forEach(function(room) {
            availableIds[room.accommRoomId] = true;
        });
        document.querySelectorAll(".room-card").forEach(function(card) {
            var roomId = card.querySelector(".reserve-btn").dataset.roomId;
            card.style.display = availableIds[roomId] ? "flex" : "none";
        });
    });
}

function fetchRoomPrices(checkIn, checkOut) {
    roomIds.forEach(function(roomId) {
        fetch("/accommDetail/calculatePrice", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ roomId: roomId, checkIn: checkIn, checkOut: checkOut })
        })
        .then(function(res) {
            return res.json();
        })
        .then(function(data) {
            console.log(`[${roomId}] 가격 응답:`, data);  // 추가
            var target = document.getElementById("priceResult-" + roomId);
            if (data && typeof data.days !== "undefined" && typeof data.totalPrice !== "undefined") {
                target.innerText = "총 " + data.days + "박 / 총액: ₩" + Number(data.totalPrice).toLocaleString();
            } else {
                target.innerText = "총액 계산 실패 (데이터 없음)";
            }
        })
        .catch(function(err) {
            console.error(`[${roomId}] 가격 오류:`, err);  // 추가
            var target = document.getElementById("priceResult-" + roomId);
            target.innerText = "가격 계산 실패";
        });
    });
}

document.querySelectorAll(".reserve-btn").forEach(function(button) {
    button.addEventListener("click", function() {
        var roomId = button.dataset.roomId;
        var selectedDates = document.getElementById("dateRange")._flatpickr.selectedDates;
        if (selectedDates.length !== 2) {
            alert("날짜를 선택해주세요.");
            return;
        }

        var checkIn = formatDateLocal(selectedDates[0]);
        var checkOut = formatDateLocal(selectedDates[1]);

        var form = document.createElement("form");
        form.method = "POST";
        form.action = "/accomm/reservation";

        var input1 = document.createElement("input");
        input1.type = "hidden";
        input1.name = "roomId";
        input1.value = roomId;

        var input2 = document.createElement("input");
        input2.type = "hidden";
        input2.name = "checkIn";
        input2.value = checkIn;

        var input3 = document.createElement("input");
        input3.type = "hidden";
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
