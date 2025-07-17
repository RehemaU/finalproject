<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>나의 리뷰 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<%@ include file="/WEB-INF/views/include/head.jsp" %> <%-- Bootstrap 포함되어 있다고 가정 --%>

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

</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %> <%-- 공통 헤더/네비게이션 --%>
<div class="container mt-5">
  <h2 class="mb-4">나의 리뷰 목록</h2>

  <c:choose>
    <c:when test="${empty list}">
      <div class="alert alert-info">작성한 리뷰가 없습니다.</div>
    </c:when>
    <c:otherwise>
      <div class="row row-cols-1 row-cols-md-2 g-4">
<c:forEach var="review" items="${list}">
  <div class="col">
    <div class="card h-100">
      <div class="card-body">
      
        <div class="mt-2">
         <a href="/mypage/orderdetail?orderId=${review.orderId}">
          <small class="text-muted">주문 ID: ${review.orderId}</small>
         </a>
        </div>
        
        <!-- 별점 출력 -->
        <div>
        <a href="/accomm/accommDetail?accommId=${review.accommId}">
        ${review.accommName}
        </a>
        &nbsp;&nbsp;
          <c:set var="rating" value="${review.accommReviewRating}" />
          <c:forEach begin="1" end="5" var="i">
            <c:choose>
              <c:when test="${i <= rating}">
                <i class="bi bi-star-fill text-warning"></i>
              </c:when>
              <c:otherwise>
                <i class="bi bi-star text-warning"></i>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </div>
        
        <p class="card-text">${review.accommReviewContent}</p>

        <!-- 삭제 버튼 -->
        <div class="mt-3 text-end">
            <a onclick="deleteReview('${review.accommReviewId}')"
			   class="btn btn-sm btn-outline-dark text-dark">
			  <i class="bi bi-trash"></i> 삭제
			</a>
        </div>
      </div>
    </div>
  </div>
</c:forEach>

      </div>
    </c:otherwise>
  </c:choose>
</div>

<form id="reviewForm">
  <input type="hidden" id="reviewId" name="reviewId">
</form>

<!-- Bootstrap + Bootstrap Icons -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
function deleteReview(reviewId) {

  document.getElementById('reviewId').value = reviewId;

  const form = document.getElementById('reviewForm');

  const formData = new FormData(form);

  fetch('/mypage/reviewdelete', {
	    method: 'POST',
	    body: formData
	  })
	  .then(res => res.json())
	  .then(data => {
	    if(data.code === 0) {
	      alert("리뷰 삭제 완료!");
	      location.reload();
	    } else if(data.code === -1) {
	    	alert("리뷰 삭제 실패.");
	    	location.reload();
	    } else {
	      alert("리뷰 삭제 실패: " + data.message);
	      location.reload();
	    }
	  })
	  .catch(err => {
	    console.error(err);
	    alert("서버 오류 발생");
	  });
}
</script>

</body>
</html>
