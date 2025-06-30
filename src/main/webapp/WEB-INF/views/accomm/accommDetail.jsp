<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>${accommodation.accomName} - 상세정보</title>
    <style>
        .container {
            width: 80%;
            margin: 30px auto;
            font-family: sans-serif;
        }

        .accomm-header {
            display: flex;
            gap: 30px;
            margin-bottom: 40px;
        }

        .accomm-header img {
            width: 400px;
            height: auto;
            border-radius: 10px;
        }

        .accomm-info {
            flex: 1;
        }

        .room-list {
            margin-top: 40px;
        }

        .room-card {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border: 1px solid #ccc;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        .room-info {
            flex: 1;
            padding-right: 20px;
        }

        .room-image img {
            width: 200px;
            height: auto;
            border-radius: 8px;
            object-fit: cover;
        }

        .room-card h3 {
            margin-top: 0;
            margin-bottom: 10px;
        }

        .room-features {
            margin-top: 10px;
        }

        .room-features span {
            margin-right: 10px;
            font-size: 14px;
        }
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

    <!-- 객실 목록 -->
    <div class="room-list">
        <h2>객실 정보</h2>
        <c:forEach var="room" items="${roomList}">
            <div class="room-card">
                <!-- 좌측: 객실 정보 -->
                <div class="room-info">
                    <h3>${room.roomName}</h3>
                    <p>
                        기준 인원: ${room.standardPerson}명 /
                        객실 수: ${room.roomCount}개 /
                        크기: ${room.roomScale}㎡
                    </p>
                    <p>
                        체크인: ${room.checkIn} /
                        체크아웃: ${room.checkOut}
                    </p>
                    <p>
                        가격:
                        <strong>
                            <fmt:formatNumber value="${room.standardPrice}" type="currency" currencySymbol="₩" />
                        </strong>
                    </p>

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

                <!-- 우측: 객실 이미지 -->
                <div class="room-image">
                    <img src="${empty room.roomImage ? '/resources/images/default-room.jpg' : room.roomImage}" alt="${room.roomName} 이미지" />
                </div>
            </div>
        </c:forEach>
    </div>
	
</div>
</body>
</html>
