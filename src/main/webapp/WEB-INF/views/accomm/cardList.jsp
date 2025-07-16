<!-- 카드 리스트 출력 영역 -->
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

      <!-- 별점 영역 -->
      <fmt:formatNumber value="${item.rating}" maxFractionDigits="1" var="formattedRating" />
      <div class="card-title">
        <div class="star-rating-row">
          <div class="star-left">
            <c:set var="rating" value="${item.rating}" />
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

<!-- ✅ 페이징 UI 추가 -->
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
