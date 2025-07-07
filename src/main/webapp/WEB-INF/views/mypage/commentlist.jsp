<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>
  <meta charset="UTF-8">
  <title>내가 쓴 댓글</title>
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
      width: 35%;
    }
    .col-content {
      width: 50%;
      text-align: left;
    }
    .col-date {
      width: 30%;
    }
  </style>
  <script>
    function goToPost(planId) {
      location.href = "/editor/planview?planId=" + planId;
    }
  </script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 Header/Nav --%>
  <div class="board-container">
    <h2 class="board-title">내가 쓴 댓글</h2>
    <table class="board-table">
      <thead>
        <tr>
          <th class="col-title">게시글 제목</th>
          <th class="col-content">내용</th>
          <th class="col-date">작성일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="comment" items="${list}">
          <tr onclick="goToPost('${comment.planId}')">
            <td class="col-title">${comment.planTitle}</td>
            <td class="col-content">${comment.planCommentContent}</td>
            <td class="col-date">${comment.planCommentDate}</td>
          </tr>
        </c:forEach>
        <c:if test="${empty list}">
          <tr>
            <td colspan="3">작성한 댓글이 없습니다.</td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
</body>
</html>
