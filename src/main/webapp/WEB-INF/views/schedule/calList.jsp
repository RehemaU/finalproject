<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <%@ include file="/WEB-INF/views/include/head2.jsp" %>
  <title>내 일정 목록 · MYTRIP</title>
  <style>
    body {
      font-family: 'Pretendard','Inter',sans-serif;
      background: #fff;
      color: #111;
      margin: 0;
      padding: 0;
    }
    .wrapper {
      max-width: 1000px;
      margin: 60px auto;
      padding: 40px 20px;
    }
    h2 {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 24px;
      text-align: center;
    }
    .list {
      display: flex;
      flex-direction: column;
      gap: 18px;
    }
    .item {
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 18px 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      background: #fafafa;
    }
    .item-info {
      display: flex;
      flex-direction: column;
    }
    .item-info strong {
      font-size: 18px;
      font-weight: 600;
    }
    .item-info span {
      margin-top: 4px;
      font-size: 14px;
      color: #666;
    }
    .btn {
      padding: 8px 16px;
      border: none;
      border-radius: 8px;
      background: #000;
      color: #fff;
      font-weight: 600;
      cursor: pointer;
    }
    .btn:hover {
      background: #222;
    }
    .empty-msg {
      text-align: center;
      color: #999;
      font-size: 16px;
      margin-top: 40px;
    }
  </style>
</head>
<body>

  <%@ include file="/WEB-INF/views/include/navigation.jsp" %>

  <div class="wrapper">
    <h2>내가 만든 일정</h2>

    <div class="list">
      <c:choose>
        <c:when test="${not empty lists}">
          <c:forEach var="l" items="${lists}">
            <div class="item">
              <div class="item-info">
                <strong>${l.calanderListName}</strong>
                <span>${l.calanderListStartDate} ~ ${l.calanderListEndDate}</span>
              </div>
              <form action="${pageContext.request.contextPath}/schedule/scheduleList" method="post">
                <input type="hidden" name="listId" value="${l.calanderListId}">
                <button type="submit" class="btn">보기</button>
              </form>
            </div>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <p class="empty-msg">저장된 일정이 없습니다.</p>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

</body>
</html>
