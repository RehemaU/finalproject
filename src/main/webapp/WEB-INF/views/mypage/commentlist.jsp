<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h3>댓글 목록</h3>
<table style="width:100%; border-collapse:collapse;">
  <thead>
    <tr>
      <th style="padding:8px; border:1px solid #ddd;">작성자</th>
      <th style="padding:8px; border:1px solid #ddd;">내용</th>
      <th style="padding:8px; border:1px solid #ddd;">작성일</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="comment" items="${list}">
      <tr>
        <td style="padding:8px; border:1px solid #ddd;">${comment.userId}</td>
        <td style="padding:8px; border:1px solid #ddd; text-align:left;">
          ${comment.planCommentContent}
        </td>
        <td style="padding:8px; border:1px solid #ddd;">
          ${comment.planCommentDate}
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty list}">
      <tr>
        <td colspan="3" style="padding:8px; border:1px solid #ddd;">
          작성된 댓글이 없습니다.
        </td>
      </tr>
    </c:if>
  </tbody>
</table>
