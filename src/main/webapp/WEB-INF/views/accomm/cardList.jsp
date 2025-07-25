<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style>
.card-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 40px 32px;
}

.card {
  position: relative;
  border-radius: 16px;
  overflow: hidden;
  background-color: #fff;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
  transition: transform 0.25s ease, box-shadow 0.25s ease;
}

.card:hover {
  transform: translateY(-6px) scale(1.01);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.12);
}

.card-image {
  position: relative;
  width: 100%;
  padding-top: 90%;
  background-color: #f2f2f2;
  overflow: hidden;
}

.card-image img,
.card-image .no-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.card-image .no-image {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #bbb;
  font-size: 1rem;
  font-weight: 500;
}

.card-title {
  padding: 16px 14px;
  font-size: 16px;
  font-weight: 600;
  color: #111;
  line-height: 1.4;
  background-color: #fff;
}

.heart-btn {
  position: absolute;
  top: 12px;
  right: 12px;
  background: none;
  border: none;
  font-size: 1.4rem;
  cursor: pointer;
  color: #ccc;
  transition: color 0.2s ease;
  z-index: 3;
}

.heart-btn.liked .heart-icon,
.heart-btn:hover .heart-icon {
  color: #ff3b3b;
}

.heart-icon {
  font-size: 1.4rem;
  pointer-events: none;
}

.star-rating-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 5px;
}

.star-left {
  display: flex;
  align-items: center;
  gap: 4px;
}

.rating-number {
  font-size: 14px;
  color: #555;
  margin-left: 4px;
}

.review-count {
  font-size: 13px;
  color: #777;
}

.pagination {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 30px;
  margin-bottom: 40px;
}

.pagination button {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background-color: #fff;
  cursor: pointer;
  border-radius: 6px;
  font-size: 14px;
}

.pagination button.active {
  background-color: #f0f0f0;
  font-weight: bold;
}
</style>

<!-- ★ 카드 리스트 -->
<div class="card-grid">
  <c:forEach var="item" items="${results}">
    <div class="card">
      <!-- 이미지 -->
      <div class="card-image">
        <c:choose>
          <c:when test="${not empty item.firstImage}">
            <img src="${item.firstImage}" alt="${item.accomName}" />
          </c:when>
          <c:otherwise><div class="no-image">NO IMAGE</div></c:otherwise>
        </c:choose>
      </div>

      <!-- 별점 -->
      <fmt:formatNumber value="${item.accomAvg}" maxFractionDigits="1" var="formattedRating" />
      <div class="card-title">
        <div class="star-rating-row">
          <div class="star-left">
            <c:set var="rating" value="${item.accomAvg}" />
            <c:forEach begin="1" end="5" var="i">
              <c:choose>
                <c:when test="${i <= rating}">
                  <i class="bi bi-star-fill text-warning"></i>
                </c:when>
                <c:when test="${i - 1 < rating && rating < i}">
                  <i class="bi bi-star-half text-warning"></i>
                </c:when>
                <c:otherwise>
                  <i class="bi bi-star text-warning"></i>
                </c:otherwise>
              </c:choose>
            </c:forEach>
            <span class="rating-number">(${formattedRating})</span>
          </div>
          <div class="review-count">리뷰갯수: ${item.accommCount}</div>
        </div>
      </div>

      <!-- 숙소 제목 -->
      <div class="card-title">
        <a href="/accomm/accommDetail?accommId=${item.accomId}">${item.accomName}</a>
      </div>

      <!-- 하트 버튼 -->
      <button class="heart-btn"
              data-accom-id="${item.accomId}"
              onclick="toggleAccommLike('${item.accomId}', this)">
        <span class="heart-icon">♡</span>
      </button>
    </div>
  </c:forEach>
</div>

<!-- 페이징 영역 -->
<div class="pagination">
  <c:if test="${hasPrev}">
    <button onclick="fetchFilteredList(${startPage - 1})">◀ 이전</button>
  </c:if>

  <c:forEach begin="${startPage}" end="${endPage}" var="i">
    <button class="${i == currentPage ? 'active' : ''}"
            onclick="fetchFilteredList(${i})">${i}</button>
  </c:forEach>

  <c:if test="${hasNext}">
    <button onclick="fetchFilteredList(${endPage + 1})">다음 ▶</button>
  </c:if>
</div>
