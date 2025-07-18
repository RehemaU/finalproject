<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
  <meta charset="UTF-8">
  <title>내가 쓴 게시글</title>
  <style>
    .board-container {
      max-width: 900px;
      margin: 40px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }
    .board-title {
      font-size: 24px;
      margin-bottom: 20px;
      text-align: center;
    }
    .board-table {
      width: 100%;
      border-collapse: collapse;
      table-layout: fixed;
    }
    .board-table th {
      background-color: #f8f8f8;
      border-bottom: 2px solid #ddd;
      padding: 12px;
      text-align: center;
    }
    .board-table td {
      border-bottom: 1px solid #eee;
      padding: 12px;
      text-align: center;
      word-wrap: break-word;
      cursor: pointer;
    }
    .board-table tr:hover {
      background-color: #f1f1f1;
    }
    /* 폭 재조정 */
    .col-title {
      width: 55%;
      text-align: center;
    }
    .col-count {
      width: 10%;
    }
    .col-view {
      width: 10%;
    }
    .col-date {
      width: 25%;
    }
  </style>
  <script>
    function goView(planId) {
      location.href = "/editor/planview?planId=" + planId;
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="board-container">
    <h2 class="board-title">내가 쓴 게시글</h2>
    <table class="board-table">
      <thead>
        <tr>
          <th class="col-title">제목</th>
          <th class="col-count">추천수</th>
          <th class="col-view">조회수</th>
          <th class="col-date">작성일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="editor" items="${list}">
          <tr onclick="goView('${editor.planId}')">
            <td class="col-title">${editor.planTitle}</td>
            <td class="col-count">${editor.planRecommend}</td>
            <td class="col-view">${editor.planCount}</td>
            <td class="col-date">${editor.planRegdate}</td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}">
          <tr>
            <td colspan="4">작성한 게시글이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</body>
</html>
