<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2>내가 쓴 게시글</h2>
<table style="width:100%; border-collapse:collapse;">
  <thead>
    <tr>
      <th style="padding:10px; border:1px solid #ddd;">제목</th>
      <th style="padding:10px; border:1px solid #ddd;">추천수</th>
      <th style="padding:10px; border:1px solid #ddd;">조회수</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="editor" items="${list}">
      <tr>
        <td style="padding:10px; border:1px solid #ddd; text-align:left;">
          <a href="/editor/planview?planId=${editor.planId}">
            ${editor.planTitle}
          </a>
        </td>
        <td style="padding:10px; border:1px solid #ddd;">${editor.planRecommend}</td>
        <td style="padding:10px; border:1px solid #ddd;">${editor.planCount}</td>
      </tr>
    </c:forEach>
    <c:if test="${empty list}">
      <tr>
        <td colspan="3" style="padding:10px; border:1px solid #ddd;">작성한 게시글이 없습니다.</td>
      </tr>
    </c:if>
  </tbody>
</table>
