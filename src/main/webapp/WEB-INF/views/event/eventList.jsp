<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>이벤트</title>
    <style>
        .section-title {
            font-size: 24px;
            margin-top: 40px;
            margin-bottom: 20px;
        }
        .event-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .event-box {
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
            text-decoration: none;
            color: inherit;
        }
        .event-box img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .event-info {
            padding: 10px;
        }
        .event-title {
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 5px;
        }
        .event-date {
            font-size: 14px;
            color: gray;
        }
    </style>
</head>
<body>
    <div class="wrap">

        <h2 class="section-title">진행 중인 이벤트</h2>
        <div class="event-list">
            <c:forEach var="event" items="${activeEvents}">
                <a href="/event/detail?eventId=${event.eventId}" class="event-box">
                    <img src="${event.eventThumbnailUrl}" alt="이벤트 이미지">
                    <div class="event-info">
                        <div class="event-title">${event.eventTitle}</div>
                        <div class="event-date">~ ${event.eventEnddate}</div>
                    </div>
                </a>
            </c:forEach>
        </div>

        <h2 class="section-title">종료된 이벤트</h2>
        <div class="event-list">
            <c:forEach var="event" items="${endedEvents}">
                <a href="/event/detail?eventId=${event.eventId}" class="event-box">
                    <img src="${event.eventThumbnailUrl}" alt="이벤트 이미지">
                    <div class="event-info">
                        <div class="event-title">${event.eventTitle}</div>
                        <div class="event-date">~ ${event.eventEnddate}</div>
                    </div>
                </a>
            </c:forEach>
        </div>

    </div>
</body>
</html>
