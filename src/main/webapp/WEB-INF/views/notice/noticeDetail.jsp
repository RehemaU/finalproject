<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>공지사항 상세</title>
    <style>
        .notice-detail-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 20px;
            position: relative;
        }
        .notice-title {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .notice-date {
            color: #777;
            margin-bottom: 30px;
        }
        .notice-content {
            font-size: 16px;
            line-height: 1.6;
            white-space: pre-line;
        }
    </style>
</head>
<body>
    <div class="wrap">
        <div class="notice-detail-container">
            <div class="notice-title">${notice.noticeTitle}</div>
            <div class="notice-date">
                작성일: <td><c:out value="${fn:substring(notice.noticeRegdate, 0, 10)}" /></td>
            </div>
            <div class="notice-content">
                <c:out value="${notice.noticeContent}" />
            </div>
        </div>
    </div>
</body>
</html>