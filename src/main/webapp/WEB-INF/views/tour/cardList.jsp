<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr), repeat(4, 1fr));  
  gap: 32px;
}

/* 카드 박스 */
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

/* 이미지 */
.card-image {
  position: relative;
  width: 100%;
  padding-top: 90%; /* 3:4 비율 */
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

/* 제목 영역 */
.card-title {
  padding: 16px 14px;
  font-size: 16px;
  font-weight: 600;
  color: #111;
  line-height: 1.4;
  background-color: #fff;
}

/* 하트 버튼 */
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
</style>

<!-- 카드 HTML --><!-- 관광지 카드 리스트 -->
<div class="card-grid">
  <c:forEach var="item" items="${results}">
    <div class="card">
      <!-- 이미지 -->
      <div class="card-image">
        <c:choose>
          <c:when test="${not empty item.tourImage}">
            <img src="${item.tourImage}" alt="${item.tourName}" />
          </c:when>
          <c:otherwise>
            <div class="no-image">NO IMAGE</div>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- 제목 -->
      <div class="card-title">
        <h3>${item.tourName}</h3>
      </div>

      <!-- 하트 버튼 -->
      <button class="heart-btn"
              data-spot-id="${item.tourId}"
              onclick="toggleLike('${item.tourId}', this)">
        <span class="heart-icon">♡</span>
      </button>
    </div>
  </c:forEach>
</div>