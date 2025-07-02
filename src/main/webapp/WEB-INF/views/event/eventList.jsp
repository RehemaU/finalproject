<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>이벤트</title>
    <style>
        .section-title {
            font-size: 24px;
            margin-top: 40px;
            margin-bottom: 20px;
        }
        .event-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 가로로 3개 */
            gap: 24px;
        }
        .event-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
            text-decoration: none;
            color: inherit;
        }
        .event-box img {
            width: 100%;
            height: 220px; /* 기존보다 높게 */
            object-fit: cover;
        }
        .event-info {
            padding: 12px;
        }
        .event-title {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 6px;
        }
        .event-date {
            font-size: 14px;
            color: gray;
        }
    </style>
</head>
<body>
    <div class="wrap">

        <h2 class="section-title" style="display: flex; justify-content: space-between; align-items: center;">
            <span>진행 중인 이벤트</span>
            <a href="${pageContext.request.contextPath}/event/eventBoardList" style="font-size: 14px; color: gray; text-decoration: underline;">더보기</a>
        </h2>

        <div class="event-list">
            <c:forEach var="event" items="${activeEvents}" begin="0" end="5">
                <a href="/event/eventDetail?eventId=${event.eventId}" class="event-box">
                    <img src="${pageContext.request.contextPath}${event.eventThumbnailUrl}" alt="이벤트 이미지">
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
