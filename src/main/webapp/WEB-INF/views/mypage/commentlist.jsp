<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내가 쓴 댓글</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<%@ include file="/WEB-INF/views/include/head.jsp" %>   <%-- 공통 head --%>

<style>
/* 기본 링크 스타일 */
a {
  color: black; /* 기본 글자색은 파란색 */
  text-decoration: none; /* 기본 밑줄 제거 */
  transition: color 0.3s; /* 색상 변경 시 0.3초 동안 부드럽게 전환 */
}

/* 마우스를 올렸을 때 스타일 */
a:hover {
  color: dark gray; /* 마우스를 올리면 글자색이 빨간색으로 변경 */
  text-decoration: underline; /* 마우스를 올리면 밑줄 생성 */
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
<div class="container mt-5">
    <h2 class="mb-4">내가 쓴 댓글</h2>
    
    
  <c:choose>
    <c:when test="${empty list}">
      <div class="alert alert-info">작성한 댓글이 없습니다.</div>
    </c:when>
    <c:otherwise>
      <div class="row row-cols-1 row-cols-md-2 g-4">
<c:forEach var="comment" items="${list}">
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
      
      <a href="/editor/planview?planId=${comment.planId}">
		<h3>${comment.planTitle}</h3>
	  </a>
        
        <p class="card-text">${comment.planCommentContent}</p>
		
		<div class="mt-2">
          <small class="text-muted">${comment.planCommentDate}</small>
        </div>
		
      </div>
    </div>
  </div>
</c:forEach>

      </div>
    </c:otherwise>
  </c:choose>
    
    
    
  </div>
</body>
</html>
