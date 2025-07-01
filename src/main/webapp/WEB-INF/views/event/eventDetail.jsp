<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>이벤트 상세</title>
    <style>
        .event-detail-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
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
            max-height: 600px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        .event-content {
            font-size: 16px;
            line-height: 1.6;
            white-space: pre-line;
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

            <div class="event-content">
                ${event.eventContent}
            </div>
        </div>
    </div>
</body>
</html>
