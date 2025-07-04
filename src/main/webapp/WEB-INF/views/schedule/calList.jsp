<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
  max-width: 1200px;  /* 기존 1000px → 넓게 */
  margin: 60px auto;
  padding: 40px 20px;
}
    h2 {
      font-size: 28px;
      font-weight: 700;
      margin-bottom: 24px;
      text-align: left;
      
    }
.list {
  display: grid;
  grid-template-columns: repeat(4, 1fr);  /* 4개 고정 */
  gap: 50px;
  justify-content: center;
}

    .item {
      position: relative;
      width: 100%;
      aspect-ratio: 1 / 1;
      border: 1px solid #ddd;
      border-radius: 12px;
      background: #fafafa;
      transition: box-shadow 0.2s ease;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 20px;
      
    }

    .item:hover {
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .item-info {
      text-align: center;
      flex-grow: 1;
      cursor: pointer;
    }

    .item-info strong {
      font-size: 18px;
      font-weight: 600;
      display: block;
    }

    .item-info span {
      margin-top: 6px;
      font-size: 14px;
      color: #666;
      display: block;
    }

    .review-form {
      position: absolute;
      bottom: 16px;
      right: 20px;
    }

    .btn {
      padding: 6px 12px;
      border: none;
      border-radius: 8px;
      background: #000;
      color: #fff;
      font-size: 14px;
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
      grid-column: 1 / -1;
    }
    .item:hover {
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
  transform: scale(1.02);
  transition: all 0.2s ease-in-out;
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

  <!-- 카드 전체를 링크로 -->
  <div class="item">
  <a href="${pageContext.request.contextPath}/schedule/view?listId=${l.calanderListId}" class="item-info">
    <!-- 아이콘과 제목 -->
    <div style="display: flex; flex-direction: column; align-items: center; gap: 12px;">
      <img src="${pageContext.request.contextPath}/resources/images/note_10819434.png" alt="일정 아이콘" style="width: 40px; height: 40px;" />
      <strong>${l.calanderListName}</strong>
    </div>

    <!-- 날짜 블록 -->
    <div style="margin-top: 10px; background: #eee; padding: 8px 12px; border-radius: 8px; display: inline-block;">
      <fmt:formatDate value="${l.calanderListStartDate}" pattern="yyyy.MM.dd (E)"/>
      ~
      <fmt:formatDate value="${l.calanderListEndDate}" pattern="MM.dd (E)"/>
    </div>
  </a>

<c:if test="${not l.isPlan}">

  <!-- 후기작성 버튼 -->
  <div class="review-form">
    <form action="${pageContext.request.contextPath}/editor/planeditor" method="get">
      <input type="hidden" name="tCalanderListId" value="${l.calanderListId}">
      <button type="submit" class="btn">후기작성</button>
    </form>
  </div>
  
</c:if>
<c:if test="${l.isPlan}">

  <!-- 후기수정 버튼 -->
  <div class="review-form">
    <form action="${pageContext.request.contextPath}/editor/planupdate" method="get">
      <input type="hidden" name="planId" value="${l.planId}">
      <button type="submit" class="btn">후기수정</button>
    </form>
  </div>

</c:if>

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
