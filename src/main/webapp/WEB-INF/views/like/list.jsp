<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/head2.jsp" %>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>

<style>
  body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #fafafa;
    color: #111;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 48px 24px;
  }

  h2 {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 32px;
    border-bottom: 2px solid #111;
    padding-bottom: 10px;
  }

  .tab-buttons {
    margin-bottom: 32px;
    display: flex;
    gap: 12px;
  }

  .tab-buttons button {
    font-family: 'Noto Sans KR', sans-serif;
    padding: 10px 24px;
    border-radius: 24px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.25s ease;
  }

  .tab-buttons .active {
    background-color: #111;
    color: #fff;
    border: 1px solid #111;
  }

  .tab-buttons .inactive {
    background-color: #fff;
    color: #111;
    border: 1px solid #111;
  }

  .card-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 28px;
  }

  .card {
    background: #fff;
    border: 1px solid #ebebeb;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04);
    transition: transform 0.3s ease;
  }

  .card:hover {
    transform: translateY(-6px);
  }

  .card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    background-color: #f5f5f5;
  }

  .card-content {
    padding: 20px;
  }

  .card-content h3 {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 8px;
    color: #111;
  }

  .card-content p {
    font-size: 14px;
    color: #555;
    line-height: 1.5;
  }

  .no-data {
    text-align: center;
    color: #888;
    margin-top: 80px;
    font-size: 16px;
  }
</style>

<div class="container">
  <h2>내가 좋아요한 장소</h2>

  <!-- 탭 버튼 -->
  <div class="tab-buttons">
    <button id="tourTabBtn" class="active" onclick="showTab('tour')">관광지</button>
    <button id="accommTabBtn" class="inactive" onclick="showTab('accomm')">숙소</button>
  </div>

  <!-- 관광지 찜 목록 -->
  <div id="tourTab">
    <c:choose>
      <c:when test="${empty likedTourList}">
        <p class="no-data">관광지 찜 목록이 없습니다.</p>
      </c:when>
      <c:otherwise>
        <div class="card-grid">
          <c:forEach var="item" items="${likedTourList}">
            <div class="card">
              <c:choose>
                <c:when test="${not empty item.tourImage}">
                  <img src="${item.tourImage}" alt="${item.tourName}">
                </c:when>
                <c:otherwise>
                  <div style="width:100%; height:200px; background:#f2f2f2; display:flex; align-items:center; justify-content:center;">
                    <span style="color:#bbb;">No Image</span>
                  </div>
                </c:otherwise>
              </c:choose>
              <div class="card-content">
                <h3>${item.tourName}</h3>
                <p>${item.tourAdd}</p>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <!-- 숙소 찜 목록 -->
  <div id="accommTab" style="display:none;">
    <c:choose>
      <c:when test="${empty likedAccommList}">
        <p class="no-data">숙소 찜 목록이 없습니다.</p>
      </c:when>
      <c:otherwise>
        <div class="card-grid">
          <c:forEach var="item" items="${likedAccommList}">
            <div class="card">
              <c:choose>
                <c:when test="${not empty item.firstImage}">
                  <img src="${item.firstImage}" alt="${item.accomName}">
                </c:when>
                <c:otherwise>
                  <div style="width:100%; height:200px; background:#f2f2f2; display:flex; align-items:center; justify-content:center;">
                    <span style="color:#bbb;">No Image</span>
                  </div>
                </c:otherwise>
              </c:choose>
              <div class="card-content">
                <h3>${item.accomName}</h3>
                <p>${item.accomAdd}</p>
              </div>
            </div>
          </c:forEach>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script>
  function showTab(type) {
    const tourTab = document.getElementById('tourTab');
    const accommTab = document.getElementById('accommTab');
    const tourBtn = document.getElementById('tourTabBtn');
    const accommBtn = document.getElementById('accommTabBtn');

    if (type === 'tour') {
      tourTab.style.display = 'block';
      accommTab.style.display = 'none';
      tourBtn.className = 'active';
      accommBtn.className = 'inactive';
    } else {
      tourTab.style.display = 'none';
      accommTab.style.display = 'block';
      tourBtn.className = 'inactive';
      accommBtn.className = 'active';
    }
  }
</script>
